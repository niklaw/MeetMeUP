//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Nicholas Petersen on 1/20/14.
//  Copyright (c) 2014 Nicholas Petersen. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController (){
    
    __weak IBOutlet UILabel *rsvpLabel;
    __weak IBOutlet UILabel *groupNameLabel;
    __weak IBOutlet UILabel *groupDescription;
    __weak IBOutlet UITextView *eventDescriptionText;
    __weak IBOutlet UIButton *urlButton;
    
}

@end

@implementation DetailViewController
@synthesize meetUp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *hostingGroupInfo = meetUp[@"group"];
    
    self.navigationItem.title = meetUp[@"name"];
    rsvpLabel.text = [NSString stringWithFormat:@"%@", meetUp[@"yes_rsvp_count"]];
    groupNameLabel.text = hostingGroupInfo[@"name"];
    groupDescription.text = hostingGroupInfo[@"who"];
    eventDescriptionText.text = meetUp[@"description"];
    [urlButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [urlButton setTitle:meetUp[@"event_url"] forState:UIControlStateNormal];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    WebViewController *myWebViewController = segue.destinationViewController;
    myWebViewController.url = [NSURL URLWithString:meetUp[@"event_url"]];
}

@end
