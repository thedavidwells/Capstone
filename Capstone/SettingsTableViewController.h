//
//  SettingsTableViewController.h
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
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
