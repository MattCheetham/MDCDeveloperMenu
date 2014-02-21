//
//  MDCLogController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLogController.h"

@interface MDCLogController ()

@end

@implementation MDCLogController

static MDCLogController *sharedController = nil;

+ (MDCLogController *)sharedController
{
    @synchronized(self) {
        if (sharedController == nil) {
            sharedController = [[self alloc] init];
        }
    }
    return sharedController;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.deviceLogs = [NSMutableArray array];
        
    }
    return self;
}

- (void)addLogWithLevel:(MDCLogLevel)logLevel logContent:(NSString *)logContent, ...
{
    va_list args;
    va_start(args, logContent);
    NSString *message = [[NSString alloc] initWithFormat:logContent
                                               arguments:args];
    va_end(args);
    
    MDCLog *log = [MDCLog logWithContent:message content:logLevel];
    [self willChangeValueForKey:@"deviceLogs"];
    [self.deviceLogs addObject:log];
    [self didChangeValueForKey:@"deviceLogs"];
}

- (void)generateLogFileWithCompletion:(MDCCreateLogCompletion)completion
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSURL *documentsURL = [NSURL URLWithString:documentsDirectory];
    
    NSString *fileName = [NSString stringWithFormat:@"log_%.0f", [NSDate timeIntervalSinceReferenceDate]];
    NSURL *destinationURL = [documentsURL URLByAppendingPathComponent:fileName];
    
    NSError *writeError;
    [[NSFileManager defaultManager] createFileAtPath:[destinationURL path] contents:nil attributes:nil];
    
    completion(destinationURL, writeError);
}

@end
