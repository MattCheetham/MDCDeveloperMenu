//
//  MDCLogController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLog.h"

#define MDCLog(string, MDCLogLevel) [[MDCLogController sharedController] addLog:(string) withLevel:(MDCLogLevel)];

@interface MDCLogController : NSObject

+ (MDCLogController *)sharedController;

- (void)addLog:(NSString *)logContent withLevel:(MDCLogLevel)logLevel;

@end
