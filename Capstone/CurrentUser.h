//
//  CurrentUser.h
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
#import <Parse/Parse.h>

@interface CurrentUser : NSObject

@property (nonatomic) PFUser *user;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *userType;
@property (nonatomic) NSArray *usersArray;

- (NSString *)getCurrentUser;
- (NSString *)getUserType;
- (NSString *)getFirstAndLastName;

/*
Other things a current user may have...
 image
 
 if (student)
 lesson score
 quiz score
*/

@end
