//
//  MDCPlistEditorViewController.h
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 21/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDCUserDefaultItem;

@interface MDCUserDefaultsEditorViewController : UITableViewController

- (id)initWithUserDefaultsItem:(MDCUserDefaultItem *)item;

@end
