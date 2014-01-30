//
//  MDCValueConverter.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCValueConverter.h"

@implementation MDCValueConverter

+ (NSString *)stringForObscureValue:(id)value
{
    if([value isKindOfClass:[NSString class]]){
        
        return (NSString *)value;
        
    } else if([value isKindOfClass:[NSURL class]]){
        
        return ((NSURL *)value).absoluteString;
        
    } else if([value isKindOfClass:[NSArray class]]){
        
        if(((NSArray *)value).count == 1){
            return [MDCValueConverter stringForObscureValue:(NSArray *)value[0]];
        }
        
    } else if([value isKindOfClass:[NSDictionary class]]){
        
        return @"Dictionary";
        
    } else if([value isKindOfClass:[NSNumber class]]){
        
        return [((NSNumber *)value) stringValue];
        
    } else if([NSStringFromClass([value class]) isEqualToString:@"__NSCFBoolean"]){
        
        BOOL boolValue = (BOOL)value;
        return boolValue ? @"Yes" : @"No";
        
    } else {
        
        NSLog(@"Unrecognised type:%@", [value class]);
    }
    
    return nil;
}

@end
