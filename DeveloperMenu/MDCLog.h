//
//  MDCLog.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#include <asl.h>

typedef enum {
    MDCLogLevelEmerg = ASL_LEVEL_EMERG,
    MDCLogLevelAlert = ASL_LEVEL_ALERT,
    MDCLogLevelCrit = ASL_LEVEL_CRIT,
    MDCLogLevelErr = ASL_LEVEL_ERR,
    MDCLogLevelWarning = ASL_LEVEL_WARNING,
    MDCLogLevelNotice = ASL_LEVEL_NOTICE,
    MDCLogLevelInfo = ASL_LEVEL_INFO,
    MDCLogLevelDebug = ASL_LEVEL_DEBUG
} MDCLogLevel;

@interface MDCLog : NSObject

@property (nonatomic, assign) MDCLogLevel logLevel;
@property (nonatomic, strong) NSString *logContent;
@property (nonatomic, strong) NSDate *logTime;

/**
 Used for log information for use on the log controller. This method will generally not need to be called manually but should instead by used with a MDCLog macro.
 @param logContent A string containing the information you wish to log to the console
 @param logLevel A enum of MDCLogLevel describing the severity of the log
 @return MDCLog for use in the log controller
 **/
+ (MDCLog *)logWithContent:(NSString *)logContent content:(MDCLogLevel)logLevel;

/**
 Creates an NSString from the current object's log level and log content suitable for console output
 @return NSString properly formatted for console output (e.g. <Debug> Testing)
 **/
- (NSString *)logContentWithLevelPrefix;

/**
 Creates an NSString from the current object's timestamp suitable for displaying in a log viewer
 @return Formatted date string
 **/
- (NSString *)friendlyTimeAndDate;

@end
