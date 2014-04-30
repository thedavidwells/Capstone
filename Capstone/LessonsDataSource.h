//
//  LessonsDataSource.h
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lesson.h"

@interface LessonsDataSource : NSObject

- (instancetype)initWithJSONArray:(NSArray *)jsonArray;
- (Lesson *)lessonWithTitle:(NSString *)lessonTitle;
- (Lesson *)lessonAtIndex:(NSInteger)idx;
- (NSMutableArray *)getAllLessons;
- (NSUInteger)numberOfLessons;
- (NSString *)loadFreeCodeText:(int)stepTracker;

- (NSString*)loadStepText;

@end
