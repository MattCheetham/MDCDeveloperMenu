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
        
        NSLog(@"Plist:%@", [[NSBundle mainBundle] infoDictionary]);
        
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
    return [[[[NSBundle mainBundle] infoDictionary] allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *plistKey = [[[NSBundle mainBundle] infoDictionary] allKeys][indexPath.row];

    cell.textLabel.text = [self stringForPlistValue:[[NSBundle mainBundle] infoDictionary][plistKey]];
    
    return cell;
}

#pragma mark - Data format handling

- (NSString *)stringForPlistValue:(id)value
{
    if([value isKindOfClass:[NSString class]]){
        
        return (NSString *)value;
        
    } else if([value isKindOfClass:[NSURL class]]){
        
        return ((NSURL *)value).absoluteString;
        
    } else if([value isKindOfClass:[NSArray class]]){
        
        return @"Array";
        
    } else if([value isKindOfClass:[NSNumber class]]){
        
        return [((NSNumber *)value) stringValue];
    
    } else if([NSStringFromClass([value class]) isEqualToString:@"__NSCFBoolean"]){
    
        BOOL boolValue = (BOOL)value;
        return boolValue ? @"Yes" : @"No";
    
    } else {
        
        NSLog(@"Unrecognised type:%@", [value class]);
    }
    
    return nil;
}

@end
