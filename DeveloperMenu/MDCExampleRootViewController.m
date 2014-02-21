//
//  MDCExampleRootViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 18/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCExampleRootViewController.h"

@interface MDCExampleRootViewController ()

@end

@implementation MDCExampleRootViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Main app screen";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loggingDemo];
}

- (void)loggingDemo
{
    MDCLogDebug(@"The lowest priority, and normally not logged except for messages from the kernel.");
    MDCLogInfo(@"The lowest priority that you would normally log, and purely informational in nature.");
    MDCLogNotice(@"Things of moderate interest to the user or administrator.");
    MDCLogWarning(@"Something is amiss and might fail if not corrected.");
    MDCLogErr(@"Something has failed.");
    MDCLogCrit(@"A failure in a key system");
    MDCLogAlert(@"A serious failure in a key system.");
    MDCLogEmerg(@"The highest priority, usually reserved for catastrophic failures and reboot notices.");
}

@end
