//
//  TextEditorViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "TextEditorViewController.h"
#import "LessonsDataSource.h"
#import "ResultsViewController.h"
#import "LineNumberTextView.h"
#import "CurrentUser.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const BOOL _debug = YES;
static const int statusBarHeight = 20;
int stepTracker;

@interface TextEditorViewController ()
@property (nonatomic) CurrentUser *currentUser;
@property (nonatomic) LineNumberTextView *lineNumberTextView;
@property (nonatomic) LessonsDataSource *lessonsDataSource;
@property (nonatomic) UITextView *textEditorView;
@property (nonatomic) UIView *stepGutterView;
@property (nonatomic) UILabel *stepTitleLabel;
@property (nonatomic) UITextView *stepTextView;
@property (nonatomic) UIWebView *webView;
@property (nonatomic) NSArray *subLessonSteps;
@property (nonatomic) NSString *expectedResult;
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

- (instancetype)initWithSubLessonSteps:(NSArray *)steps
{
    if( (self = [super init]) == nil )
        return nil;
    self.subLessonSteps = steps;
    return self;
}

- (CurrentUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [[CurrentUser alloc] init];
    }
    return _currentUser;
}

- (LessonsDataSource *)lessonsDataSource
{
    if (!_lessonsDataSource) {
        _lessonsDataSource = [[LessonsDataSource alloc] init];
    }
    return _lessonsDataSource;
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    stepTracker = 0;
    
    self.view.backgroundColor = UIColorFromRGB(0xEBEBEB);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                          target:self
                                                                                          action:@selector(exitLesson:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                                          target:self
                                                                                          action:@selector(runCode:)];
    
    self.title = [self.currentUser getFirstAndLastName];
    
    [self.webView loadHTMLString:@"<script src=\"free_code.js\"></script>" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    [self placeStepGutterView];
    [self placeTextEditorView];
    [self placeStepNavigationBar];
    [self contentLoadedAfterLaunchAndEachStep];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)contentLoadedAfterLaunchAndEachStep
{
    [self placeStepTitle];
    [self placeStepTextView];
    
    if (_debug) {
        [self printStepsForSublesson];
    }
}

- (void)printStepsForSublesson
{
    for (int i=0; i<[self.subLessonSteps count]; i++) {
        NSLog(@"%@", [self.subLessonSteps objectAtIndex:i]);
    }
}

- (void)clearViewForReload
{
    self.lineNumberTextView.text = @"// enter your code below\n";
    [self.stepTitleLabel removeFromSuperview];
    [self.stepTextView removeFromSuperview];
}

- (void)placeTextEditorView
{
    [[UITextView appearance] setTintColor:[UIColor blackColor]];
    CGRect textEditorViewFrame = CGRectMake(self.stepGutterView.frame.size.width,
                                            self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                            self.view.frame.size.height - self.stepGutterView.frame.size.width,
                                            (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    self.lineNumberTextView = [[LineNumberTextView alloc] initWithFrame:textEditorViewFrame];
    self.lineNumberTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lineNumberTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.lineNumberTextView.text = @"// enter your code below\n";
    [self.view addSubview:self.lineNumberTextView];
}

- (void)placeStepNavigationBar
{
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:self.subLessonTitle];
    CGRect navFrame = CGRectMake(0,
                                 self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                 self.stepGutterView.frame.size.width,
                                 self.navigationController.navigationBar.frame.size.height);
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:navFrame];
    navBar.items = [NSArray arrayWithObjects:title, nil];
    [self.view addSubview:navBar];
}

- (void)placeStepGutterView
{
    CGRect stepFrame = CGRectMake(0,
                                  self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                  300,
                                  (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    self.stepGutterView = [[UIView alloc] initWithFrame:stepFrame];
    [self.view addSubview:self.stepGutterView];
}

- (void)placeStepTitle
{
    CGRect stepTitleFrame = CGRectMake(5,
                                       (self.navigationController.navigationBar.frame.size.height*2) + statusBarHeight + 5,
                                       self.stepGutterView.frame.size.width - statusBarHeight/2,
                                       100);
    self.stepTitleLabel = [[UILabel alloc] initWithFrame:stepTitleFrame];
    self.stepTitleLabel.text = [[self.subLessonSteps objectAtIndex:stepTracker] valueForKey:@"title"];
    self.stepTitleLabel.font = [UIFont systemFontOfSize:22.0];
    self.stepTitleLabel.numberOfLines = 0;
    self.stepTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.stepTitleLabel];
}

- (void)placeStepTextView
{
    CGRect stepFrame = CGRectMake(5,
                                  ((self.navigationController.navigationBar.frame.size.height*2) + statusBarHeight + 5) + 105,
                                  self.stepGutterView.frame.size.width - statusBarHeight/2,
                                  500);
    self.stepTextView = [[UITextView alloc] initWithFrame:stepFrame];
    self.stepTextView.userInteractionEnabled = NO;
    self.stepTextView.backgroundColor = [UIColor clearColor];
    self.stepTextView.textAlignment = NSTextAlignmentCenter;
    self.stepTextView.text = [[self.subLessonSteps objectAtIndex:stepTracker] valueForKey:@"description"];
    self.stepTextView.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:self.stepTextView];
}

- (IBAction)runCode:(id)sender
{
    // dismiss keyboard right away
    [self.lineNumberTextView resignFirstResponder];
    
	NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:self.lineNumberTextView.text];
    self.expectedResult = [[self.subLessonSteps objectAtIndex:stepTracker] valueForKey:@"expectedResult"];
    
    if (_debug) {
        NSLog(@"Result is: %@", result);
        NSLog(@"Expected result is: %@", self.expectedResult);
    }
    
    ResultsViewController *resultsViewController = [[ResultsViewController alloc] init];
    resultsViewController.delegate = self;
    resultsViewController.stepNumber = stepTracker;
    
    if ([result isEqualToString:self.expectedResult]) {
        resultsViewController.correctStatus = YES;
        resultsViewController.result = result;
    }
    else {
        resultsViewController.correctStatus = NO;
    }

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:resultsViewController];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex == 0) {
        [self.delegate textEditorViewController:self exitedWithStep:stepTracker];
    }
}

- (void)resultsViewController:(ResultsViewController *)controller exitedWithResult:(NSString *)result
{
    if ([result isEqualToString:self.expectedResult]) {
        if (stepTracker < 4) {
            [self dismissViewControllerAnimated:YES completion:nil];
            stepTracker++;
            [self clearViewForReload];
            [self contentLoadedAfterLaunchAndEachStep];
        }
        else {
            [self dismissViewControllerAnimated:NO completion:nil];
            [self.delegate textEditorViewController:self exitedWithStep:stepTracker];
        }
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
