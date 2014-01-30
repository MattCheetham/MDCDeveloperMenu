//
//  MDCPlistBrowserViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 30/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCPlistBrowserViewController.h"

@interface MDCPlistBrowserViewController ()

@property (nonatomic, strong) NSDictionary *plistDictionary;

@end

@implementation MDCPlistBrowserViewController

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Developer Menu";
        
        self.plistDictionary = dictionary;
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.plistDictionary allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    
    // Configure the cell...
    NSString *plistKey = [self.plistDictionary allKeys][indexPath.row];
    
    cell.textLabel.text = [MDCValueConverter stringForObscureValue:[[NSBundle mainBundle] infoDictionary][plistKey]];
    
    return cell;
}

#pragma mark - Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *plistKey = [self.plistDictionary allKeys][indexPath.row];
    NSString *tableViewText = [MDCValueConverter stringForObscureValue:[[NSBundle mainBundle] infoDictionary][plistKey]];
    
    CGSize constraint = CGSizeMake(300, MAXFLOAT);
    
    CGSize size = [tableViewText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height;
}

@end
