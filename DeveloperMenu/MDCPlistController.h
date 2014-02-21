//
//  MDCPlistController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCPlistController : NSObject

@property (nonatomic, strong) NSMutableArray *plistItems;

+ (MDCPlistController *)sharedController;

@end
