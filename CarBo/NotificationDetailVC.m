//
//  NotificationDetailVC.m
//  CarBo
//
//  Created by Shirish Vispute on 31/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "NotificationDetailVC.h"
#import "notificationListVC.h"
#import "Constant.h"
#import "Reachability.h"

@implementation NotificationDetailVC
@synthesize notificationlabel,notificationlabelA,notificationDAteA,notificationDAte,OkBtn,label_notification;


-(void)viewDidLoad
{
    
    NSString *Noti=[NSString stringWithFormat:NSLocalizedString(@"Notification Detail", nil)];
    
    self.navigationItem.title = Noti;
   // self.navigationItem.title = @"Notification Detail";
    Noti=[NSString stringWithFormat:NSLocalizedString(@"Notification Message", nil)];
    [label_notification setText:Noti];
    
    UIColor *colour = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    
    [notificationlabel setTextColor:colour];

    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
        [backButton setImage:[UIImage imageNamed:@"right-256MM.png"]  forState:UIControlStateNormal];
    ///mobile-nav.png back.png
    
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
 
    [OkBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
  
}

-(void)viewWillAppear:(BOOL)animated
{
    notificationlabel.text = notificationlabelA;
    
    notificationDAte.text  = notificationDAteA;
}


-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    notificationListVC  *rootController =(notificationListVC*)[storyboard instantiateViewControllerWithIdentifier:@"notificationListVC"];
}

- (IBAction)OKButtonClicked:(id)sender;
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- Reachability
-(BOOL)Reachability_To_Chechk_Network
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        //NSLog(@"Not REachable");
        return NO;
        //No internet
    }
    else if (status == ReachableViaWiFi)
    {
        //NSLog(@"REachable via WIFI");
        //WiFi
        return YES;
    }
    else if (status == ReachableViaWWAN)
    {
        //NSLog(@"REachable Mobile network 3G");
        //3G
        return YES;
    }
    else
    {
        //NSLog(@"Not Reachable");
        return NO;
    }
}


#pragma mark - color 

-(UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    return color;
}

-(unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    return hexInt;
}

@end
