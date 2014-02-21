//
//  MDCUserDefaultItem.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCUserDefaultItem.h"
#import "MDCUserDefaultItem.h"

@implementation MDCUserDefaultItem

- (id)initWithKey:(NSString *)key value:(id)value
{
    self = [super init];
    if (self) {
        self.children = [NSMutableArray array];
        
        self.defaultKey = key;
        
        self.originalClass = [value class];
                
        if([value isKindOfClass:[NSDictionary class]]){
            
            for (NSString *dictionaryKey in (NSDictionary *)value){
                
                MDCUserDefaultItem *item = [[MDCUserDefaultItem alloc] initWithKey:dictionaryKey value:value[dictionaryKey]];
                [self.children addObject:item];
                
            }
            
        } else if(![value isKindOfClass:[NSArray class]]){
            
            self.defaultValue = [MDCValueConverter stringForObscureValue:value];
            
        } else {
            
            for (id arrayValue in (NSArray *)value){
                
                MDCUserDefaultItem *item = [[MDCUserDefaultItem alloc] initWithKey:nil value:arrayValue];
                [self.children addObject:item];
                
            }
            
        }
        
    }
    return self;
}

@end
