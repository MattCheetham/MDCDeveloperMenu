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

/**
 Retrieves a list of objects relating to device information for a category at a particular index
 @param index The index of the section you wish to return objects for
 @returns NSArray of MDCDeviceInformationItem objects belonging to the selected category
 **/
- (NSArray *)deviceInformationitemsForSectionIndex:(int)index;

/**
 Gets the title of the section based on a supplied index. The title is taken from the category of the objects inside the array
 @param index The index of the section you wish to get the title for
 @returns NSString of the category/section title
 **/
- (NSString *)deviceInformationCategoryKeyForSection:(int)index;

/**
 Gets an array of category/section titles for all of the current device information objects
 @returns NSArray of NSString objects. These are the category titles.
 **/
- (NSArray *)deviceInformationCategoryKeys;

@end
