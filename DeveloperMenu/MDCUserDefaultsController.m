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
        
        [self reloadDefaults];
                
    }
    return self;
}

- (void)saveUserDefaultsItem:(MDCUserDefaultItem *)item
{
    [[NSUserDefaults standardUserDefaults] setObject:item.defaultValue forKey:item.defaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadDefaults];
}

- (void)deleteUserDefaultsItem:(MDCUserDefaultItem *)item
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:item.defaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self reloadDefaults];
    
    //Check if this was an apple key we weren't allowed to delete
    if([[NSUserDefaults standardUserDefaults] objectForKey:item.defaultKey]){
        
        UIAlertView *permissionDenied = [[UIAlertView alloc] initWithTitle:@"Permission denied" message:@"Sorry, we were unable to delete the key you chose. It is likely that this key is a default key set by Apple" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [permissionDenied show];
        
    }
}

- (void)reloadDefaults
{
    [self willChangeValueForKey:@"userDefaultsItems"];
    
    [self.userDefaultsItems removeAllObjects];
    for (NSString *key in [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]) {
        
        MDCUserDefaultItem *item = [[MDCUserDefaultItem alloc] initWithKey:key value:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation][key]];
        
        [self.userDefaultsItems addObject:item];
        
    }
    
    [self didChangeValueForKey:@"userDefaultsItems"];
}

@end
