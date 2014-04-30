//
//  LineNumberTextView.m
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import "LineNumberTextView.h"
#import "LineNumberLayoutManager.h"

@implementation LineNumberTextView

- (id)initWithFrame:(CGRect) frame {
    NSTextStorage *textStorage = [[NSTextStorage alloc] init];
    LineNumberLayoutManager *lineNumberLayoutManager = [[LineNumberLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    // wrap text to the textView's frame
    textContainer.widthTracksTextView = YES;
    
    // exclude the line number gutter from the display area available for text
    textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, 40.0, CGFLOAT_MAX)]];
    
    [lineNumberLayoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:lineNumberLayoutManager];
    
    if ((self = [super initWithFrame:frame textContainer:textContainer])) {
        self.typingAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0],
                                  NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]};
    }
    return self;
}

@end
