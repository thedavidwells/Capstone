//
//  SupportTableViewController.m
//  Capstone
//
//  Created by Stephen Kyles on 3/16/14.
//  Copyright (c) 2014 Blue Owl Labs. All rights reserved.
//

#import "SupportTableViewController.h"

@interface SupportTableViewController ()

@end

@implementation SupportTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Support";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSString *emailTitle = @"<capstone> Support";
        NSString *messageBody = @"";
        NSArray *toRecipents = [NSArray arrayWithObject:@"info@blueowlvines.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        mc.navigationBar.translucent = NO;
        mc.navigationBar.tintColor = [UIColor whiteColor];
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
