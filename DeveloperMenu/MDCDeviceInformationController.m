//
//  MDCDeviceInformationController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeviceInformationController.h"
#import "MDCDeviceInformationItem.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface MDCDeviceInformationController ()

@property (nonatomic, strong) UIDevice *currentDevice;
@property (nonatomic, strong) CTTelephonyNetworkInfo *telephonyInfo;

@end

@implementation MDCDeviceInformationController

static MDCDeviceInformationController *sharedController = nil;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceBatteryStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTRadioAccessTechnologyDidChangeNotification object:nil];
}

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
        self.telephonyInfo = [CTTelephonyNetworkInfo new];
        
        [self populateDeviceInformation];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateDeviceInformation) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateDeviceInformation) name:UIDeviceBatteryStateDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateDeviceInformation) name:CTRadioAccessTechnologyDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)populateDeviceInformation
{
    [self willChangeValueForKey:@"deviceInformationItems"];
    [self.deviceInformationItems removeAllObjects];
    
    MDCDeviceInformationItem *deviceName = [MDCDeviceInformationItem itemWithProperty:@"Name" value:self.currentDevice.name category:@"General"];
    MDCDeviceInformationItem *deviceMultiTaskingSupport = [MDCDeviceInformationItem itemWithProperty:@"Multitasking Supported" value:self.currentDevice.multitaskingSupported ? @"Yes" : @"No" category:@"General"];
    MDCDeviceInformationItem *deviceSystemName = [MDCDeviceInformationItem itemWithProperty:@"System Name" value:self.currentDevice.systemName category:@"General"];
    MDCDeviceInformationItem *deviceSystemVersion = [MDCDeviceInformationItem itemWithProperty:@"System Version" value:self.currentDevice.systemVersion category:@"General"];
    MDCDeviceInformationItem *deviceModel = [MDCDeviceInformationItem itemWithProperty:@"Model" value:self.currentDevice.model category:@"General"];
    MDCDeviceInformationItem *deviceIdentifierForVendor = [MDCDeviceInformationItem itemWithProperty:@"Identifier For Vendor" value:self.currentDevice.identifierForVendor.UUIDString category:@"General"];
    
    //Enable battery monitoring
    self.currentDevice.batteryMonitoringEnabled = YES;
    
    MDCDeviceInformationItem *deviceBatteryLevel = [MDCDeviceInformationItem itemWithProperty:@"Battery Level" value:[NSString stringWithFormat:@"%.0f%%", self.currentDevice.batteryLevel * 100] category:@"Battery"];
    MDCDeviceInformationItem *deviceBatteryState = [MDCDeviceInformationItem itemWithProperty:@"Battery State" value:[self stringForBatteryState:self.currentDevice.batteryState] category:@"Battery"];
    
    //Carrier information
    CTCarrier *carrierInfo = self.telephonyInfo.subscriberCellularProvider;
    
    MDCDeviceInformationItem *deviceCarrierName = [MDCDeviceInformationItem itemWithProperty:@"Carrier" value:carrierInfo.carrierName category:@"General"];
    MDCDeviceInformationItem *deviceNetworkSpeed = [MDCDeviceInformationItem itemWithProperty:@"Network Speed" value:[self localisedStringForNetworkSpeed:self.telephonyInfo.currentRadioAccessTechnology] category:@"General"];
    MDCDeviceInformationItem *deviceVOIPEnabled = [MDCDeviceInformationItem itemWithProperty:@"VOIP Allowed" value:carrierInfo.allowsVOIP ? @"Yes" : @"No" category:@"General"];
    
    [self.deviceInformationItems addObjectsFromArray:@[deviceName, deviceMultiTaskingSupport, deviceSystemName, deviceSystemVersion, deviceModel, deviceIdentifierForVendor, deviceBatteryLevel, deviceBatteryState, deviceCarrierName, deviceNetworkSpeed, deviceVOIPEnabled]];
    
    //Wifi information
    NSArray *networkInterfaces = (id)CFBridgingRelease(CNCopySupportedInterfaces());
    
    NSString *interface = networkInterfaces[0];
    CFDictionaryRef networkDetails = CNCopyCurrentNetworkInfo((CFStringRef) CFBridgingRetain(interface));
    if (networkDetails) {
        NSDictionary *networkInfo = (NSDictionary *)CFBridgingRelease(networkDetails);
        MDCDeviceInformationItem *deviceWifiSSID = [MDCDeviceInformationItem itemWithProperty:@"SSID" value:networkInfo[@"SSID"] category:@"General"];
        MDCDeviceInformationItem *deviceWifiBSSID = [MDCDeviceInformationItem itemWithProperty:@"BSSID" value:networkInfo[@"BSSID"] category:@"General"];
        [self.deviceInformationItems addObjectsFromArray:@[deviceWifiSSID, deviceWifiBSSID]];
    }
    
    [self didChangeValueForKey:@"deviceInformationItems"];
}

#pragma mark - Convenience methods for conversion

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

- (NSString *)localisedStringForNetworkSpeed:(NSString *)currentRadioAccessTechnologyString
{
    return [currentRadioAccessTechnologyString stringByReplacingOccurrencesOfString:@"CTRadioAccessTechnology" withString:@""];
}

- (NSArray *)deviceInformationCategoryKeys
{
    NSMutableArray *deviceItemKeys = [NSMutableArray array];
    for (MDCDeviceInformationItem *item in self.deviceInformationItems){
        
        if(![deviceItemKeys containsObject:item.devicePropertyCategory]){
            [deviceItemKeys addObject:item.devicePropertyCategory];
        }
        
    }
    
    return deviceItemKeys;
}

- (NSString *)deviceInformationCategoryKeyForSection:(int)index
{
    return [self deviceInformationCategoryKeys][index];
}

- (NSArray *)deviceInformationitemsForSectionIndex:(int)index
{
    NSString *deviceInfoKey = [self deviceInformationCategoryKeys][index];
    
    NSMutableArray *deviceItems = [NSMutableArray array];
    for (MDCDeviceInformationItem *item in self.deviceInformationItems){
        
        if([item.devicePropertyCategory isEqualToString:deviceInfoKey]){
            
            [deviceItems addObject:item];
            
        }
        
    }
    
    return deviceItems;
}

@end
