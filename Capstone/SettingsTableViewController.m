//
//  SettingsTableViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "SettingsTableViewController.h"
#import <Parse/Parse.h>

@interface SettingsTableViewController ()
@property (nonatomic) NSMutableArray *tableOptions;
@end

@implementation SettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)tableOptions
{
    if (!_tableOptions) {
        _tableOptions = [[NSMutableArray alloc] initWithObjects:@"Support", @"User Guide", @"Grading Scale", nil];
    }
    return _tableOptions;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dismiss:(id)sender
{
    [self.delegate settingsTableViewControllerViewControllerDidCancel:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellTitle = [self.tableOptions objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = cellTitle;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"showSupport" sender:self];
    }
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
