//
//  ViewController.m
//  FuelPadi
//
//  Created by Shirish Vispute on 09/06/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Reachability.h"
#import "emailVerfication_code.h"
#import "Constant.h"
#import <Social/Social.h>

@interface LoginVC ()
{
    NSString *latitude ;
    NSString *longitude;
    float lat;
    float longi;
    UILabel *locationLabel;
    UIColor *colour;
}
@end


@implementation LoginVC
@synthesize  loginButton,FacebookCustom,indicator,signUp,fogetpasswordBtn;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    emailId.delegate=self;
    Password.delegate=self;
    [Password setPlaceholder:NSLocalizedString(@"Password", nil)];
    colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0]; // 

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, emailId.frame.size.height - 1, emailId.frame.size.width+200, 1.0f);
    bottomBorder.backgroundColor = [UIColor whiteColor].CGColor;
    [emailId.layer addSublayer:bottomBorder];
    
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, Password.frame.size.height - 1, Password.frame.size.width+200, 1.0f);
    bottomBorder1.backgroundColor = [UIColor whiteColor].CGColor;
    [Password.layer addSublayer:bottomBorder1];
    
     [emailId setPlaceholder:NSLocalizedString(@"Email Id", nil)];
     [Password setPlaceholder:NSLocalizedString(@"Password", nil)];
    [Login setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
    [FacebookCustom setTitle:NSLocalizedString(@"Login Via Facebook", nil) forState:UIControlStateNormal];
    [fogetpasswordBtn setTitle:NSLocalizedString(@"Forget Password", nil) forState:UIControlStateNormal];
    [signUp setTitle:NSLocalizedString(@"Sign Up", nil) forState:UIControlStateNormal];
 
}


-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

#pragma mark -- Methods - facebookloginButtonClicked, RegisterNewUser & Prepare of Segue

-(IBAction)facebookloginButtonClicked:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
   
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if(error) { 
             //NSLog(@"Process error");
         } 
         else if(result.isCancelled) {
             //NSLog(@"Cancelled");
         } 
         else
         {
             //NSLog(@"result is:%@",result);
         
           if([FBSDKAccessToken currentAccessToken]) 
             {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, email, id"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      
                      if(!error)
                      {
                          //NSLog(@"Fetched user :: %@", result);
                          
                          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Image Share on Facebook done" delegate:self cancelButtonTitle:@"OKKKK" otherButtonTitles:nil];
                      
                          NSDictionary *Dict = [[NSDictionary alloc]initWithDictionary:result];
                          [self Login_Facebook:Dict];
                          
                          [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                          [[NSUserDefaults standardUserDefaults]synchronize];
                      }
                      else
                      {
                          //NSLog(@"Error Facebook :: %@",error);
                      }
                  }];
             }
         }
     }];
}


-(IBAction)RegisterNewUser:(id)sender;
{
  [self performSegueWithIdentifier:@"register" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{ 
    if ([[segue identifier] isEqualToString:@"facebooklogin"]) 
    {
      [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else if ([[segue identifier] isEqualToString:@"googlelogin"]) 
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else if ([[segue identifier] isEqualToString:@"register"]) 
    {
   }
    else if ([[segue identifier] isEqualToString:@"forgot"]) 
    {
     }
} 

#pragma mark --- Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [textField resignFirstResponder];
    if(textField.tag==1336)
    {
        [self loginButtonClicked:loginButton];
    }
    return YES;
}

#pragma mark-- Facebook login Button clicked

-(void)Login_Facebook:(NSDictionary*)dict
{
    //NSLog(@"%@",dict,[dict valueForKey:@"id"],[dict valueForKey:@"email"],[dict valueForKey:@"first_name"]);
    NSString *firstname = [NSString stringWithFormat:@"%@",[dict valueForKey:@"first_name"]];
    NSString *email = [NSString stringWithFormat:@"%@",[dict valueForKey:@"email"]];
    NSString *facebook_id = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    
    //NSLog(@"CAlled Facebook :: %@,%@,%@",firstname,email,facebook_id);
    BOOL Network=[self Reachability_To_Chechk_Network];
    
if(Network)
{   
  if(firstname.length>0 && facebook_id>0)
    {
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
        self.indicator.center = self.view.center;
        self.indicator.color=colour;
        self.indicator.layer.cornerRadius=10;
        [self.indicator setBackgroundColor:[UIColor whiteColor]];
        self.indicator.layer.zPosition++;
        self.indicator.layer.zPosition++;
        
        [self.indicator startAnimating];
        [self.view addSubview:indicator];
        
        NSOperationQueue *myQueuesvc = [[NSOperationQueue alloc] init];
        [myQueuesvc addOperationWithBlock:^{
            
            NSString *myRequestString = [NSString stringWithFormat:@"%@registration_new.php",kAPIEndpointLatestPath];
            
            NSDictionary *userNameDict = @{@"facebook_id" : facebook_id,
                                           @"name" : firstname
                                           };
            if(email.length>0)
            {
                userNameDict = @{
                                 @"facebook_id" : facebook_id,
                                 @"name" : firstname,
                                 @"email" :email
                                 };
            }
            //    NSDictionary *userNameDict;
            NSError  *error;
            //NSLog(@"userNameDictVC :: %@",userNameDict);
            
            NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
            
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

            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                //NSLog(@"Postdata to server VC F :: %@",response2);
                if(response2.length>0)
                {
                    NSDictionary *jsonObject=[NSJSONSerialization
                                              JSONObjectWithData:returnData
                                              options:NSJSONReadingMutableLeaves
                                              error:nil];
                    //NSLog(@"JSF :: %@",jsonObject);
                    
                    // userid
                    NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                    
                    NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                    
                    NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                    
                    //NSLog(@"USER LOGIN ID :: %@",str1);
                    
                    //NSLog(@"Facebook REsponse called :: %@",str);
                    
                    if([strVerify isEqualToString:@"Success"])
                    {
                        //LOGGED IN CODE KEY
                        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                        //NSLog(@"FAcebook str1 ::- %@",str1);
                        
                        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebook_id"];
                        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"USERID"];
                        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebookID"];
                        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        
                        NSString *myRequestString = [NSString stringWithFormat:@"%@sendGCMKey.php",kAPIEndpointLatestPath];
                        
                        // DeviceToken
                        NSString *deviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
                        NSString *str=@"IOS";
                        NSDictionary *userNameDict = @{
                                                       @"DeviceID" : deviceID,
                                                       @"DeviceOS" : str,
                                                       @"GCMKey" : deviceID,
                                                       @"user_id" : str1
                                                       };
                        // NSDictionary *userNameDict;
                        NSError  *error;
                        //NSLog(@"userNameDictVC :: %@",userNameDict);
                        
                        NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
                        
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
                        //NSLog(@"Postdata to server :: %@",response2);
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"User logged in successfully!", nil) message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                        [alert show];
                        
                        [self performSegueWithIdentifier:@"GTOM" sender:self];
                        
                    }
                    else
                    {
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                        [alert show];
                    }
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                    [alert show];
                }
                
                [self.indicator setHidden:YES];
                
                [self.indicator removeFromSuperview];
            }];
        }];
        
      
    }
    else
    {
        NSString *str=NSLocalizedString(@"Please enter all fields", nil);
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" " message:str delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    } 
}
else
{
    NSString *str=@"Check Network!!!";
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No Network Connection!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
    [alert show];
}
}

#pragma mark-- Login Button Clicked

-(IBAction)loginButtonClicked:(id)sender;
{
   BOOL Network=[self Reachability_To_Chechk_Network];
    if(Network){
    
        
        BOOL ValEmail = [self validateEmailWithString:emailId.text];
        
        if(ValEmail==YES)
        {
            if(emailId.text.length>0 && Password.text.length>0)
            { 
                self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
                self.indicator.center = self.view.center;
                self.indicator.color=colour;
                [self.indicator setBackgroundColor:[UIColor whiteColor]];
                self.indicator.layer.cornerRadius=10;
                
                self.indicator.layer.zPosition++;
                self.indicator.layer.zPosition++;
                
                [self.indicator startAnimating];
                [self.view addSubview:indicator];
                
                NSOperationQueue *myQueuesvc = [[NSOperationQueue alloc] init];
                [myQueuesvc addOperationWithBlock:^{
                 
                    NSString *myRequestString = [NSString stringWithFormat:@"%@logincheck.php",kAPIEndpointLatestPath];
                    
                    NSDictionary *userNameDict = @{
                                                   @"email" : emailId.text,
                                                   @"password" : Password.text
                                                   };
                    // NSDictionary *userNameDict;
                    NSError  *error;
                    //NSLog(@"userNameDictVC :: %@",userNameDict);
                    
                    NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
                    
                    //NEW
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
                    //NSLog(@"Postdata to server :: %@",response2);
                    
                    NSString *str;
                    NSString *strmessage;
                    NSDictionary *jsonObject;
                    if(response2.length>0)
                    {
                        jsonObject = [NSJSONSerialization
                                      JSONObjectWithData:returnData
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
                        //NSLog(@"JS :: %@",jsonObject);
                        
                        str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                        strmessage = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                        strmessage = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message_eng"]];
                    }
                    else
                    {
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                        [alert show];
                    }
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        if([str isEqualToString:@"Success"])
                        {
                            [indicator setHidden:YES];
                            
                            NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                            //NSLog(@"Lgoin Called str1 ::- %@",str1);
                            [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"USERID"];
                            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                     
                            NSString *myRequestString = [NSString stringWithFormat:@"%@sendGCMKey.php",kAPIEndpointLatestPath];
                            
                            // DeviceToken
                            NSString *deviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
                            NSString *str=@"IOS";
                            
                            NSDictionary *userNameDict = @{
                                                           @"DeviceID" : deviceID,
                                                           @"DeviceOS" : str,
                                                           @"GCMKey" : deviceID,
                                                           @"user_id" : str1
                                                           };
                            // NSDictionary *userNameDict;
                            NSError  *error;
                            //NSLog(@"userNameDictVC :: %@",userNameDict);
                            
                            NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
                            
                            //NEW
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
                            
                            //NSLog(@"Postdata to server :: %@",response2);
                        
                            NSString  *str11  = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                            
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                            [alert show];
                            
                            [self performSegueWithIdentifier:@"GTOM" sender:self];
                        }
                        else
                        {
                            if([strmessage isEqualToString:@"Email is not verified.!"])
                            {
                                [self.indicator stopAnimating];
                                [indicator setHidden:YES];
                                
                                
                                [[NSUserDefaults standardUserDefaults]setObject:emailId.text forKey:@"userEmail"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                                      
                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                emailVerfication_code *rootController =(emailVerfication_code*)[storyboard instantiateViewControllerWithIdentifier:@"emailVerfication_code"];
                                [self.navigationController pushViewController:rootController animated:YES];
                                
                                NSString  *str11  =@"電子郵件未驗證。";
                                [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                //NSLog(@"Str 11 :: %@",str11);//(@"");
                                
                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                [alert show];
                            }
                            else
                            {
                                [self.indicator stopAnimating];
                                self.indicator.hidden=YES;
                                [indicator setHidden:YES];
                                
                                NSString  *str11  = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                
                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                [alert show];
                            } 
                        }
                        [self.indicator setHidden:YES];
                        [self.indicator removeFromSuperview];
                    }];
                }];
            }
            else
            {
                NSString *str=NSLocalizedString(@"Please enter all fields", nil);
                //All the fields are mandatory
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please Enter Valid Email ID", nil) message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show]; 
            
        }   
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No Network Connection!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
        [alert show];
    }
}


- (BOOL)validateEmailWithString:(NSString*)email
{   
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
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
