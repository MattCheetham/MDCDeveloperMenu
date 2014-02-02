//
//  MDCDeviceInformationController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeviceInformationController.h"

@implementation MDCDeviceInformationController

static MDCDeviceInformationController *sharedController = nil;

+ (MDCDeviceInformationController *)sharedController
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
        
        self.deviceInformationItems = [NSMutableArray array];
        
    }
    return self;
}

@end
