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

#define MDCLogDebug(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelDebug];
#define MDCLogInfo(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelInfo];
#define MDCLogNotice(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelNotice];
#define MDCLogWarning(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelWarning];
#define MDCLogErr(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelErr];
#define MDCLogCrit(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelCrit];
#define MDCLogAlert(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelAlert];
#define MDCLogEmerg(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelEmerg];


@interface MDCLogController : NSObject

@property (nonatomic, strong) NSMutableArray *deviceLogs;

+ (MDCLogController *)sharedController;

- (void)addLog:(NSString *)logContent withLevel:(MDCLogLevel)logLevel;

@end
