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

@end
