//
//  ResultsViewController.h
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
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
