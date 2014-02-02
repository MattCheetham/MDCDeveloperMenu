//
//  MDCDeviceInformationController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCDeviceInformationController : NSObject

@property (nonatomic, strong) NSMutableArray *deviceInformationItems;

+ (MDCDeviceInformationController *)sharedController;

@end
