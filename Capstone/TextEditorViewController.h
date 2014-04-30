//
//  TextEditorViewController.h
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsViewController.h"

@class TextEditorViewController;

@protocol TextEditorViewControllerDelegate <NSObject>
- (void)textEditorViewController:(TextEditorViewController *)controller exitedWithStep:(int)stepNumber;
@end

@interface TextEditorViewController : UIViewController <UITextViewDelegate, ResultsViewControllerDelegate>

- (instancetype)initWithSubLessonSteps:(NSArray*)steps;
@property (nonatomic, weak) id <TextEditorViewControllerDelegate> delegate;
@property (nonatomic) NSString *subLessonTitle;

@end
