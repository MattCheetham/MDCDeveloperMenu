//
//  MDCAppDelegate.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 18/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCAppDelegate.h"
#import "MDCExampleRootViewController.h"
#import "MDCDeveloperMenuViewController.h"

@interface MDCAppDelegate ()

@property (nonatomic, strong) MDCDeveloperMenuViewController *developerMenu;

@end

@implementation MDCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Set up root view controller
    MDCExampleRootViewController *exampleView = [[MDCExampleRootViewController alloc] init];
    UINavigationController *exampleNavigationController = [[UINavigationController alloc] initWithRootViewController:exampleView];
    
    self.window.rootViewController = exampleNavigationController;
    [self.window makeKeyAndVisible];

    //Attatch Developer menu
    self.developerMenu = [[MDCDeveloperMenuViewController alloc] init];
    [self.developerMenu attachToViewController:self.window.rootViewController];
    
    return YES;
}

@end
