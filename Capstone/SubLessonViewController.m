//
//  SubLessonViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "SubLessonViewController.h"
#import "TextEditorViewController.h"
#import "LessonsDataSource.h"
#import "CurrentUser.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SubLessonViewController ()
@property (nonatomic) CurrentUser *currentUser;
@property (nonatomic) Lesson *lesson;
@property (nonatomic) NSString *lessonTitle;
@property (nonatomic) UITableView *tView;
@property (nonatomic) LessonsDataSource *lessonsDataSource;
@end

@implementation SubLessonViewController


- (CurrentUser *)currentUser
{
    if (!_currentUser) {
        _currentUser = [[CurrentUser alloc] init];
    }
    return _currentUser;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithLesson:(Lesson*)lesson
{
    if( (self = [super init]) == nil )
        return nil;
    self.lesson = lesson;
    self.lessonTitle = self.lesson.title;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [self.currentUser getFirstAndLastName];
    
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
    lessonTitle.font = [UIFont systemFontOfSize:20.0];
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
    self.tView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 400, self.view.bounds.size.width - self.view.bounds.size.width/2)
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
    return [self.lesson numberOfSubLessons];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *s = [[self.lesson.sublessons objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyCheck"]];
    imgView.center = CGPointMake(cell.frame.size.width + 35, 25);
    [cell addSubview:imgView];
    
    cell.textLabel.text = s;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row %li was selected", indexPath.row);
    
    TextEditorViewController *textEditorViewController = [[TextEditorViewController alloc] initWithSubLessonSteps:[[self.lesson.sublessons objectAtIndex:indexPath.row] valueForKey:@"steps"]];
    textEditorViewController.delegate = self;
    textEditorViewController.subLessonTitle = [[self.lesson.sublessons objectAtIndex:indexPath.row] valueForKey:@"title"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:textEditorViewController];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
    [self.tView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)textEditorViewController:(TextEditorViewController *)controller exitedWithStep:(int)stepNumber
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
