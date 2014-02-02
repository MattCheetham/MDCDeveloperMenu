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

+ (MDCDeviceInformationItem *)itemWithProperty:(NSString *)deviceProperty value:(NSString *)deviceValue;

@end
