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

/**
 Attempts to delete an NSUserDefaults entry. If the entry is an Apple specific entry it will fail to delete and this method will display a UIAlertView explaining this.
 @param item An MDCUserDefaultItem to be deleted
 **/
- (void)deleteUserDefaultsItem:(MDCUserDefaultItem *)item;
- (void)saveUserDefaultsItem:(MDCUserDefaultItem *)item;

+ (MDCUserDefaultsController *)sharedController;

@end
