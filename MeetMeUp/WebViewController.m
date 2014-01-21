//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Nicholas Petersen on 1/20/14.
//  Copyright (c) 2014 Nicholas Petersen. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UIActivityIndicatorView *spinner;
    
}

@end

@implementation WebViewController
@synthesize url;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *userURLRequest = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:userURLRequest];
    spinner.hidden = NO;
    [spinner startAnimating];
}

- (IBAction)onBackButtonPressed:(id)sender {
    [myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    [myWebView goForward];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"test");
    [spinner stopAnimating];
    spinner.hidden = YES;
}

@end
