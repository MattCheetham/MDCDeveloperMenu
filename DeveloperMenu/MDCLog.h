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

+ (MDCLog *)logWithContent:(NSString *)logContent content:(MDCLogLevel)logLevel;

@end
