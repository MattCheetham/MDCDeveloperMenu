//
//  MDCUserDefaultsController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCUserDefaultsController.h"
#import "MDCUserDefaultItem.h"

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
        
        self.userDefaultsItems = [NSMutableArray array];

        for (NSString *key in [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]) {
            
            MDCUserDefaultItem *item = [[MDCUserDefaultItem alloc] initWithKey:key value:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation][key]];
            
            [self.userDefaultsItems addObject:item];
        }
                
    }
    return self;
}

@end
