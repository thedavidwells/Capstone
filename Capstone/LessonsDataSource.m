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

- (NSString *)loadExampleSyntaxHighlightingText
{
    NSString *example = @"// Test comment\n\n"\
    @"// Let's solve our first equation\n"\
    @"x = 1 / (1 + x) // equation to solve for x\n"\
    @"x > 0 // restrict to positive root\n\n"\
    @"// Let's create a user function\n"\
    @"// The standard function random returns a random value between 0 an 1\n"\
    @"g(x) := 0.005 * (x + 1) * (x - 1) + 0.1 * (random - 0.5)\n\n"\
    @"// Now let's plot the two functions together on one chart\n"\
    @"plot f(x), g(x)";
    
    return example;
}

@end
