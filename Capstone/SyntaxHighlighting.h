//
//  SyntaxHighlighting.h
//  Capstone
//
//  Created by David Wells on 4/25/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "CYRTextView.h"

@interface SyntaxHighlighting : CYRTextView
@property (nonatomic, strong) UIFont *defaultFont;
@property (nonatomic, strong) UIFont *boldFont;
@property (nonatomic, strong) UIFont *italicFont;
@end
