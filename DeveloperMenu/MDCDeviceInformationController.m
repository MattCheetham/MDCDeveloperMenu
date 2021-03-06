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
#import <sys/utsname.h>
#include <sys/param.h>
#include <sys/mount.h>

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
        self.currentDevice.batteryMonitoringEnabled = YES;
        
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
    
    //General
    MDCDeviceInformationItem *deviceName = [MDCDeviceInformationItem itemWithProperty:@"Name" value:self.currentDevice.name category:@"General"];
    MDCDeviceInformationItem *deviceModel = [MDCDeviceInformationItem itemWithProperty:@"Model" value:[self localisedDeviceModel] category:@"General"];
    MDCDeviceInformationItem *deviceSystemVersion = [MDCDeviceInformationItem itemWithProperty:@"System Version" value:self.currentDevice.systemVersion category:@"General"];
    MDCDeviceInformationItem *deviceMultiTaskingSupport = [MDCDeviceInformationItem itemWithProperty:@"Multitasking Supported" value:self.currentDevice.multitaskingSupported ? @"Yes" : @"No" category:@"General"];
    MDCDeviceInformationItem *deviceIdentifierForVendor = [MDCDeviceInformationItem itemWithProperty:@"Identifier For Vendor" value:self.currentDevice.identifierForVendor.UUIDString category:@"General"];
    
    //Battery
    MDCDeviceInformationItem *deviceBatteryLevel = [MDCDeviceInformationItem itemWithProperty:@"Battery Level" value:[NSString stringWithFormat:@"%.0f%%", self.currentDevice.batteryLevel * 100] category:@"Battery"];
    MDCDeviceInformationItem *deviceBatteryState = [MDCDeviceInformationItem itemWithProperty:@"Battery State" value:[self stringForBatteryState:self.currentDevice.batteryState] category:@"Battery"];
    
    //Carrier information
    CTCarrier *carrierInfo = self.telephonyInfo.subscriberCellularProvider;
    
    MDCDeviceInformationItem *deviceCarrierName = [MDCDeviceInformationItem itemWithProperty:@"Carrier" value:carrierInfo.carrierName category:@"Carrier"];
    MDCDeviceInformationItem *deviceNetworkSpeed = [MDCDeviceInformationItem itemWithProperty:@"Network Speed" value:[self localisedStringForNetworkSpeed:self.telephonyInfo.currentRadioAccessTechnology] category:@"Carrier"];
    MDCDeviceInformationItem *deviceVOIPEnabled = [MDCDeviceInformationItem itemWithProperty:@"VOIP Allowed" value:carrierInfo.allowsVOIP ? @"Yes" : @"No" category:@"Carrier"];
    
    [self.deviceInformationItems addObjectsFromArray:@[deviceName, deviceModel, deviceSystemVersion, deviceMultiTaskingSupport, deviceIdentifierForVendor, deviceBatteryLevel, deviceBatteryState, deviceCarrierName, deviceNetworkSpeed, deviceVOIPEnabled]];
    
    //Wifi information
    NSArray *networkInterfaces = (id)CFBridgingRelease(CNCopySupportedInterfaces());
    
    NSString *interface = networkInterfaces[0];
    CFDictionaryRef networkDetails = CNCopyCurrentNetworkInfo((CFStringRef) CFBridgingRetain(interface));
    if (networkDetails) {
        NSDictionary *networkInfo = (NSDictionary *)CFBridgingRelease(networkDetails);
        MDCDeviceInformationItem *deviceWifiSSID = [MDCDeviceInformationItem itemWithProperty:@"SSID" value:networkInfo[@"SSID"] category:@"Wi-Fi"];
        MDCDeviceInformationItem *deviceWifiBSSID = [MDCDeviceInformationItem itemWithProperty:@"BSSID" value:networkInfo[@"BSSID"] category:@"Wi-Fi"];
        [self.deviceInformationItems addObjectsFromArray:@[deviceWifiSSID, deviceWifiBSSID]];
    }
    
    //Disk usage
    
    MDCDeviceInformationItem *deviceFreeSpace = [MDCDeviceInformationItem itemWithProperty:@"Free Space" value:[self freeDiskSpace] category:@"Disk Usage"];
    MDCDeviceInformationItem *deviceTotalSpace = [MDCDeviceInformationItem itemWithProperty:@"Total Space" value:[self totalDiskSpace] category:@"Disk Usage"];
    
    [self.deviceInformationItems addObjectsFromArray:@[deviceFreeSpace, deviceTotalSpace]];
    
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


- (NSString *)localisedDeviceModel
{
    //Get system device name
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceCodeName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //Setup dictionary of names
    NSDictionary *deviceNamesByCode = @{@"i386"      :@"Simulator",
                                        @"iPod1,1"   :@"iPod Touch 1st Generation",
                                        @"iPod2,1"   :@"iPod Touch 2nd Generation",
                                        @"iPod3,1"   :@"iPod Touch 3rd Generation",
                                        @"iPod4,1"   :@"iPod Touch 4th Generation",
                                        @"iPod5,1"   :@"iPod Touch 5th Generation",
                                        @"iPhone1,1" :@"iPhone (Original)",
                                        @"iPhone1,2" :@"iPhone 3G",
                                        @"iPhone2,1" :@"iPhone 3GS",
                                        @"iPhone3,1" :@"iPhone 4 (GSM)",
                                        @"iPhone3,2" :@"iPhone 4",
                                        @"iPhone3,3" :@"iPhone 4 (CDMA)",
                                        @"iPhone4,1" :@"iPhone 4S",
                                        @"iPhone5,1" :@"iPhone 5 (GSM)",
                                        @"iPhone5,2" :@"iPhone 5 (CDMA)",
                                        @"iPhone5,3" :@"iPhone 5C",
                                        @"iPhone5,4" :@"iPhone 5C",
                                        @"iPhone6,1" :@"iPhone 5S",
                                        @"iPhone6,2" :@"iPhone 5S",
                                        @"iPad1,1"   :@"iPad",
                                        @"iPad2,1"   :@"iPad 2 (Wifi)",
                                        @"iPad2,2"   :@"iPad 2 (GSM)",
                                        @"iPad2,3"   :@"iPad 2 (CDMA)",
                                        @"iPad2,4"   :@"iPad 2 (Mid 2012)",
                                        @"iPad2,5"   :@"iPad Mini (WiFi)",
                                        @"iPad2,6"   :@"iPad Mini (GSM)",
                                        @"iPad2,7"   :@"iPad Mini (GSM + CDMA)",
                                        @"iPad3,1"   :@"iPad 3 (WiFi)",
                                        @"iPad3,2"   :@"iPad 3 (CDMA)",
                                        @"iPad3,3"   :@"iPad 3 (GSM)",
                                        @"iPad3,4"   :@"iPad 4 (WiFi)",
                                        @"iPad3,5"   :@"iPad 4 (GSM)",
                                        @"iPad3,6"   :@"iPad 4 (GSM + CDMA)",
                                        @"iPad4,1"   :@"iPad Air (WiFi)",
                                        @"iPad4,2"   :@"iPad Air (GSM + CDMA)",
                                        @"iPad4,4"   :@"iPad Mini Retina (WiFi)",
                                        @"iPad4,5"   :@"iPad Mini Retina (GSM + CDMA)"
                                        };
    
    return deviceNamesByCode[deviceCodeName] ? deviceNamesByCode[deviceCodeName] : deviceCodeName;
}

#pragma mark - Tableview section handling

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

#pragma mark - Disk space calculations

- (NSString *)totalDiskSpace
{
    uint64_t totalSpace = 0;
    NSError *error = nil;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error:&error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = dictionary[NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    } else {
        MDCLogErr(@"Error fetching disk space:%@", error.localizedDescription);
    }
    
    return [NSString stringWithFormat:@"%llu MiB", ((totalSpace/1024ll)/1024ll)];
}

- (NSString *)freeDiskSpace
{
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error:&error];

    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = dictionary[NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    } else {
        MDCLogErr(@"Error fetching free disk space:%@", error.localizedDescription);
    }

    return [NSString stringWithFormat:@"%llu MiB", ((totalFreeSpace/1024ll)/1024ll)];
}

@end
