//
//  MDCDeveloperMenuViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 18/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeveloperMenuViewController.h"

@interface MDCDeveloperMenuViewController ()

@property (nonatomic, strong) UIViewController *attatchedViewController;

@end

@implementation MDCDeveloperMenuViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Presenting and dismissal handling

- (void)attachToViewController:(UIViewController *)viewController
{
    UISwipeGestureRecognizer *fourFingers = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(presentDeveloperConsole)];
    fourFingers.numberOfTouchesRequired = 4;
    fourFingers.direction = UISwipeGestureRecognizerDirectionUp;
    
    self.attatchedViewController = viewController;
    
    [self.attatchedViewController.view addGestureRecognizer:fourFingers];
}

- (void)presentDeveloperConsole
{
    UINavigationController *developerConsole = [[UINavigationController alloc] initWithRootViewController:self];
    
    [self.attatchedViewController presentViewController:developerConsole animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
