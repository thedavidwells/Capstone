//
//  QuizzesDataSource.m
//  Capstone
//
//  Created by Stephen Kyles on 3/28/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "QuizzesDataSource.h"

@interface QuizzesDataSource()

@property (nonatomic) NSMutableArray *quizTitles;

@end

@implementation QuizzesDataSource

- (NSMutableArray *)quizTitles
{
    if (!_quizTitles) {
        _quizTitles = [[NSMutableArray alloc] initWithObjects:@"Quiz 1",
                         @"Quiz 2",
                         @"Quiz 3",
                         @"Quiz 4",
                         @"Quiz 5",
                         @"Quiz 6",
                         @"Quiz 7",
                         @"Quiz 8", nil];
    }
    return _quizTitles;
}

- (NSMutableArray *)getQuizTitles
{
    return self.quizTitles;
}

@end