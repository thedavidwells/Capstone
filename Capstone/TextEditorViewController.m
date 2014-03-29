//
//  TextEditorViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "TextEditorViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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
    [self placeStepByStepInstructionView];
    [self placeTextEditorView];
}

- (void)placeStepByStepInstructionView
{
    CGRect stepFrame = CGRectMake(0,
                                  self.navigationController.navigationBar.frame.size.height + 20,
                                  300,
                                  (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + 20)));
    UIView *stepByStepInstructionView = [[UIView alloc] initWithFrame:stepFrame];
    stepByStepInstructionView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    [self.view addSubview:stepByStepInstructionView];
}

- (void)placeTextEditorView
{
    [[UITextView appearance] setTintColor:[UIColor whiteColor]];
    CGRect textEditorViewFrame = CGRectMake(300,
                                      self.navigationController.navigationBar.frame.size.height + 20,
                                      724,
                                      (self.view.bounds.size.width - (self.navigationController.navigationBar.frame.size.height + 20)));
    self.textEditorView = [[UITextView alloc] initWithFrame:textEditorViewFrame];
    self.textEditorView.backgroundColor = UIColorFromRGB(0x6B6B6B);
    self.textEditorView.font = [UIFont systemFontOfSize:18.0];
    self.textEditorView.textColor = [UIColor whiteColor];
    self.textEditorView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textEditorView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.textEditorView];
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
