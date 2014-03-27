//
//  StudentView.m
//  Capstone
//
//  Created by Stephen Kyles on 3/26/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "StudentView.h"

@interface StudentView()

@end

@implementation StudentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self getStudentProgress];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)getStudentProgress
{
    [self placeProgressLabel];
    [self placeLessonsLabel];
}

- (void)placeProgressLabel
{
    CGRect progressFrame = CGRectMake(self.frame.size.width/4, 20, 100, 50);
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:progressFrame];
    progressLabel.text = @"Progress";
    progressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:progressLabel];
}

- (void)placeLessonsLabel
{
    CGRect lessonsFrame = CGRectMake(self.frame.size.width/4, self.frame.size.height/2, 100, 50);
    UILabel *lessonsLabel = [[UILabel alloc] initWithFrame:lessonsFrame];
    lessonsLabel.text = @"Lessons";
    lessonsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lessonsLabel];
}

@end
