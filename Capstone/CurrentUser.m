//
//  CurrentUser.m
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "CurrentUser.h"

@implementation CurrentUser

- (NSArray *)usersArray
{
    if (!_usersArray) {
        PFQuery *querey = [PFQuery queryWithClassName:@"users"];
        _usersArray = [[NSArray alloc] initWithArray:[querey findObjects]];
    }
    return _usersArray;
}

- (NSString *)getCurrentUser
{
    if (!_user) {
        _user = [PFUser currentUser];
    }
    self.username = _user.username;
    return self.username;
}

- (NSString *)getUserType
{
    for (int i=0; i<[self.usersArray count]; i++) {
        if ([[self getCurrentUser] isEqualToString:[[self.usersArray objectAtIndex:i] valueForKey:@"username"]]) {
            self.userType = [[self.usersArray objectAtIndex:i] valueForKey:@"userType"];
        }
    }
    return self.userType;
}

@end
