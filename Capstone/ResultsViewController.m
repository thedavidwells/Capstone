//
//  ResultsViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                          target:self
                                                                                          action:@selector(dismissResults:)];
    CGRect resultLabelFrame = CGRectMake(50,
                                         50,
                                         100,
                                         100);

    
    UILabel *titleText = [[UILabel alloc] initWithFrame:resultLabelFrame];
    titleText.text = @"RESULT: ";
    titleText.font = [UIFont systemFontOfSize:22.0];
    
    CGRect actualResultFrame = CGRectMake(50,
                                          titleText.frame.size.height + 10,
                                          100,
                                          300);
    self.resultLabel = [[UILabel alloc] initWithFrame:actualResultFrame];
    [self.resultLabel setText: @"<enter code>"];
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.font = [UIFont systemFontOfSize:22.0];
    [self.resultLabel sizeToFit];
    NSLog(@"Inside RESULTS VC");
    
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:titleText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissResults:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
