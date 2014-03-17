//
//  SettingsTableViewController.h
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsTableViewController;

@protocol SettingsTableViewControllerDelegate <NSObject>

- (void)settingsTableViewControllerViewControllerDidCancel:(SettingsTableViewController *)controller;

@end

@interface SettingsTableViewController : UITableViewController

@property (nonatomic, weak) id <SettingsTableViewControllerDelegate> delegate;
- (IBAction)dismiss:(id)sender;

@end
