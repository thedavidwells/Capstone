//
//  FreeTextResultsVC.h
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



@interface FreeTextResultsVC : UIViewController


@property (nonatomic) NSString *result;
@property (nonatomic) UILabel *resultLabel;
@property (nonatomic) int stepNumber;
@property (nonatomic) BOOL correctStatus;

@end

