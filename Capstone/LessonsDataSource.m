//
//  LessonsDataSource.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "LessonsDataSource.h"

@interface LessonsDataSource()

@property (nonatomic) NSMutableArray *lessonTitles;
@property (nonatomic) NSMutableArray *subLessonTitles;

@end

@implementation LessonsDataSource

- (NSMutableArray *)lessonTitles
{
    if (!_lessonTitles) {
        _lessonTitles = [[NSMutableArray alloc] initWithObjects:@"Introduction",
                         @"Functions",
                         @"'For' Loops",
                         @"'While' Loops",
                         @"Control Flow",
                         @"Data Structures",
                         @"Objects I",
                         @"Objects II", nil];
    }
    return _lessonTitles;
}

- (NSMutableArray *)subLessonTitles
{
    if (!_subLessonTitles) {
        _subLessonTitles = [[NSMutableArray alloc] initWithObjects:@"SubLesson 1",
                         @"SubLesson 2",
                         @"SubLesson 3",
                         @"SubLesson 4",
                         @"SubLesson 5", nil];
    }
    return _subLessonTitles;
}

- (NSMutableArray *)getLessonTitles
{
    return self.lessonTitles;
}

- (NSMutableArray *)getSubLessonTitles
{
    return self.subLessonTitles;
}

/*
    hard coded for now, just as a demo
*/
- (NSString *)loadStepStarterText:(int)stepTracker
{
    NSString *starterText = @"// This is a comment";
    return starterText;
}

- (NSString *)loadStepTitleText:(int)stepTracker
{
    NSString *titleText = @"Step Title";
    return titleText;
}

- (NSString *)loadStepText:(int)stepTracker
{
    NSString *titleText = @"This is a body of text that contains one of the steps for the sublesson";
    return titleText;
}

- (NSString *)loadStepGoal:(int)stepTracker
{
    NSString *goalText = @"goal a\n goal b";
    return goalText;
}

@end
