//
//  StudentViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "StudentViewController.h"

static const int navBarHeight = 44;
static const int statusBarHeight = 20;

@interface StudentViewController ()
@property (nonatomic) CGRect viewFrame;
@property (nonatomic) UITableView *tView;
@property (nonatomic) NSMutableArray *lessonNames;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // height and width are switched to account for iPad's orientation
    self.viewFrame = CGRectMake(0, statusBarHeight, self.view.frame.size.height, self.view.frame.size.width - statusBarHeight);
    self.view.frame = self.viewFrame;
    
    self.lessonNames = [[NSMutableArray alloc] initWithObjects:@"Introduction",
                        @"Functions",
                        @"'For' Loops",
                        @"'While' Loops",
                        @"Control Flow",
                        @"Data Structures",
                        @"Objects I",
                        @"Objects II", nil];
    
    [self placeLessonsLabel];
    [self initializeTableView];
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
    lessonsLabel.center = CGPointMake(self.view.bounds.size.width/4, (navBarHeight + statusBarHeight*2));
    lessonsLabel.text = @"Lessons";
    lessonsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lessonsLabel];
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

# pragma mark - table view

- (void)initializeTableView
{
    self.tView = [[UITableView alloc] initWithFrame:CGRectMake(106,
                                                               (navBarHeight + (statusBarHeight*3)),
                                                               300,
                                                               self.view.frame.size.width - (navBarHeight + (statusBarHeight*2)))
                                              style:UITableViewStyleGrouped];
    self.tView.delegate = self;
    self.tView.dataSource = self;
    self.tView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tView];
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
    NSString *s = [self.lessonNames objectAtIndex:indexPath.row];
    
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
}

@end
