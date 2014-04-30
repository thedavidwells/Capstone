//
//  FreeTextViewController.h
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeTextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic) NSString *textEditor;

@property (nonatomic) UILabel *resultLabel;

@property (nonatomic) UIWebView *webView;

@end
