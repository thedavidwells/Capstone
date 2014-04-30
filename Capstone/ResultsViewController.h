//
//  ResultsViewController.h
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

@class ResultsViewController;

@protocol ResultsViewControllerDelegate <NSObject>
- (void)resultsViewController:(ResultsViewController *)controller exitedWithResult:(NSString *)result;
@end

@interface ResultsViewController : UIViewController

@property (nonatomic, weak) id <ResultsViewControllerDelegate> delegate;
@property (nonatomic) NSString *result;
@property (nonatomic) UILabel *resultLabel;
@property (nonatomic) int stepNumber;
@property (nonatomic) BOOL correctStatus;

@end
