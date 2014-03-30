//
//  TextEditorViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "TextEditorViewController.h"
#import "ResultsViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static const int statusBarHeight = 20;

@interface TextEditorViewController ()
@property (nonatomic) NSString *subLessonTitle;
@property (nonatomic) UITextView *textEditorView;
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
    [self placeLineNumberLabels];
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
    [[UITextView appearance] setTintColor:[UIColor whiteColor]];
    CGRect textEditorViewFrame = CGRectMake(340,
                                      self.navigationController.navigationBar.frame.size.height + statusBarHeight,
                                      724-35,
                                      (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + statusBarHeight)));
    self.textEditorView = [[UITextView alloc] initWithFrame:textEditorViewFrame];
    self.textEditorView.backgroundColor = UIColorFromRGB(0x6B6B6B);
    self.textEditorView.font = [UIFont systemFontOfSize:18.0];
    self.textEditorView.textColor = [UIColor whiteColor];
    self.textEditorView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textEditorView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.textEditorView];
}


- (void)placeLineNumberLabels
{
    CGRect lineNumbersFrame = CGRectMake(299,
                                         self.navigationController.navigationBar.frame.size.height + statusBarHeight + 8,
                                         45,
                                         150);
    
    UILabel *lineNumbers = [[UILabel alloc] initWithFrame:lineNumbersFrame];
    lineNumbers.backgroundColor = [UIColor whiteColor];
    lineNumbers.font = [UIFont systemFontOfSize:18.0];
    lineNumbers.textColor = [UIColor blackColor];
    lineNumbers.textAlignment = NSTextAlignmentRight;
    int numberOfLines = self.textEditorView.contentSize.height / self.textEditorView.font.lineHeight;
    NSLog(@"Number of Lines: %d", numberOfLines);
    
    
    NSMutableArray *lineNumberArray = [NSMutableArray new];
    
    for (int i = 1; i <= numberOfLines+1; i++) {
        if (i < 10) {
            NSString *lineNum = [NSString stringWithFormat:@"   %d: ", i];
            NSLog(@" %d: ", i);
            [lineNumberArray addObject:lineNum];
        }else{
            NSString *lineNum = [NSString stringWithFormat:@" %d: ", i];
            NSLog(@"%d: ", i);
            [lineNumberArray addObject:lineNum];
        }
        
    }
    lineNumbers.text =  [lineNumberArray componentsJoinedByString:@" \n"];
    [lineNumbers adjustsFontSizeToFitWidth];
    [lineNumbers setNumberOfLines:0];
    [lineNumbers sizeToFit];
    
    [self.view addSubview:lineNumbers];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
