//
//  LessonsDataSource.h
//  Capstone
//
//  Created by Stephen Kyles on 3/27/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonsDataSource : NSObject

- (NSMutableArray *)getLessonTitles;
- (NSMutableArray *)getSubLessonTitles;

- (NSString *)loadStepStarterText:(int)stepTracker;
- (NSString *)loadStepTitleText:(int)stepTracker;
- (NSString *)loadStepText:(int)stepTracker;

@end
