//
//  MDCUserDefaultsController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCUserDefaultsController : NSObject

@property (nonatomic, strong) NSMutableArray *userDefaultsItems;

+ (MDCUserDefaultsController *)sharedController;

@end
