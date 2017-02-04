//
//  policyDetails2.m
//  CarBo
//
//  Created by Shirish Vispute on 19/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "policyDetails2.h"
#import "PremiumDetails_FVC.h"
#import "renewalPolicylist.h"
#import "Constant.h"
#import "Reachability.h"

@interface policyDetails2 ()
{
    NSString  *Policy_ID;
    NSString *discounted_amountStr;;
}
@property (nonatomic) BOOL applePaySucceeded;
@property (nonatomic) NSError *applePayError;
@property (weak, nonatomic) IBOutlet UIButton *applePayButton;

@end

@implementation policyDetails2
@synthesize status_value,disPremium,limited_time,general_excess,tppd,theft_loss,premium_amountVAL,TPPD_textview,TPPD_textview5,
status_value_label,disPremium_label,limited_time_label,general_excess_label,theft_loss_label,tppd_label,premium_amountVAL_label,accept_Btn,
decline_Btn,excesslabel;

#pragma mark -- View Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *strr=@"NO";
    [[NSUserDefaults standardUserDefaults]setObject:strr forKey:@"RD"];
    [[NSUserDefaults standardUserDefaults]synchronize];
  
    NSString *NSlabelDOP=[NSString stringWithFormat:NSLocalizedString(@"Details Of Policy", nil)];
    
    UIColor *colour = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    
    Policy_ID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_id"]];
    
    self.navigationItem.title = NSlabelDOP;
    
    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
   
    //Right side Add button
    UIButton *rightBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 35.0f, 35.0f)];
    [rightBtn setImage:[UIImage imageNamed:@"refresh.png"]  forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(Refreshcalled) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UITapGestureRecognizer *gestLT=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(limitedTime_mth)];
    gestLT.numberOfTapsRequired=1;
    gestLT.delegate=self;
    [limited_time addGestureRecognizer:gestLT];
    
    UITapGestureRecognizer *gestTPPD=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(limitedTPPD_mth)];
    gestTPPD.numberOfTapsRequired=1;
    gestTPPD.delegate=self;
    [tppd addGestureRecognizer:gestTPPD];
  
    [self getdetails];

//  TPPD Textview
    TPPD_textview.layer.cornerRadius=4;
    TPPD_textview.layer.borderColor=[colour CGColor];
    TPPD_textview.layer.borderWidth=1;
    
    NSString *NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"Status", nil)];
    
     [status_value_label setText:NSlabeltext];
    
    NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"Discounted Premium", nil)];
     [disPremium_label setText:NSlabeltext];
    
    NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"Limited Time Offer", nil)];
     [limited_time_label setText:NSlabeltext];
    
    NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"General Excess", nil)];
     [general_excess_label setText:NSlabeltext];
    
    NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"Theft Loss Excess", nil)];
     [theft_loss_label setText:NSlabeltext];
    
    [excesslabel setText:NSLocalizedString(@"Excess", nil)];

    NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"TPPD", nil)];
     [tppd_label setText:NSlabeltext];
    
    NSlabeltext=[NSString stringWithFormat:NSLocalizedString(@"Premium Amount", nil)];
     [premium_amountVAL_label setText:NSlabeltext];
    
    [accept_Btn setTitle:NSLocalizedString(@"Accept", nil) forState:UIControlStateNormal];
    [decline_Btn setTitle:NSLocalizedString(@"Decline", nil) forState:UIControlStateNormal]; 

}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

#pragma mark --Other Methods

-(void)limitedTime_mth
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Limited Time Offer", nil) message:limited_time.text delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
   [alert show];
    //NSLog(@"CAlled Limited Time");
}

-(void)limitedTPPD_mth
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"TPPD", nil) message:tppd.text delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
    //NSLog(@"Called TPPD");
}

-(void)Refreshcalled
{
    [self getdetails];
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- Service Method to Get Policy Details

-(void)getdetails
{
    BOOL Network = [self Reachability_To_Chechk_Network];
    if(Network)
    {
        NSString *myRequestString = [NSString stringWithFormat:@"%@policyInfo.php",kAPIEndpointLatestPath];
        
        NSString *struserid=[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
        
        NSDictionary *userNameDict = @{@"quotation_id" : Policy_ID};
        
        NSError  *error;
        //NSLog(@"userNameDict REviewcalled :: %@",userNameDict);
      
        NSData *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
        NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:myRequestString]];
        // set Request Type
        [request2 setHTTPMethod:@"POST"];
        // Set content-type
        [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        // Set Request Body
        [request2 setHTTPBody:post];
        
        // Now send a request and get Response
        NSData *returnData = [NSURLConnection sendSynchronousRequest: request2 returningResponse: nil error: nil];
        // Log Response
        NSString *response2 = [[NSString alloc]initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
        //NSLog(@"Postdata to server REnewal List:: %@",response2);
        
        //RR
        if(response2.length>6)
        {
            NSDictionary *jsonObject = [NSJSONSerialization
                                        JSONObjectWithData:returnData
                                        options:NSJSONReadingMutableLeaves
                                        error:nil];
            //NSLog(@"Policy Details 2 JSF Object :: %@",jsonObject);
            
            NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
            NSString *strrr=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
            //NSLog(@"strrr :: %@",strrr);
            
            if([str isEqualToString:@"Fail"])
            {
                NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                NSDictionary *dict=[[NSDictionary alloc]initWithDictionary:[jsonObject valueForKey:@"result"]];
                
                NSString *mu = [NSString stringWithFormat:@"%@",[dict valueForKey:@"premium_amount"]];
                
// premium_amount
                NSMutableString *premium_amount = [NSMutableString stringWithString:mu];
                //[premium_amount insertString:@"HK $" atIndex:0];
                [premium_amount replaceOccurrencesOfString:@".0000"
                                                withString:@""
                                                   options:0
                                                     range:NSMakeRange(0, premium_amount.length)];
                premium_amountVAL.text=premium_amount;
                
                [[NSUserDefaults standardUserDefaults]setObject:mu forKey:@"premium_amount"];
                
 //Renewal Amount
                mu = [NSString stringWithFormat:@"%@",[dict valueForKey:@"renewal_amount"]];
                
                NSMutableString *r_amount = [NSMutableString stringWithString:mu];
                [r_amount replaceOccurrencesOfString:@".0000"
                                          withString:@""
                                             options:0
                                               range:NSMakeRange(0, r_amount.length)];
                
                [[NSUserDefaults standardUserDefaults]setObject:mu forKey:@"renewal_amount"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
//Discount Premium Amount
                mu = [NSString stringWithFormat:@"%@",[dict valueForKey:@"discountPremium"]];
                
                discounted_amountStr = mu;
                
                [[NSUserDefaults standardUserDefaults]setObject:mu forKey:@"discountPremium"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSMutableString *discountPremium = [NSMutableString stringWithString:mu];
//                [discountPremium insertString:@"HK $" atIndex:0];
                [discountPremium replaceOccurrencesOfString:@".0000"
                                                 withString:@""
                                                    options:0
                                                      range:NSMakeRange(0, discountPremium.length)];
             disPremium.text=discountPremium;
                
    
//General Excess
                mu = [NSString stringWithFormat:@"%@",[dict valueForKey:@"general_excess"]];
                NSMutableString *general_excesss = [NSMutableString stringWithString:mu];
                [general_excesss replaceOccurrencesOfString:@".0000"
                                                 withString:@""
                                                    options:0
                                                      range:NSMakeRange(0, general_excesss.length)];
                general_excess.text=general_excesss;
                
                //NSLog(@"general_excess:: %@",general_excesss);
                
//Limited Time Offer
                NSString *limited_timee  = [NSMutableString stringWithFormat:@"%@",[dict valueForKey:@"limited_time_offer"]];
                
                NSMutableString *tppdd = [NSMutableString stringWithString:limited_timee];
               limited_time.text=tppdd;
                

//  Theft Loss
                mu = [NSString stringWithFormat:@"%@",[dict valueForKey:@"theft_loss_excess"]];
                NSMutableString *theft_losss= [NSMutableString stringWithString:mu];
               [theft_losss replaceOccurrencesOfString:@".0000"
                                             withString:@""
                                                options:0
                                                  range:NSMakeRange(0, theft_losss.length)];
                
                theft_loss.text=theft_losss;
                
                
                
                
                
//   TPPD Value
                mu = [NSString stringWithFormat:@"%@",[dict valueForKey:@"tppd"]];
               tppd.text=mu;
                [TPPD_textview setText:mu];
                [TPPD_textview5 setText:mu];
                
                
             NSString  *sumbitFlag=[NSString stringWithFormat:@"%@",
                                       [[NSUserDefaults standardUserDefaults]valueForKey:@"submitFlag"]];
                
            NSString *status= [NSMutableString stringWithFormat:@"%@",[dict valueForKey:@"status"]];
                
            NSString *PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Completed", nil)];
                
                if([sumbitFlag isEqualToString:@"1"])
                {
                    if([status isEqualToString:@"Completed"])
                    {
                        status=PolicyType;
                    }
                    else if([status isEqualToString:@"Processing"])
                    {
                        PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Submitted", nil)];
                        status=@"Submitted";
                    }
                    else if([status isEqualToString:@"Pending"])
                    {
                        PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Pending", nil)];
                        status=@"Pending";
                    }  
                }
                else
                {
                    if([status isEqualToString:@"Completed"])
                    {
                        PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Due Renewal", nil)];
                        status=@"Due Renewal";
                    }
                    else if([status isEqualToString:@"Processing"])
                    {
                         PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Processing", nil)];
                        status=@"Processing";
                    }
                    else if([status isEqualToString:@"Pending"])
                    {
                         PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Pending", nil)];
                        status=@"Pending";
                    }  
                }
                status_value.text=PolicyType;
            }

        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
        
       }
else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles:nil];
        [alert show];
    }
}



-(IBAction)called_OkBtn:(UIButton*)Btn;
{
    if(Btn.tag==11112)
    {
        if(premium_amountVAL.text.integerValue >= 2)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PremiumDetails_FVC *rootController = (PremiumDetails_FVC*)[storyboard instantiateViewControllerWithIdentifier:@"PremiumDetails_FVC"];
            [self.navigationController pushViewController:rootController animated:YES];
        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Without Cover note1", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
         }
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        renewalPolicylist *rootController =(renewalPolicylist*)[storyboard instantiateViewControllerWithIdentifier:@"renewalPolicylist"];
        [self.navigationController pushViewController:rootController animated:YES];
    }
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



#pragma mark - colour Objects from hex Strings

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
