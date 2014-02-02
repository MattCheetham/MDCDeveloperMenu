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
    [self.deviceLogs addObject:log];
}

@end
