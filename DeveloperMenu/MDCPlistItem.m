//
//  MDCPlistItem.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCPlistItem.h"

@implementation MDCPlistItem

- (id)init
{
    self = [super init];
    if (self) {
        self.children = [NSMutableArray array];
    }
    return self;
}

@end
