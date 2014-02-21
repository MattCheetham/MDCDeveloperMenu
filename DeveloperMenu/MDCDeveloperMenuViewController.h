//
//  MDCDeveloperMenuViewController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 18/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MDCDeveloperMenuViewController : UITableViewController <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>

- (void)attachToViewController:(UIViewController *)viewController;
- (void)presentDeveloperConsole;

@end
