//
//  DownloadAssistant.h
//  Capstone
//
//  Created by Stephen Kyles on 4/19/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LessonsDataSource.h"

@interface DownloadAssistant : NSObject

@property (nonatomic) LessonsDataSource *lessonsDataSource;

+ (DownloadAssistant *)sharedInstance;

@end
