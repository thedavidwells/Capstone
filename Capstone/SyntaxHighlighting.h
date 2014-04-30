//
//  SyntaxHighlighting.h
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import "CYRTextView.h"

@interface SyntaxHighlighting : CYRTextView
@property (nonatomic, strong) UIFont *defaultFont;
@property (nonatomic, strong) UIFont *boldFont;
@property (nonatomic, strong) UIFont *italicFont;
@end
