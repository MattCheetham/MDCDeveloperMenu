//
//  MDCPlistItem.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCPlistItem : NSObject

@property (nonatomic, strong) NSString *plistValue;
@property (nonatomic, strong) NSString *plistKey;
@property (nonatomic, strong) NSMutableArray *children;

- (id)initWithKey:(NSString *)key value:(id)value;

@end
