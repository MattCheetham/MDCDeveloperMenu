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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateDeviceInformation) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateDeviceInformation) name:UIDeviceBatteryStateDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)populateDeviceInformation
{
    [self willChangeValueForKey:@"deviceInformationItems"];
    [self.deviceInformationItems removeAllObjects];
    
    MDCDeviceInformationItem *deviceName = [MDCDeviceInformationItem itemWithProperty:@"Name" value:self.currentDevice.name];
    MDCDeviceInformationItem *deviceMultiTaskingSupport = [MDCDeviceInformationItem itemWithProperty:@"Multitasking Supported" value:self.currentDevice.multitaskingSupported ? @"Yes" : @"No"];
    MDCDeviceInformationItem *deviceSystemName = [MDCDeviceInformationItem itemWithProperty:@"System Name" value:self.currentDevice.systemName];
    MDCDeviceInformationItem *deviceSystemVersion = [MDCDeviceInformationItem itemWithProperty:@"System Version" value:self.currentDevice.systemVersion];
    MDCDeviceInformationItem *deviceModel = [MDCDeviceInformationItem itemWithProperty:@"Model" value:self.currentDevice.model];
    MDCDeviceInformationItem *deviceIdentifierForVendor = [MDCDeviceInformationItem itemWithProperty:@"Identifier For Vendor" value:self.currentDevice.identifierForVendor.UUIDString];
    
    //Enable battery monitoring
    self.currentDevice.batteryMonitoringEnabled = YES;
    
    MDCDeviceInformationItem *deviceBatteryLevel = [MDCDeviceInformationItem itemWithProperty:@"Battery Level" value:[NSString stringWithFormat:@"%.0f%%", self.currentDevice.batteryLevel * 100]];
    MDCDeviceInformationItem *deviceBatteryState = [MDCDeviceInformationItem itemWithProperty:@"Battery State" value:[self stringForBatteryState:self.currentDevice.batteryState]];
        
    [self.deviceInformationItems addObjectsFromArray:@[deviceName, deviceMultiTaskingSupport, deviceSystemName, deviceSystemVersion, deviceModel, deviceIdentifierForVendor, deviceBatteryLevel, deviceBatteryState]];
    [self didChangeValueForKey:@"deviceInformationItems"];
}

- (NSString *)stringForBatteryState:(UIDeviceBatteryState)batteryState
{
    switch (batteryState) {
        case UIDeviceBatteryStateCharging:
            return @"Charging";
            break;
        case UIDeviceBatteryStateFull:
            return @"Full";
            break;
        case UIDeviceBatteryStateUnplugged:
            return @"Unplugged";
            break;
        case UIDeviceBatteryStateUnknown:
            return @"Unknown";
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

@end
