//
//  MDCUserDefaultsBrowserViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCUserDefaultsBrowserViewController.h"
#import "MDCCell.h"
#import "MDCUserDefaultItem.h"
#import "MDCUserDefaultsController.h"
#import "MDCUserDefaultsEditorViewController.h"

@interface MDCUserDefaultsBrowserViewController ()

@property (nonatomic, strong) NSArray *userDefaultsItems;
@property (nonatomic, strong) UIBarButtonItem *editButton;

@end

@implementation MDCUserDefaultsBrowserViewController

- (void)dealloc
{
    [[MDCUserDefaultsController sharedController] removeObserver:self forKeyPath:@"userDefaultsItems" context:nil];
}

- (id)initWithUserDefaultsItems:(NSArray *)items
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"User Defaults";
        
        self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editItems)];
        self.navigationItem.rightBarButtonItem = self.editButton;
        
        self.userDefaultsItems = items;
        
        [self.tableView registerClass:[MDCCell class] forCellReuseIdentifier:@"Cell"];
        
        [[MDCUserDefaultsController sharedController] addObserver:self forKeyPath:@"userDefaultsItems" options:kNilOptions context:nil];
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userDefaultsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MDCCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Configure the cell...
    
    MDCUserDefaultItem *item = self.userDefaultsItems[indexPath.row];
    
    cell.textLabel.text = item.defaultValue;
    cell.detailTextLabel.text = item.defaultKey;
    
    if(item.children.count){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MDCUserDefaultItem *item = self.userDefaultsItems[indexPath.row];
    
    CGSize constraint = CGSizeMake(300, MAXFLOAT);
    
    CGSize size = [item.defaultValue sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height + 11, 44.0f);
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDCUserDefaultItem *item = self.userDefaultsItems[indexPath.row];
    
    if(item.children.count){
        
        MDCUserDefaultsBrowserViewController *defaultsBrowser = [[MDCUserDefaultsBrowserViewController alloc] initWithUserDefaultsItems:item.children];
        [self.navigationController pushViewController:defaultsBrowser animated:YES];
        
    } else {
        
        MDCUserDefaultsEditorViewController *defaultsEditor = [[MDCUserDefaultsEditorViewController alloc] initWithUserDefaultsItem:item];
        UINavigationController *defaultsNav = [[UINavigationController alloc] initWithRootViewController:defaultsEditor];
        [self presentViewController:defaultsEditor animated:defaultsEditor completion:nil];
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDCUserDefaultItem *item = self.userDefaultsItems[indexPath.row];
    
    if(item.children.count || !item.defaultKey){
        return NO;
    }
    
    return YES;
}

#pragma mark - Edit handling

- (void)editItems
{
    if(self.tableView.editing){
        self.editButton.title = @"Edit";
    } else {
        self.editButton.title = @"Done";
    }
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        MDCUserDefaultItem *item = self.userDefaultsItems[indexPath.row];
        [[MDCUserDefaultsController sharedController] deleteUserDefaultsItem:item];
        
    }
}

#pragma mark - KVO handling

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"userDefaultsItems"]){
        
        [self.tableView reloadData];
        
    }
}

@end
