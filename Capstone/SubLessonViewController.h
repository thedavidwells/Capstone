//
//  SubLessonViewController.h
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson.h"

@interface SubLessonViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithLesson:(Lesson*)lessonTitle;

@end
