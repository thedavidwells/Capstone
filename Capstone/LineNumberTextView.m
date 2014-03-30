//
//  LineNumberTextView.m
//  Capstone
//
//  Created by Stephen Kyles on 3/30/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "LineNumberTextView.h"
#import "LineNumberLayoutManager.h"

@implementation LineNumberTextView

- (id)initWithFrame:(CGRect) frame {
    NSTextStorage *textStorage = [[NSTextStorage alloc] init];
    LineNumberLayoutManager *lineNUmberLayoutManager = [[LineNumberLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    // wrap text to the textView's frame
    textContainer.widthTracksTextView = YES;
    
    // exclude the line number gutter from the display area available for text
    textContainer.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, 40.0, CGFLOAT_MAX)]];
    
    [lineNUmberLayoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:lineNUmberLayoutManager];
    
    if ((self = [super initWithFrame:frame textContainer:textContainer])) {
        //self.contentMode = UIViewContentModeRedraw; // cause drawRect: to be called on frame resizing and divice rotation
        
        //  I'm finding that this text view is not behaving properly when typing into a new line at the end of the body
        //  of text.  The cursor is positioned inward, and then jumpts back to the propor position when a character is
        //  typed.  I'm sure this has something to do with the view's typingAttributes or one of the delegate methods.
        
        self.typingAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0],
                                  NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]};
    }
    return self;
}

@end
