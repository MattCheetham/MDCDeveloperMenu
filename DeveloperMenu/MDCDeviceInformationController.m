//
//  MDCDeviceInformationController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeviceInformationController.h"
#import "MDCDeviceInformationItem.h"

@interface MDCDeviceInformationController ()

@property (nonatomic, strong) UIDevice *currentDevice;

@end

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
        self.currentDevice = [UIDevice currentDevice];
        
        [self populateDeviceInformation];
        
    }
    return self;
}

- (void)populateDeviceInformation
{
    MDCDeviceInformationItem *deviceName = [MDCDeviceInformationItem itemWithProperty:@"Name" value:self.currentDevice.name];
    MDCDeviceInformationItem *deviceMultiTaskingSupport = [MDCDeviceInformationItem itemWithProperty:@"Multitasking Supported" value:self.currentDevice.multitaskingSupported ? @"Yes" : @"No"];
    MDCDeviceInformationItem *deviceSystemName = [MDCDeviceInformationItem itemWithProperty:@"System Name" value:self.currentDevice.systemName];
    MDCDeviceInformationItem *deviceSystemVersion = [MDCDeviceInformationItem itemWithProperty:@"System Version" value:self.currentDevice.systemVersion];
    
    [self.deviceInformationItems addObjectsFromArray:@[deviceName, deviceMultiTaskingSupport, deviceSystemName, deviceSystemVersion]];
}

@end
