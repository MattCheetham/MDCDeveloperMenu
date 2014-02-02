//
//  MDCUserDefaultsController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

@class MDCUserDefaultItem;

#import <Foundation/Foundation.h>

@interface MDCUserDefaultsController : NSObject

@property (nonatomic, strong) NSMutableArray *userDefaultsItems;

- (void)deleteUserDefaultsItem:(MDCUserDefaultItem *)item;
+ (MDCUserDefaultsController *)sharedController;

@end
