//
//  MDCPlistEditorViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 21/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCUserDefaultsEditorViewController.h"
#import "MDCUserDefaultItem.h"
#import "MDCInputCell.h"

@interface MDCUserDefaultsEditorViewController ()

@property (nonatomic, strong) MDCUserDefaultItem *defaultsItem;

@end

@implementation MDCUserDefaultsEditorViewController

- (id)initWithUserDefaultsItem:(MDCUserDefaultItem *)item
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Edit property";
        
        [self.tableView registerClass:[MDCInputCell class] forCellReuseIdentifier:@"Cell"];
        
        self.defaultsItem = item;
        
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MDCInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textField.text = self.defaultsItem.defaultValue;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.defaultsItem.defaultKey;
}
@end
