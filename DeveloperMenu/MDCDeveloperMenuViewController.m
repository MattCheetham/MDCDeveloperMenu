//
//  MDCDeveloperMenuViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 18/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeveloperMenuViewController.h"
#import "MDCPlistBrowserViewController.h"

@interface MDCDeveloperMenuViewController ()

@property (nonatomic, strong) UIViewController *attatchedViewController;

@end

@implementation MDCDeveloperMenuViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Developer Menu"; 
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    
    // Configure the cell...
    cell.textLabel.text = @"View plist";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *plistKey = [[[NSBundle mainBundle] infoDictionary] allKeys][indexPath.row];
    NSString *tableViewText = [MDCValueConverter stringForObscureValue:[[NSBundle mainBundle] infoDictionary][plistKey]];

    CGSize constraint = CGSizeMake(300, MAXFLOAT);
    
    CGSize size = [tableViewText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MDCPlistBrowserViewController *plistBrowser = [[MDCPlistBrowserViewController alloc] initWithDictionary:[[NSBundle mainBundle] infoDictionary]];

    [self.navigationController pushViewController:plistBrowser animated:YES];
}

@end
