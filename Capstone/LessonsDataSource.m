//
//  LessonsDataSource.m
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "LessonsDataSource.h"
#import <Parse/Parse.h>

static const BOOL _debug = NO;

@interface LessonsDataSource()

@property (nonatomic) NSMutableArray *allLessons;

@end

@implementation LessonsDataSource

- (NSMutableArray *)allLessons
{
    if (!_allLessons)
        _allLessons = [[NSMutableArray alloc] init];
    return _allLessons;
}

- (instancetype)initWithJSONArray:(NSArray *)jsonArray
{
    if((self = [super init]) == nil)
        return nil;
    
    for (NSDictionary *lessonTuple in jsonArray) {
        Lesson *lesson = [[Lesson alloc] initWithDictionary:lessonTuple];
        if (_debug)
            [lesson print];
        [self.allLessons addObject:lesson];
    }
    return self;
}

- (Lesson *)lessonWithTitle:(NSString *)lessonTitle
{
	if([self.allLessons count] == 0)
		return nil;
    for(Lesson *lesson in self.allLessons)
        if([lesson.title isEqualToString:lessonTitle])
            return lesson;
    return nil;
}

- (Lesson *)lessonAtIndex:(NSInteger)idx
{
	if(idx >= [self.allLessons count])
        return nil;
	return [self.allLessons objectAtIndex:idx];
}

- (NSArray *)getAllLessons
{
    return self.allLessons;
}

- (NSUInteger)numberOfLessons
{
	return [self.allLessons count];
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

- (NSString *)loadFreeCodeText:(int)stepTracker
{
    NSString *freeCodeText = @"// Welcome to your free code playground! \n// Write some code and have fun! \n";
    return freeCodeText;
}

@end
