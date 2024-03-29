//
//  ResultsViewController.m
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import "ResultsViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const int trueViewWidth = 540;
static const int trueViewHeight = 575;

@interface ResultsViewController ()
@property (nonatomic) UILabel *resultsMessage;
@property (nonatomic) UIButton *dismissResultsButton;
@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Code Result";
    
    [self showResultLabel];
    [self showResultMessage];
    [self showResultsButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showResultLabel
{
    CGRect resultLabelFrame = CGRectMake(0, 0, trueViewWidth, 100);
    self.resultLabel = [[UILabel alloc] initWithFrame:resultLabelFrame];
    self.resultLabel.center = CGPointMake(trueViewWidth/2, trueViewHeight/2);
    self.resultLabel.text = self.result;
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.font = [UIFont systemFontOfSize:22.0];
    [self.view addSubview:self.resultLabel];
}

- (void)showResultMessage
{
    CGRect frame = CGRectMake(0, 0, trueViewWidth, 100);
    self.resultsMessage = [[UILabel alloc] initWithFrame:frame];
    self.resultsMessage.textAlignment = NSTextAlignmentCenter;
    self.resultsMessage.textColor = [UIColor blackColor];
    self.resultsMessage.font = [UIFont systemFontOfSize:22.0];
    
    if (self.correctStatus) {
        self.resultsMessage.center = CGPointMake(trueViewWidth/2, 120);
        self.resultsMessage.text = @"Great Job!";
    }
    else {
        self.resultsMessage.center = CGPointMake(trueViewWidth/2, trueViewHeight/2);
        self.resultsMessage.text = @"Opps. Something went wrong.";
    }
    
    [self.view addSubview:self.resultsMessage];
}

- (void)showResultsButton
{
    CGRect frame = CGRectMake(0, 0, 150, 50);
    self.dismissResultsButton = [[UIButton alloc] initWithFrame:frame];
    self.dismissResultsButton.center = CGPointMake(trueViewWidth/2, 500);
    
    if (self.correctStatus) {
        self.dismissResultsButton.backgroundColor = UIColorFromRGB(0x59D659);
        NSString *title;
        
        if (self.stepNumber < 4) {
            title = @"Next Exercise";
        }
        else {
            title = @"Finish Exercise";
        }
        
        [self.dismissResultsButton setTitle:title forState:UIControlStateNormal];
    }
    else {
        self.dismissResultsButton.backgroundColor = UIColorFromRGB(0xFC3F3F);
        [self.dismissResultsButton setTitle:@"Try Again" forState:UIControlStateNormal];
    }
    
    [self.dismissResultsButton addTarget:self action:@selector(dismissResults:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissResultsButton];
}

- (IBAction)dismissResults:(id)sender
{
    [self.delegate resultsViewController:self exitedWithResult:self.result];
}

@end
