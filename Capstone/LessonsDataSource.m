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

- (NSMutableArray *)getLessonTitles
{
    return self.lessonTitles;
}

// hard coded for now, just as a demo
- (NSString *)loadSubLessonStarterText:(int)subLessonTracker
{
    NSString *starterText = @"// This is a comment\n// you can make comments by using '//' to comment a line\n// or you can use '/* ... */' to comment a block of lines\n\n// try making your own comments below";
    return starterText;
}

@end
