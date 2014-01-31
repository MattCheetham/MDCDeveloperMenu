//
//  MDCUserDefaultsBrowserViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 31/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCUserDefaultsBrowserViewController.h"
#import "MDCPlistItemCell.h"
#import "MDCUserDefaultItem.h"

@interface MDCUserDefaultsBrowserViewController ()

@property (nonatomic, strong) NSArray *userDefaultsItems;

@end

@implementation MDCUserDefaultsBrowserViewController

- (id)initWithUserDefaultsItems:(NSArray *)items
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"User Defaults";
        
        self.userDefaultsItems = items;
        
        [self.tableView registerClass:[MDCPlistItemCell class] forCellReuseIdentifier:@"Cell"];
        
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
    MDCPlistItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
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
    }
    
}

@end
