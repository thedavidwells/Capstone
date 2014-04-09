//
//  FreeTextViewController.m
//  Capstone
//
//  Created by David Wells on 3/31/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "FreeTextViewController.h"
#import "LessonsDataSource.h"
#import "ResultsViewController.h"
#import "LineNumberTextView.h"
#import "CurrentUser.h"



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const int statusBarHeight = 20;


@interface FreeTextViewController ()
@property (nonatomic) CurrentUser *currentUser;
@property (nonatomic) LineNumberTextView *lineNumberTextView;
@property (nonatomic) LessonsDataSource *lessonsDataSource;
@property (nonatomic) ResultsViewController *resultsViewController;

@end

@implementation FreeTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (LessonsDataSource *)lessonsDataSource
{
    if (!_lessonsDataSource) {
        _lessonsDataSource = [[LessonsDataSource alloc] init];
    }
    return _lessonsDataSource;
}

- (CurrentUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [[CurrentUser alloc] init];
    }
    return _currentUser;
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];

    }
    return _webView;
}

-(ResultsViewController *) resultsViewController
{
    if (!_resultsViewController) {
        _resultsViewController = [[ResultsViewController alloc] init];
    }
    return _resultsViewController;
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
    
    NSString *pageTitle = [NSString stringWithFormat:@"%@ Free Code",[self.currentUser getFirstAndLastName] ];
    self.title = pageTitle;
    

    
    [self.webView loadHTMLString:@"<script src=\"free_code.js\"></script>" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];


    
    
    [self contentReloadedAfterLaunchAndEachStep];
}

- (void)contentReloadedAfterLaunchAndEachStep
{

    [self placeTextEditorView];

}



- (void)placeTextEditorView
{
    [[UITextView appearance] setTintColor:[UIColor blackColor]];
    CGRect textEditorViewFrame = CGRectMake(0,
                                            0,
                                            self.view.frame.size.height,
                                            self.view.frame.size.width);
    
    self.lineNumberTextView = [[LineNumberTextView alloc] initWithFrame:textEditorViewFrame];
    self.lineNumberTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lineNumberTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // this is just an example of how we can pre-load sublesson text
    self.lineNumberTextView.text = [self.lessonsDataSource loadFreeCodeText:0 /* we'll want to load the text relevant to the sublesson, 0 does nothing here*/];

    
    [self.view addSubview:self.lineNumberTextView];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exitLesson:(id)sender
{
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Stop Lesson"
                                                    message:@"Do you want to stop this lesson? All progress will be saved."
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
    */
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)runCode:(id)sender
{
    NSLog(@"Function called to run code...");
    
    self.textEditor = self.lineNumberTextView.text;
    NSLog(@"In text editor: %@", self.textEditor);
    
    
	NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:self.textEditor];
    result = [self.webView stringByEvaluatingJavaScriptFromString:self.textEditor];
    
    
    [self.resultsViewController.resultLabel setText:result];
    NSLog(@"Result is: %@", result);
    
    
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
