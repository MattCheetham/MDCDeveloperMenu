//
//  MDCLog.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLog.h"

@implementation MDCLog

+ (MDCLog *)logWithContent:(NSString *)logContent content:(MDCLogLevel)logLevel
{
    MDCLog *log = [MDCLog new];
    log.logLevel = logLevel;
    log.logContent = logContent;
    log.logTime = [NSDate date];
    
    //This is called to ensure that we see the logs in our console
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        asl_add_log_file(NULL, STDERR_FILENO);
    });
    
    //Print log
    asl_log(NULL, NULL, logLevel, "%s", [logContent UTF8String]);
    
    return log;
}

@end
