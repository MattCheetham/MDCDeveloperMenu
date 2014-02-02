//
//  MDCLogController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLog.h"

/*
MDCLogDebug
The lowest priority, and normally not logged except for messages from the kernel.
--
MDCLogInfo
The lowest priority that you would normally log, and purely informational in nature.
--
MDCLogNotice
Things of moderate interest to the user or administrator.
--
MDCLogWarning
Something is amiss and might fail if not corrected.
--
MDCLogErr
Something has failed.
--
MDCLogCrit
A failure in a key system.
--
MDCLogAlert
A serious failure in a key system.
--
MDCLogEmerg
The highest priority, usually reserved for catastrophic failures and reboot notices.
*/

#define MDCLogDebug(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelDebug logContent:format, ##__VA_ARGS__];
#define MDCLogInfo(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelInfo logContent:format, ##__VA_ARGS__];
#define MDCLogNotice(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelNotice logContent:format, ##__VA_ARGS__];
#define MDCLogWarning(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelWarning logContent:format, ##__VA_ARGS__];
#define MDCLogErr(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelErr logContent:format, ##__VA_ARGS__];
#define MDCLogCrit(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelCrit logContent:format, ##__VA_ARGS__];
#define MDCLogAlert(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelAlert logContent:format, ##__VA_ARGS__];
#define MDCLogEmerg(format, ...) [[MDCLogController sharedController] addLogWithLevel:MDCLogLevelEmerg logContent:format, ##__VA_ARGS__];


@interface MDCLogController : NSObject

@property (nonatomic, strong) NSMutableArray *deviceLogs;

+ (MDCLogController *)sharedController;

- (void)addLogWithLevel:(MDCLogLevel)logLevel logContent:(NSString *)logContent, ...;
@end
