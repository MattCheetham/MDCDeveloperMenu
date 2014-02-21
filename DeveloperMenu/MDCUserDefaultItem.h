//
//  MDCUserDefaultItem.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDCUserDefaultItem : NSObject

@property (nonatomic, strong) NSString *defaultValue;
@property (nonatomic, strong) NSString *defaultKey;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, strong) Class originalClass;

- (id)initWithKey:(NSString *)key value:(id)value;

@end
