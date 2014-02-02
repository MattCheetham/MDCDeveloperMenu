//
//  MDCLog.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLog.h"

@implementation MDCLog

+ (MDCLog *)logWithLevel:(MDCLogLevel)logLevel content:(NSString *)logContent
{
    MDCLog *log = [MDCLog new];
    log.logLevel = logLevel;
    log.logContent = logContent;
    log.logTime = [NSDate date];
    
    return log;
}

@end
