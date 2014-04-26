//
//  Lesson.h
//  Capstone
//
//  Created by Stephen Kyles on 4/19/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
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
