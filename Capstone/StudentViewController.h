//
//  StudentViewController.h
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

@interface StudentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

- (IBAction)logoutAction:(id)sender;

@end
