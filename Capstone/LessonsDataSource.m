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
    NSLog(@"all lessons: %@", self.allLessons);
    
    return self.allLessons;
}

- (NSUInteger)numberOfLessons
{
	return [self.allLessons count];
}

- (NSString *)loadFreeCodeText:(int)stepTracker
{
    NSString *freeCodeText = @"// Welcome to your free code playground! \n// Write some code and have fun! \n";
    return freeCodeText;
}

@end
