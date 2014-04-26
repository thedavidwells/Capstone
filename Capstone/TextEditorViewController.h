//
//  TextEditorViewController.h
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
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
