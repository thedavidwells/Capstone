//
//  LineNumberLayoutManager.m
//  Capstone
//
//  Created by Stephen Kyles on 3/30/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "LineNumberLayoutManager.h"

@interface LineNumberLayoutManager ()

@property (nonatomic) NSUInteger lastParagraphLocation;
@property (nonatomic) NSUInteger lastParagraphNumber;

@end

@implementation LineNumberLayoutManager

// keeps track of the last paragraph number found and uses that as the starting point for next paragraph number search
- (NSUInteger)paragraphNumberForRange:(NSRange)charRange
{
    if (charRange.location == self.lastParagraphLocation) {
        return self.lastParagraphNumber;
    }
    else if (charRange.location < self.lastParagraphLocation) {
        // if we need to look backwards from the last known paragraph for the new paragraph range
        NSString *s = self.textStorage.string;
        __block NSUInteger paragraphNumber = self.lastParagraphNumber;
        
        [s enumerateSubstringsInRange:NSMakeRange(charRange.location, self.lastParagraphLocation - charRange.location)
                              options:NSStringEnumerationByParagraphs |
         NSStringEnumerationSubstringNotRequired |
         NSStringEnumerationReverse
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                               if (enclosingRange.location <= charRange.location) {
                                   *stop = YES;
                               }
                               --paragraphNumber;
                           }];
        
        self.lastParagraphLocation = charRange.location;
        self.lastParagraphNumber = paragraphNumber;
        return paragraphNumber;
    }
    else {
        // if we need to look forward from the last known paragraph for the new paragraph range
        NSString* s = self.textStorage.string;
        __block NSUInteger paragraphNumber = self.lastParagraphNumber;
        
        [s enumerateSubstringsInRange:NSMakeRange(self.lastParagraphLocation, charRange.location - self.lastParagraphLocation)
                              options:NSStringEnumerationByParagraphs | NSStringEnumerationSubstringNotRequired
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                               if (enclosingRange.location >= charRange.location) {
                                   *stop = YES;
                               }
                               ++paragraphNumber;
                           }];
        
        self.lastParagraphLocation = charRange.location;
        self.lastParagraphNumber = paragraphNumber;
        return paragraphNumber;
    }
}

- (void)processEditingForTextStorage:(NSTextStorage *)textStorage
                              edited:(NSTextStorageEditActions)editMask
                               range:(NSRange)newCharRange
                      changeInLength:(NSInteger)delta
                    invalidatedRange:(NSRange)invalidatedCharRange
{
    [super processEditingForTextStorage:textStorage edited:editMask range:newCharRange changeInLength:delta invalidatedRange:invalidatedCharRange];
    
    if (invalidatedCharRange.location < self.lastParagraphLocation) {
        // if stored text is deleted above the last paragraph, invaildate the text cache
        self.lastParagraphLocation = 0;
        self.lastParagraphNumber = 0;
    }
}

- (void)drawBackgroundForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin
{
    [super drawBackgroundForGlyphRange:glyphsToShow atPoint:origin];
    
    NSDictionary* atts = @{NSFontAttributeName : [UIFont systemFontOfSize:10.0],
                           NSForegroundColorAttributeName : [UIColor grayColor]};
    
    [self enumerateLineFragmentsForGlyphRange:glyphsToShow
                                   usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange glyphRange, BOOL *stop) {
                                       NSRange charRange = [self characterRangeForGlyphRange:glyphRange actualGlyphRange:nil];
                                       NSRange paragraphRange = [self.textStorage.string paragraphRangeForRange:charRange];
                                       
                                       // only draw line numbers for the paragraph's first line fragment in case the line wraps
                                       // get the line number
                                       if (charRange.location == paragraphRange.location) {
                                           CGRect gutterRect = CGRectOffset(CGRectMake(0, rect.origin.y, 30.0, rect.size.height), origin.x, origin.y);
                                           NSUInteger paragraphNumber = [self paragraphNumberForRange:charRange];
                                           NSString *lineNumber = [NSString stringWithFormat:@"%ld:", (unsigned long) paragraphNumber + 1];
                                           CGSize size = [lineNumber sizeWithAttributes:atts];
                                           [lineNumber drawInRect:CGRectOffset(gutterRect, CGRectGetWidth(gutterRect) - 4 - size.width, (CGRectGetHeight(gutterRect) - size.height) / 2.0)
                                           withAttributes:atts];
                                       }
                                   }];
}

@end
