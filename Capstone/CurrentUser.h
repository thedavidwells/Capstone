//
//  CurrentUser.h
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
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

/*
Other things a current user may have...
 image
 
 if (student)
 lesson score
 quiz score
*/

@end
