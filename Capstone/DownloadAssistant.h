//
//  DownloadAssistant.h
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LessonsDataSource.h"

@interface DownloadAssistant : NSObject

@property (nonatomic) LessonsDataSource *lessonsDataSource;

+ (DownloadAssistant *)sharedInstance;

@end
