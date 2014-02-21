//
//  MDCLogController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLogController.h"
#import "MDCDeviceInformationController.h"
#import "MDCDeviceInformationItem.h"

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

- (void)addLogWithLevel:(MDCLogLevel)logLevel function:(const char *)function logContent:(NSString *)logContent, ...
{
    va_list args;
    va_start(args, logContent);
    NSString *message = [[NSString alloc] initWithFormat:logContent
                                               arguments:args];
    va_end(args);
    
    MDCLog *log = [MDCLog logWithContent:[NSString stringWithFormat:@"%s %@", function, message] content:logLevel];
    [self willChangeValueForKey:@"deviceLogs"];
    [self.deviceLogs addObject:log];
    [self didChangeValueForKey:@"deviceLogs"];
}

- (void)generateLogFileWithCompletion:(MDCCreateLogCompletion)completion
{
    //Setup file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSURL *documentsURL = [NSURL URLWithString:documentsDirectory];
    
    NSString *fileName = [NSString stringWithFormat:@"log_%.0f", [NSDate timeIntervalSinceReferenceDate]];
    NSURL *destinationURL = [documentsURL URLByAppendingPathComponent:fileName];
    
    NSError *fileCreateError;
    [[NSFileManager defaultManager] createFileAtPath:[destinationURL path] contents:nil attributes:nil];
    
    //Setup string
    NSMutableString *logContents = [NSMutableString string];
    
    [logContents appendString:@"Device information\n\n"];
    
    //Add device info to string
    MDCDeviceInformationController *deviceInfoController = [MDCDeviceInformationController sharedController];
    for(MDCDeviceInformationItem *deviceInfoItem in deviceInfoController.deviceInformationItems)
    {
        [logContents appendFormat:@"%@: %@\n", deviceInfoItem.deviceProperty, deviceInfoItem.deviceValue];
    }
    
    [logContents appendString:@"\n\nDevice Logs\n"];
    
    //Add device logs to string
    for(MDCLog *deviceLog in self.deviceLogs){
        
        [logContents appendFormat:@"%@\n", [deviceLog logContentWithLevelPrefix]];
        
    }
    
    //Add plist info
    
    [logContents appendFormat:@"\n\nInfo Plist\n%@", [[NSBundle mainBundle] infoDictionary]];
        
    if(fileCreateError){
        completion(nil, fileCreateError);
    }
    
    //Write data to file
    NSError *dataWritingError;
    [logContents writeToFile:[destinationURL path] atomically:YES encoding:NSUTF8StringEncoding error:&dataWritingError];
    
    completion(destinationURL, dataWritingError);
}

@end
