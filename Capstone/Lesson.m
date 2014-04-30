//
//  Lesson.m
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import "Lesson.h"

@interface Lesson()
@property (nonatomic) NSMutableDictionary *lessonAttrs;
@end

@implementation Lesson

- (id)initWithDictionary:(NSDictionary *)dictionary
{
	if( (self = [super init]) == nil)
		return nil;
	self.lessonAttrs = [NSMutableDictionary dictionaryWithDictionary:dictionary];
	return self;
}

- (NSString *)title
{
	return [self.lessonAttrs valueForKey: @"title"];
}

- (NSString *)index
{
	return [self.lessonAttrs valueForKey: @"id"];
}

- (NSString *)lessonDescription
{
	return [self.lessonAttrs valueForKey: @"description"];
}

- (NSArray*)sublessons
{
    return [self.lessonAttrs valueForKey: @"sublessons"];
}

- (NSUInteger)numberOfSubLessons
{
    return [[self.lessonAttrs valueForKey: @"sublessons"] count];
}

- (NSArray*)sublessonSteps
{
    return [[self.lessonAttrs valueForKey: @"sublessons"] valueForKey:@"steps"];
}

- (NSUInteger)numberOfSubLessonSteps
{
    return [[[self.lessonAttrs valueForKey: @"sublessons"] valueForKey:@"steps"] count];
}

- (void)print
{
    NSLog(@"dictionary: %@", self.lessonAttrs);
    NSLog(@"dictionary: %lu", (unsigned long)[[self.lessonAttrs valueForKey: @"sublessons"] count]);
}

@end
