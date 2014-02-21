//
//  MDCDeviceInformationItem.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCDeviceInformationItem : NSObject

@property (nonatomic, strong) NSString *deviceProperty;
@property (nonatomic, strong) NSString *deviceValue;
@property (nonatomic, strong) NSString *devicePropertyCategory;

/**
 Used for storing device information to display in the developer menu.
 @param deviceProperty A string describing the property name
 @param deviceValue A string containing the value relating to the property name
 @param devicePropertyCategory A string to describe which section this property should be listed under in the device information browser
 @return MDCDeviceInformationItem object for use in the device information controller
 **/
+ (MDCDeviceInformationItem *)itemWithProperty:(NSString *)deviceProperty value:(NSString *)deviceValue category:(NSString *)devicePropertyCategory;

@end
