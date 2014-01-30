//
//  MDCPlistItem.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCPlistItem.h"

@implementation MDCPlistItem

- (id)initWithKey:(NSString *)key value:(id)value
{
    self = [super init];
    if (self) {
        self.children = [NSMutableArray array];
        
        self.plistKey = key;
        
        if([value isKindOfClass:[NSDictionary class]]){
            
            for (NSString *dictionaryKey in (NSDictionary *)value){
                
                MDCPlistItem *item = [[MDCPlistItem alloc] initWithKey:dictionaryKey value:value[dictionaryKey]];
                [self.children addObject:item];
                
            }
            
        }else if(![value isKindOfClass:[NSArray class]]){
            
            self.plistValue = [MDCValueConverter stringForObscureValue:value];
            
        } else {
            
            for (id arrayValue in (NSArray *)value){
                
                MDCPlistItem *item = [[MDCPlistItem alloc] initWithKey:nil value:arrayValue];
                [self.children addObject:item];
                
            }
            
        }
        
    }
    return self;
}

@end
