//
//  policyDetails.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "policyDetails.h"
#import "MainVC.h"
#import "PremiumDetails_FVC.h"

@interface policyDetails ()

@end

@implementation policyDetails

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Details of Policy";
    
    //Left side back Btn
   UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
   [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
   [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

}


-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

-(IBAction)called_OkBtn:(UIButton*)Btn;
{
 if(Btn.tag==11111)
 {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     PremiumDetails_FVC *rootController =(PremiumDetails_FVC*)[storyboard instantiateViewControllerWithIdentifier:@"PremiumDetails_FVC"];
     [self.navigationController pushViewController:rootController animated:YES];
 }
 else
 {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     MainVC *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
     [self.navigationController pushViewController:rootController animated:YES];
 }
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
