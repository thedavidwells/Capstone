//
//  SubLessonViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "SubLessonViewController.h"
#import "TextEditorViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SubLessonViewController ()
@property (nonatomic) NSString *lessonTitle;
@property (nonatomic) UITableView *tView;
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
    
    [self placeLessonTitle];
    [self initializeTableView];
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
    exitButton.center = CGPointMake(self.view.bounds.size.height/2, self.view.bounds.size.width - self.view.bounds.size.width/4);
    exitButton.backgroundColor = UIColorFromRGB(0xFC3F3F);
    [exitButton setTitle:@"Exit Lesson" forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(exitLesson:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitButton];
}

- (void)placeLessonTitle
{
    CGRect lessonTitleRect = CGRectMake(0, 0, 200, 50);
    UILabel *lessonTitle = [[UILabel alloc] initWithFrame:lessonTitleRect];
    lessonTitle.center = CGPointMake(self.view.bounds.size.height/2, self.view.bounds.size.width/5.5);
    lessonTitle.text = self.lessonTitle;
    lessonTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lessonTitle];
}

- (IBAction)exitLesson:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - table view

- (void)initializeTableView
{
    self.tView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.bounds.size.width - self.view.bounds.size.width/2)
                                              style:UITableViewStyleGrouped];
    self.tView.delegate = self;
    self.tView.dataSource = self;
    self.tView.backgroundColor = [UIColor whiteColor];
    self.tView.center = CGPointMake(self.view.bounds.size.height/2, self.view.bounds.size.width/2);
    self.tView.scrollEnabled = NO;
    [self.view addSubview:self.tView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *s = @"test"; //[[self.lessonsDataSource getLessonTitles] objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.text = s;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row %li was selected", indexPath.row);
    
    TextEditorViewController *textEditorViewController = [[TextEditorViewController alloc] init]; //initWithLesson:[[self.lessonsDataSource getLessonTitles] objectAtIndex:indexPath.row]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:textEditorViewController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
    [self.tView deselectRowAtIndexPath:indexPath animated:YES];
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
