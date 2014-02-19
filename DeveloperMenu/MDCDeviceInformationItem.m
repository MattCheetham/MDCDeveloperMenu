//
//  MDCDeviceInformationItem.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeviceInformationItem.h"

@implementation MDCDeviceInformationItem

+ (MDCDeviceInformationItem *)itemWithProperty:(NSString *)deviceProperty value:(NSString *)deviceValue category:(NSString *)devicePropertyCategory
{
    MDCDeviceInformationItem *deviceInfo = [MDCDeviceInformationItem new];
    deviceInfo.deviceProperty = deviceProperty;
    deviceInfo.deviceValue = deviceValue;
    deviceInfo.devicePropertyCategory = devicePropertyCategory;
    
    return deviceInfo;
}
@end
