//
//  AboutUS.m
//  CarBo
//
//  Created by Shirish Vispute on 02/11/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "AboutUS.h"

@interface AboutUS ()

@end

@implementation AboutUS
@synthesize webViewPage;

#pragma mark --- View Cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"About us", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"logo.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsCompact];
    
    //Back Button
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJumps) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    NSString *urlString = @"http://www.carbo.com.hk";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webViewPage loadRequest:urlRequest];
}

-(void)backJumps
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
