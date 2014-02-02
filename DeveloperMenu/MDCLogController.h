//
//  MDCLogController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLog.h"

#define MDCLogDebug(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelDebug];
#define MDCLogInfo(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelInfo];
#define MDCLogNotice(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelNotice];
#define MDCLogWarning(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelWarning];
#define MDCLogErr(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelErr];
#define MDCLogCrit(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelCrit];
#define MDCLogAlert(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelAlert];
#define MDCLogEmerg(string) [[MDCLogController sharedController] addLog:(string) withLevel:MDCLogLevelEmerg];


@interface MDCLogController : NSObject

+ (MDCLogController *)sharedController;

- (void)addLog:(NSString *)logContent withLevel:(MDCLogLevel)logLevel;

@end
