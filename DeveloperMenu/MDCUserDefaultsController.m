//
//  MDCUserDefaultsController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCUserDefaultsController.h"

@implementation MDCUserDefaultsController

static MDCUserDefaultsController *sharedController = nil;

+ (MDCUserDefaultsController *)sharedController
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
        
    }
    return self;
}

@end
