//
//  ViewController.m
//  MeetMeUp
//
//  Created by Nicholas Petersen on 1/20/14.
//  Copyright (c) 2014 Nicholas Petersen. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
{
    NSArray *arrayOfResults;
    NSDictionary *dictionaryOfMeetups;
    __weak IBOutlet UITableView *myTableView;
    NSString *typeOfMeetUp;
    NSString *urlString;
    NSString *urlString2;
    __weak IBOutlet UITextField *searchTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    typeOfMeetUp = @"mobile";
    urlString = @"https://api.meetup.com/2/open_events.json?zip=60604&text=";
    urlString2 = @"&time=,1w&key=477d1928246a4e162252547b766d3c6d";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", urlString, typeOfMeetUp, urlString2]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dictionaryOfMeetups = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [myTableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    arrayOfResults = dictionaryOfMeetups[@"results"];
    return [arrayOfResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:@"MeetMeUpID"];
    NSDictionary *meetUp = arrayOfResults[indexPath.row];
    NSDictionary *venue = meetUp[@"venue"];
    
    cell.textLabel.text = meetUp[@"name"];
    cell.detailTextLabel.text = venue[@"address_1"];
    
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *myDetailViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [myTableView indexPathForCell:sender];
    myDetailViewController.meetUp = arrayOfResults[indexPath.row];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    typeOfMeetUp = searchTextField.text;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", urlString, typeOfMeetUp, urlString2]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dictionaryOfMeetups = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [myTableView reloadData];
    }];
    
    [searchTextField resignFirstResponder];
    
    return YES;
}


@end
