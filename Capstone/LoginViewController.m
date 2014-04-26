//
//  LoginViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "LoginViewController.h"
#import "StudentViewController.h"
#import "TeacherViewController.h"
#import "CurrentUser.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (nonatomic) CurrentUser *currentUser;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self UISetupForLogIn];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.usernameField.text = nil;
    self.passwordField.text = nil;
    
    // register to notification center for when
    // the keyboard appears and disapears
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)UISetupForLogIn
{
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    self.usernameField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.usernameField.layer.borderWidth = 2;
    self.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"username"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passwordField.layer.borderWidth = 2;
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password"
                                                                               attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.loginButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)loginAction:(id)sender
{
    [PFUser logInWithUsernameInBackground:self.usernameField.text
                                 password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (!error) {
                                            self.userType = [self.currentUser getUserType];
                                            if ([self.userType isEqualToString:@"student"]) {
                                                StudentViewController *studentViewController = [[StudentViewController alloc] init];
                                                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:studentViewController];
                                                nav.modalPresentationStyle = UIModalPresentationFullScreen;
                                                [self presentViewController:nav animated:YES completion:nil];
                                            }
                                            else {
                                                TeacherViewController *teacherViewController = [[TeacherViewController alloc] init];
                                                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:teacherViewController];
                                                nav.modalPresentationStyle = UIModalPresentationFullScreen;
                                                [self presentViewController:nav animated:YES completion:nil];
                                            }
                                        }
                                        else {
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Failed"
                                                                                            message:@"Invalid username or password. Please try again."
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"Okay"
                                                                                  otherButtonTitles:nil];
                                            [alert show];
                                        }
                                    }];
}

# pragma mark - handle scrollView with keyboard

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.width, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect rect = self.scrollView.frame;
    rect.size.height -= keyboardSize.width;
    
    if (!CGRectContainsPoint(rect, self.loginButton.frame.origin))
    {
        CGPoint scrollPoint = CGPointMake(0.0, self.scrollView.frame.origin.y - (keyboardSize.width - self.loginButton.frame.origin.y));
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.scrollView setContentOffset:scrollPoint animated:NO];
        [UIView commitAnimations];
    } 
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
