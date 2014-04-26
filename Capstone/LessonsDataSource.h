//
//  LessonsDataSource.h
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lesson.h"

@interface LessonsDataSource : NSObject

- (instancetype)initWithJSONArray:(NSArray *)jsonArray;
- (Lesson *)lessonWithTitle:(NSString *)lessonTitle;
- (Lesson *)lessonAtIndex:(NSInteger)idx;
- (NSMutableArray *)getAllLessons;
- (NSUInteger)numberOfLessons;
- (NSString *)loadFreeCodeText:(int)stepTracker;
- (NSString *)loadExampleSyntaxHighlightingText;
- (NSString*)loadStepText;

@end
