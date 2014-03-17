//
//  ViewController.h
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsTableViewController.h"

@interface ViewController : UIViewController <SettingsTableViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic) NSString *userType;

- (IBAction)logoutAction:(id)sender;

@end
