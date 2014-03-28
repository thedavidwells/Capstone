//
//  StudentViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "StudentViewController.h"
#import "LessonsDataSource.h"
#import "QuizzesDataSource.h"
#import "SubLessonViewController.h"
#import "CurrentUser.h"

static const int navBarHeight = 44;
static const int statusBarHeight = 20;

@interface StudentViewController ()
@property (nonatomic) CurrentUser *currentUser;
@property (nonatomic) LessonsDataSource *lessonsDataSource;
@property (nonatomic) QuizzesDataSource *quizzesDataSource;
@property (nonatomic) CGRect viewFrame;
@property (nonatomic) UITableView *lessonTableView;
@property (nonatomic) UITableView *quizTableView;
@end

@implementation StudentViewController

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

- (LessonsDataSource *)lessonsDataSource
{
    if (!_lessonsDataSource) {
        _lessonsDataSource = [[LessonsDataSource alloc] init];
    }
    return _lessonsDataSource;
}

- (QuizzesDataSource *)quizzesDataSource
{
    if (!_quizzesDataSource) {
        _quizzesDataSource = [[QuizzesDataSource alloc] init];
    }
    return _quizzesDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // height and width are switched to account for iPad's orientation
    self.viewFrame = CGRectMake(0, statusBarHeight, self.view.frame.size.height, self.view.frame.size.width - statusBarHeight);
    self.view.frame = self.viewFrame;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [self.currentUser getFirstAndLastName];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                          target:self
                                                                                          action:@selector(logoutAction:)];
    [self placeLessonsLabel];
    [self placeQuizzesLabel];
    [self initializeTableViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)placeLessonsLabel
{
    CGRect lessonsFrame = CGRectMake(0, 0, 100, 50);
    UILabel *lessonsLabel = [[UILabel alloc] initWithFrame:lessonsFrame];
    lessonsLabel.center = CGPointMake(self.view.bounds.size.width/4, (navBarHeight + statusBarHeight*3));
    lessonsLabel.text = @"Lessons";
    lessonsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lessonsLabel];
}

- (void)placeQuizzesLabel
{
    CGRect quizzesFrame = CGRectMake(0, 0, 100, 50);
    UILabel *quizzesLabel = [[UILabel alloc] initWithFrame:quizzesFrame];
    quizzesLabel.center = CGPointMake(self.view.bounds.size.width/4 + self.view.bounds.size.width/2, (navBarHeight + statusBarHeight*3));
    quizzesLabel.text = @"Quizzes";
    quizzesLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:quizzesLabel];
}

- (IBAction)logoutAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout"
                                                    message:@"Do you want to logout of <capstone>?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!buttonIndex == 0) {
        [PFUser logOut];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

# pragma mark - table view

- (void)initializeTableViews
{
    self.lessonTableView = [[UITableView alloc] initWithFrame:CGRectMake(106,
                                                               (navBarHeight + (statusBarHeight*4)),
                                                               300,
                                                               self.view.frame.size.width - (navBarHeight + (statusBarHeight*2)))
                                              style:UITableViewStyleGrouped];
    self.lessonTableView.delegate = self;
    self.lessonTableView.dataSource = self;
    self.lessonTableView.backgroundColor = [UIColor whiteColor];
    self.lessonTableView.scrollEnabled = NO;
    [self.view addSubview:self.lessonTableView];
    
    self.quizTableView = [[UITableView alloc] initWithFrame:CGRectMake(618,
                                                                (navBarHeight + (statusBarHeight*4)),
                                                                300,
                                                                self.view.frame.size.width - (navBarHeight + (statusBarHeight*2)))
                                                        style:UITableViewStyleGrouped];
    self.quizTableView.delegate = self;
    self.quizTableView.dataSource = self;
    self.quizTableView.backgroundColor = [UIColor whiteColor];
    self.quizTableView.scrollEnabled = NO;
    [self.view addSubview:self.quizTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (tableView == self.lessonTableView) {
        NSString *s = [[self.lessonsDataSource getLessonTitles] objectAtIndex:indexPath.row];
        cell.textLabel.text = s;
    }
    else {
        NSString *s = [[self.quizzesDataSource getQuizTitles] objectAtIndex:indexPath.row];
        cell.textLabel.text = s;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row %li was selected", indexPath.row);
    
    if (tableView == self.lessonTableView) {
        SubLessonViewController *subLessonViewController = [[SubLessonViewController alloc] initWithLesson:[[self.lessonsDataSource getLessonTitles] objectAtIndex:indexPath.row]];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:subLessonViewController];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
        [self.lessonTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", [[self.quizzesDataSource getQuizTitles] objectAtIndex:indexPath.row]]
                                                        message:[NSString stringWithFormat:@"%@ is unavailable at this time. Please contact your teacher if you think this is in error.", [[self.quizzesDataSource getQuizTitles] objectAtIndex:indexPath.row]]
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
        [self.quizTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
