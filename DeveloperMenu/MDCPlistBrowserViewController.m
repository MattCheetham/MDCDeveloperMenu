//
//  MDCPlistBrowserViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCPlistBrowserViewController.h"
#import "MDCPlistItemCell.h"
#import "MDCPlistController.h"
#import "MDCPlistItem.h"

@interface MDCPlistBrowserViewController ()

@property (nonatomic, strong) NSArray *plistItems;


@end

@implementation MDCPlistBrowserViewController

- (id)initWithPlistItems:(NSArray *)items
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Developer Menu";
        
        self.plistItems = items;
        
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
    return self.plistItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MDCPlistItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Configure the cell...
    
    MDCPlistItem *item = self.plistItems[indexPath.row];
    
    cell.textLabel.text = item.plistValue;
    cell.detailTextLabel.text = item.plistKey;
    
    if(item.children.count){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MDCPlistItem *item = self.plistItems[indexPath.row];
    
    CGSize constraint = CGSizeMake(300, MAXFLOAT);
    
    CGSize size = [item.plistValue sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height + 11, 44.0f);
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDCPlistItem *item = self.plistItems[indexPath.row];

    if(item.children.count){
        MDCPlistBrowserViewController *plistBrowser = [[MDCPlistBrowserViewController alloc] initWithPlistItems:item.children];
        [self.navigationController pushViewController:plistBrowser animated:YES];
    }

}
@end
