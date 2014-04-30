//
//  SubLessonViewController.h
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
#import "TextEditorViewController.h"
#import "Lesson.h"

@interface SubLessonViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TextEditorViewControllerDelegate>

- (instancetype)initWithLesson:(Lesson*)lessonTitle;

@end
