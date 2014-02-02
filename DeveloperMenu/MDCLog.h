//
//  MDCLog.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MDCLogLevelTrace = 0,
    MDCLogLevelDebug = 1,
    MDCLogLevelInfo = 2,
    MDCLogLevelWarn = 3,
    MDCLogLevelError = 4,
    MDCLogLevelFatal = 5
} MDCLogLevel;

@interface MDCLog : NSObject

@property (nonatomic, assign) MDCLogLevel logLevel;
@property (nonatomic, strong) NSString *logContent;
@property (nonatomic, strong) NSDate *logTime;

+ (MDCLog *)logWithLevel:(MDCLogLevel)logLevel content:(NSString *)logContent;

@end
