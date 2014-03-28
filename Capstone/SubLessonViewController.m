//
//  SubLessonViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "SubLessonViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SubLessonViewController ()
@property (nonatomic) NSString *lessonTitle;
@end

@implementation SubLessonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithLesson:(NSString *)lessonTitle
{
    if( (self = [super init]) == nil )
        return nil;
    self.lessonTitle = lessonTitle;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self placeExitButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)placeExitButton
{
    CGRect exitButtonRect = CGRectMake(0, 0, 150, 50);
    UIButton *exitButton = [[UIButton alloc] initWithFrame:exitButtonRect];
    exitButton.center = CGPointMake(self.view.bounds.size.height/2, self.view.bounds.size.width - self.view.bounds.size.width/2);
    exitButton.backgroundColor = UIColorFromRGB(0x00A6FF);
    [exitButton setTitle:@"Exit Lesson" forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(exitLesson:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitButton];
}

- (IBAction)exitLesson:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
