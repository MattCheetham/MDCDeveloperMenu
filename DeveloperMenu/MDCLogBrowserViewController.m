//
//  MDCLogViewController.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 02/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MDCLogBrowserViewController.h"
#import "MDCCell.h"

@interface MDCLogBrowserViewController ()

@property (nonatomic, strong) MDCLogController *logController;

@end

@implementation MDCLogBrowserViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.title = @"Log Browser";
        
        self.logController = [MDCLogController sharedController];
        
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
    return self.logController.deviceLogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MDCCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Configure the cell...
    
    MDCLog *log = self.logController.deviceLogs[indexPath.row];
    
    cell.textLabel.text = log.logContent;
    cell.detailTextLabel.text = [log.logTime descriptionWithLocale:[NSLocale currentLocale]];
    
    return cell;
}

#pragma mark - Tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MDCLog *log = self.logController.deviceLogs[indexPath.row];
    
    CGSize constraint = CGSizeMake(300, MAXFLOAT);
    
    CGSize size = [log.logContent sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height + 11, 44.0f);
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
