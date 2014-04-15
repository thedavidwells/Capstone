//
//  FreeTextViewController.h
//  Capstone
//
//  Created by David Wells on 3/31/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeTextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic) NSString *textEditor;

@property (nonatomic) UILabel *resultLabel;

@property (nonatomic) UIWebView *webView;

@end
