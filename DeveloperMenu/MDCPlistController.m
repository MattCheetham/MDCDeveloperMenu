//
//  MDCPlistController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCPlistController.h"
#import "MDCPlistItem.h"

@implementation MDCPlistController

static MDCPlistController *sharedController = nil;

+ (MDCPlistController *)sharedController
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
        
        self.plistItems = [NSMutableArray array];
        
        for (NSString *key in [[[NSBundle mainBundle] infoDictionary] allKeys]) {
            
            MDCPlistItem *item = [[MDCPlistItem alloc] initWithKey:key value:[[NSBundle mainBundle] infoDictionary][key]];
            
            [self.plistItems addObject:item];
        }
                
    }
    return self;
}

@end
