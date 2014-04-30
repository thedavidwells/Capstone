//
//  DownloadAssistant.m
//
//  CourseOwl
//
//  CS470 - Capstone
//  Spring 2014
//
//  Created by Stephen Kyles, David Wells, and Eric Wooley.
//  Copyright (c) 2014. All rights reserved.
//

#import "DownloadAssistant.h"
#import <Parse/Parse.h>

@implementation DownloadAssistant

+ (DownloadAssistant *)sharedInstance
{
    static DownloadAssistant *instance = nil;
    if( ! instance )
        instance = [[DownloadAssistant alloc] init];
    return instance;
}

- (instancetype)init
{
    if( (self = [super init]) == nil )
        return nil;
    
    PFQuery *courseQuery = [PFQuery queryWithClassName:@"Course"];
    self.lessonsDataSource = [[LessonsDataSource alloc] initWithJSONArray:[[courseQuery getObjectWithId:@"w9IzbA6xU3"] valueForKey:@"lessons"]];
    
    return self;
}

@end
