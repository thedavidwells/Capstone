//
//  DownloadAssistant.m
//  Capstone
//
//  Created by Stephen Kyles on 4/19/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
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
