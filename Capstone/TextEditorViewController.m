//
//  TextEditorViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "TextEditorViewController.h"
#import "ResultsViewController.h"
#import "LineNumberTextView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const int statusBarHeight = 20;
int subLessonTracker = 0;

@interface TextEditorViewController ()
@property (nonatomic) NSString *subLessonTitle;
@property (nonatomic) UITextView *textEditorView;
@property (nonatomic) LineNumberTextView *lineNumberTextView;
@end

@implementation TextEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithSubLesson:(NSString *)subLessonTitle
{
    if( (self = [super init]) == nil )
        return nil;
    self.subLessonTitle = subLessonTitle;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                          target:self
                                                                                          action:@selector(exitLesson:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                                          target:self
                                                                                          action:@selector(runCode:)];
    
    [self placeStepByStepInstructionView];
    
    [self placeTextEditorView];
}

- (void)placeStepByStepInstructionView
{
    CGRect stepFrame = CGRectMake(0,
                                  self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                  300,
                                  (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    UIView *stepByStepInstructionView = [[UIView alloc] initWithFrame:stepFrame];
    stepByStepInstructionView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [self.view addSubview:stepByStepInstructionView];
}

- (void)placeTextEditorView
{
    [[UITextView appearance] setTintColor:[UIColor blackColor]];
    CGRect textEditorViewFrame = CGRectMake(300,
                                            self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                            724,
                                            (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    self.lineNumberTextView = [[LineNumberTextView alloc] initWithFrame:textEditorViewFrame];
    self.lineNumberTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lineNumberTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.lineNumberTextView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exitLesson:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Stop Lesson"
                                                    message:@"Do you want to stop this lesson? All progress will be saved."
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (IBAction)runCode:(id)sender
{
    ResultsViewController *resultsViewController = [[ResultsViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:resultsViewController];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
