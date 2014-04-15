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

static const int statusBarHeight = 20;
int stepTracker = 0;

@interface TextEditorViewController ()
@property (nonatomic) CurrentUser *currentUser;
@property (nonatomic) NSString *subLessonTitle;
@property (nonatomic) UITextView *textEditorView;
@property (nonatomic) UIView *stepByStepInstructionView;
@property (nonatomic) LineNumberTextView *lineNumberTextView;
@property (nonatomic) LessonsDataSource *lessonsDataSource;
@property (nonatomic) UIWebView *webView;
@property (nonatomic) ResultsViewController *resultsViewController;
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

- (CurrentUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [[CurrentUser alloc] init];
    }
    return _currentUser;
}

- (instancetype)initWithSubLesson:(NSString *)subLessonTitle
{
    if( (self = [super init]) == nil )
        return nil;
    self.subLessonTitle = subLessonTitle;
    return self;
}

- (LessonsDataSource *)lessonsDataSource
{
    if (!_lessonsDataSource) {
        _lessonsDataSource = [[LessonsDataSource alloc] init];
    }
    return _lessonsDataSource;
}


-(ResultsViewController *) resultsViewController
{
    if (!_resultsViewController) {
        _resultsViewController = [[ResultsViewController alloc] init];
    }
    return _resultsViewController;
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

    self.view.backgroundColor = UIColorFromRGB(0xEBEBEB);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                          target:self
                                                                                          action:@selector(exitLesson:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                                          target:self
                                                                                          action:@selector(runCode:)];
    
    self.title = [self.currentUser getFirstAndLastName];
    
    [self.webView loadHTMLString:@"<script src=\"free_code.js\"></script>" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    [self contentReloadedAfterLaunchAndEachStep];
}

- (void)contentReloadedAfterLaunchAndEachStep
{
    [self placeStepByStepInstructionView];
    [self placeTextEditorView];
}

- (void)placeStepByStepInstructionView
{
    CGRect stepFrame = CGRectMake(0,
                                  self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                  300,
                                  (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    self.stepByStepInstructionView = [[UIView alloc] initWithFrame:stepFrame];
    self.stepByStepInstructionView.backgroundColor = UIColorFromRGB(0xf3f3f3);
    [self.view addSubview:self.stepByStepInstructionView];
    
    [self placeStepNavigationBar];
    [self placeStepTitle];
    [self placeStepText];
}

- (void)placeTextEditorView
{
    [[UITextView appearance] setTintColor:[UIColor blackColor]];
    CGRect textEditorViewFrame = CGRectMake(self.stepByStepInstructionView.frame.size.width,
                                            self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                            self.view.frame.size.height - self.stepByStepInstructionView.frame.size.width,
                                            (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    self.lineNumberTextView = [[LineNumberTextView alloc] initWithFrame:textEditorViewFrame];
    self.lineNumberTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lineNumberTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // this is just an example of how we can pre-load sublesson text
    self.lineNumberTextView.text = [self.lessonsDataSource loadStepStarterText:0 /* we'll want to load the text relevant to the sublesson, 0 does nothing here*/];
    [self.view addSubview:self.lineNumberTextView];
}

- (void)placeStepNavigationBar
{
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:self.subLessonTitle];
    CGRect navFrame = CGRectMake(0,
                                 self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                 self.stepByStepInstructionView.frame.size.width,
                                 self.navigationController.navigationBar.frame.size.height);
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:navFrame];
    navBar.items = [NSArray arrayWithObjects:title, nil];
    [self.view addSubview:navBar];
}

- (void)placeStepTitle
{
    CGRect stepTitleFrame = CGRectMake(5,
                                       (self.navigationController.navigationBar.frame.size.height*2) + statusBarHeight + 5,
                                       self.stepByStepInstructionView.frame.size.width - statusBarHeight/2,
                                       100);
    UILabel *stepTitleLabel = [[UILabel alloc] initWithFrame:stepTitleFrame];
    stepTitleLabel.text = [self.lessonsDataSource loadStepTitleText:0];
    stepTitleLabel.font = [UIFont systemFontOfSize:22.0];
    stepTitleLabel.numberOfLines = 0;
    stepTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:stepTitleLabel];
}

- (void)placeStepText
{
    CGRect stepFrame = CGRectMake(5,
                                  ((self.navigationController.navigationBar.frame.size.height*2) + statusBarHeight + 5) + 105,
                                  self.stepByStepInstructionView.frame.size.width - statusBarHeight/2,
                                  200);
    UITextView *stepView = [[UITextView alloc] initWithFrame:stepFrame];
    stepView.userInteractionEnabled = NO;
    stepView.backgroundColor = [UIColor clearColor];
    stepView.textAlignment = NSTextAlignmentCenter;
    stepView.text = [self.lessonsDataSource loadStepText:0];
    stepView.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:stepView];
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

	NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:self.lineNumberTextView.text];
    result = [self.webView stringByEvaluatingJavaScriptFromString:self.lineNumberTextView.text];
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.resultsViewController];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:nav animated:YES completion:^{
        NSLog(@"Function called inside vc...");
        [self.resultsViewController.resultLabel setText:result];
        NSLog(@"Result is: %@", result);
    }];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
