//
//  Lesson.h
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

@interface Lesson : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString*)title;
- (NSString*)index;
- (NSString *)lessonDescription;
- (NSUInteger)numberOfSubLessons;
- (NSUInteger)numberOfSubLessonSteps;
- (NSArray*)sublessons;
- (NSArray*)sublessonSteps;
- (void)print;

@end
