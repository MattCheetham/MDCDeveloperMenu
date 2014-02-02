//
//  MDCDeviceInformationBrowserViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCDeviceInformationBrowserViewController.h"
#import "MDCDeviceInformationController.h"
#import "MDCDeviceInformationItem.h"
#import "MDCCell.h"

@interface MDCDeviceInformationBrowserViewController ()

@property (nonatomic, strong) MDCDeviceInformationController *deviceInformationController;

@end

@implementation MDCDeviceInformationBrowserViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Device information";
        
        self.deviceInformationController = [MDCDeviceInformationController sharedController];
        
        [self.tableView registerClass:[MDCCell class] forCellReuseIdentifier:@"Cell"];
        
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
    return self.deviceInformationController.deviceInformationItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MDCCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Configure the cell...
    
    MDCDeviceInformationItem *deviceItem = self.deviceInformationController.deviceInformationItems[indexPath.row];
    
    cell.textLabel.text = deviceItem.deviceValue;
    cell.detailTextLabel.text = deviceItem.deviceProperty;
    
    return cell;
}

#pragma mark - Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MDCDeviceInformationItem *deviceItem = self.deviceInformationController.deviceInformationItems[indexPath.row];
    
    CGSize constraint = CGSizeMake(300, MAXFLOAT);
    
    CGSize size = [deviceItem.deviceValue sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height + 11, 44.0f);
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
