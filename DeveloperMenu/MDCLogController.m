//
//  MDCLogController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLogController.h"

@interface MDCLogController ()

@property (nonatomic, strong) NSMutableArray *deviceLogs;

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

- (void)addLog:(NSString *)logContent withLevel:(MDCLogLevel)logLevel
{
    MDCLog *log = [MDCLog logWithLevel:logLevel content:logContent];
    [self.deviceLogs addObject:log];
}

@end
