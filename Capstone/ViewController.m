//
//  ViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "ViewController.h"
#import "CurrentUser.h"
#import <Parse/Parse.h>

static const BOOL _debug = YES;

@interface ViewController ()
@property (nonatomic) CurrentUser *currentUser;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSArray *usersArray;
@end

@implementation ViewController

- (CurrentUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [[CurrentUser alloc] init];
    }
    return _currentUser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.userType = [self.currentUser getUserType];
    
    if (_debug) {
        NSLog(@"user type: %@", self.userType);
    }
    
    if ([self.userType isEqualToString:@"student"]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)logoutAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout"
                                                    message:@"Do you want to logout of <capstone>?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex == 0) {
        [PFUser logOut];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)settingsTableViewControllerViewControllerDidCancel:(SettingsTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSettings"])
    {
        UINavigationController *navController = segue.destinationViewController;
        SettingsTableViewController *settingsVC = [[navController viewControllers] objectAtIndex:0];
        settingsVC.delegate = self;
    }
}

@end
