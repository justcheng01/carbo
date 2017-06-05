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
#import "FB_emailVerfication_code.h"
#define MAXLENGTH 8
@interface LoginVC ()
{
    NSString *latitude ;
    NSString *longitude;
    float lat;
    float longi;
    UILabel *locationLabel;
    UIColor *colour;
    NSDictionary *Dict;
    UIView *mpView;
    UITextField *mob_text;
    UITextField *email_text;
    UIButton *mcancelBtn;
    UIButton *mOKBtn;
    NSString *NEWmobile;
    UILabel *mtitle_label;
}
@end

@implementation LoginVC
@synthesize  loginButton,FacebookCustom,indicator,signUp,fogetpasswordBtn,externalSubview,email_Label,email_textfield,cancelBtn,okBtn,mobile_textfield,NokBtn,NcancelBtn,Nemail_label,N_mobile_text;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    NEWmobile = @"345534534";
    
    emailId.delegate=self;
    
    email_text.delegate=self;
    Password.delegate=self;

    mobile_textfield.delegate=self;
    N_mobile_text.delegate=self;
    email_textfield.delegate=self;

    
    
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

// String chinese converstions
//
//<string name="privacypolicy">
//<u>Privacy Policy</u>
//</string>
//<string name="EnterYourPhoneNo">輸入電話號碼</string>
//<string name="YourDetails">你的資料</string>
//<string name="DrivingExp">牌齡</string>
//<string name="AGE">年齡</string>
//<string name="PleaseEnterValidMobileNo">請輸入有效的電話號碼</string>
//<string name="EnterEmailPhoneNo">輸入電子郵件和電話號碼</string>

-(void)viewWillAppear:(BOOL)animated
{
    //[self call_profile_Detail_view_NCD_AGE_EXP];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [email_textfield resignFirstResponder];
    BOOL Bool =  [self check_version];        //Call To Check The Current Version
   // BOOL Bool =  YES;   /// [self needsUpdate];        //Call To Check The Current Version
    
    if(Bool)
    {
        //NSLog(@"Latest Build ");
    }
    else
    {
        //NSLog(@"Build OLD ");
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString* appID = infoDictionary[@"CFBundleIdentifier"];

        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=<%@>&mt=8", appID]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/hk/app/apple-store/%@?mt=8", appID]];
        url = [NSURL URLWithString:@"https://itunes.apple.com/hk/app/apple-store/id1180974630?mt=8"];
        
     //  url = [NSURL URLWithString:[NSString stringWithFormat:@" https://itunes.apple.com/in/app/carbo-car-insurance-%E6%B1%BD%E8%BB%8A%E4%BF%9D%E9%9A%AA/%@?mt=8", appID]];
     //    https://itunes.apple.com/us/app/apple-store/id1180974630?mt=8
     //     https://itunes.apple.com/us/app/carbo-car-insurance-汽車保險/id1180974630?mt=8
     //     https://itunes.apple.com/us/app/apple-store/%@?mt=8 //OLD
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CARBO 已有新版本" message:@"我們改良了App, 請更新新版本！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [[UIApplication sharedApplication] openURL:url];
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 exit(0);
                                                             }];
        [alert addAction:cancelAction];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


//-(void)call_profile_Detail_view_NCD_AGE_EXP
//{
//
//    UIView *pView;
//    UIButton *OKBtn;
//    UIButton *cancelBtn;
//    UILabel *drivingExp;
//    UILabel *val_drivingExp;
//    UILabel *age;
//    UILabel *val_age;
//    UILabel *dialogNo;
//    UILabel *val_NCD;
//  
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    CGFloat margin = 28.0F;
//    
//        //    tvDrivingExp, tvAge,tvNCDTest,tvDialogNo,tvDialogYes
//        [pView removeFromSuperview];
//    // margin, margin, alertController.view.bounds.size.width - margin * 4.0F, 100.0F
//        pView=[[UIView alloc]initWithFrame:CGRectMake(margin, margin, alertController.view.bounds.size.width - margin * 4.0F, 400.0F)];
//   // pView=[[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2)-125, ([UIScreen mainScreen].bounds.size.height / 2)-70 ,250,250)];
//
//    //NSLog(@"PV::: %@",pView);
//        [pView setBackgroundColor:[UIColor whiteColor]];
//       // pView.layer.borderWidth=2;
//        pView.layer.cornerRadius = 2;
//        pView.layer.masksToBounds = YES;
//       // [pView.layer setBorderColor:[UIColor lightgraycolor].CGColor];
//        //[win addSubview:pView];
//    
//        cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(4,210,119,30)];
//        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
//        [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
//        [cancelBtn setTag:101];
//        cancelBtn.layer.cornerRadius = 5;
//        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [cancelBtn addTarget:self action:@selector(cancelcalled:) forControlEvents:UIControlEventTouchUpInside];
//        cancelBtn.layer.borderWidth=2;
//        [cancelBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//        [pView addSubview:cancelBtn];
//        
//        OKBtn=[[UIButton alloc]initWithFrame:CGRectMake(126, 210, 119, 30)];
//        [OKBtn setBackgroundColor:[UIColor whiteColor]];
//        [OKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [OKBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
//        OKBtn.layer.cornerRadius = 5;
//        [OKBtn addTarget:self action:@selector(okcalled:) forControlEvents:UIControlEventTouchUpInside];
//        [OKBtn setTag:102];
//        OKBtn.layer.borderWidth=2;
//        [OKBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//        [pView addSubview:OKBtn];
//    
//    //Title
//    drivingExp=[[UILabel alloc]initWithFrame:CGRectMake(4,10, 242,40)];
//    [drivingExp setBackgroundColor:[UIColor whiteColor]];
//    drivingExp.layer.cornerRadius = 5;
//    drivingExp.layer.masksToBounds = YES;
//    drivingExp.textAlignment = NSTextAlignmentCenter;
//    drivingExp.text=@"Your Details";
//    [pView addSubview:drivingExp];
//
//    //Driving Experience
//        drivingExp=[[UILabel alloc]initWithFrame:CGRectMake(4,60, 119,40)];
//        [drivingExp setBackgroundColor:[UIColor whiteColor]];
//        drivingExp.layer.cornerRadius = 5;
//        drivingExp.layer.masksToBounds = YES;
//        drivingExp.textAlignment = NSTextAlignmentCenter;
//        drivingExp.text=@"DrivingExp";
//        [pView addSubview:drivingExp];
//    
//        val_drivingExp=[[UILabel alloc]initWithFrame:CGRectMake(126,60, 119,40)];
//        [val_drivingExp setBackgroundColor:[UIColor whiteColor]];
//        val_drivingExp.layer.cornerRadius = 5;
//        val_drivingExp.textAlignment = NSTextAlignmentLeft;
//        val_drivingExp.layer.masksToBounds = YES;
//        val_drivingExp.text=@"val_dring_Exp";
//        [pView addSubview:val_drivingExp];
//    
//    //Age Experience
//    age =[[UILabel alloc]initWithFrame:CGRectMake(4,110, 119,40)];
//    [age setBackgroundColor:[UIColor whiteColor]];
//    age.layer.cornerRadius = 5;
//    age.layer.masksToBounds = YES;
//    age.textAlignment = NSTextAlignmentCenter;
//    age.text=@"Age";
//    [pView addSubview:age];
//    
//    val_age=[[UILabel alloc]initWithFrame:CGRectMake(126,110, 119,40)];
//    [val_age setBackgroundColor:[UIColor whiteColor]];
//    val_age.layer.cornerRadius = 5;
//    val_age.textAlignment = NSTextAlignmentLeft;
//    val_age.layer.masksToBounds = YES;
//    val_age.text=@"val_age";
//    [pView addSubview:val_age];
//    
//    //NCD Value
//   
//    dialogNo=[[UILabel alloc]initWithFrame:CGRectMake(4,160, 119,40)];
//    [dialogNo setBackgroundColor:[UIColor whiteColor]];
//    dialogNo.layer.cornerRadius = 5;
//    dialogNo.layer.masksToBounds = YES;
//    dialogNo.textAlignment = NSTextAlignmentCenter;
//    dialogNo.text=@"DialogNCD";
//    [pView addSubview:dialogNo];
//    
//    val_NCD=[[UILabel alloc]initWithFrame:CGRectMake(126,160, 119,40)];
//    [val_NCD setBackgroundColor:[UIColor whiteColor]];
//    val_NCD.layer.cornerRadius = 5;
//    val_NCD.textAlignment = NSTextAlignmentLeft;
//    val_NCD.layer.masksToBounds = YES;
//    val_NCD.text=@"val_NCD";
//    [pView addSubview:val_NCD];
//
//   //    [pass_text becomeFirstResponder];
//   [self.view addSubview:pView];
//   //    [pass_text becomeFirstResponder];
//    //    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, alertController.view.bounds.size.width - margin * 4.0F, 100.0F)];
//    //    customView.backgroundColor = [UIColor greenColor];
//    [alertController.view addSubview:pView];
//    
//    UIAlertAction *somethingAction = [UIAlertAction actionWithTitle:@"Something" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
//    [alertController addAction:somethingAction];
//    [alertController addAction:cancelAction];
//    [self presentViewController:alertController animated:YES completion:^{}];
//    
//}

//-(void)cancelcalled:(UIButton*)sender
//{
//    [pView removeFromSuperview];
//}
//
//-(IBAction)okcalled:(UIButton*)sender
//{
//    [pView removeFromSuperview];
//
//}


#pragma  mark --- Check Version with the Current Version Available on App Store


-(BOOL)check_version
{
    NSString *myRequestString = [NSString stringWithFormat:@"%@checkcarboversion.php",kAPIEndpointLatestPath];
    
    NSString *struserid = [[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
    
    NSMutableDictionary *userNameDict = [[NSMutableDictionary alloc]init];

    NSError *error;
    //NSLog(@"userNameDict :: %@, myRequestString :: %@",userNameDict,myRequestString);
    
    BOOL Network=[self Reachability_To_Chechk_Network];
    
    if(Network)
    {
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
        NSLog(@"Response 2 check Version :: %@",response2);
        if(response2.length>10)
        {
        NSDictionary   * jsonObject = [NSJSONSerialization
                          JSONObjectWithData:returnData
                          options:NSJSONReadingMutableLeaves
                          error:nil];
            //NSLog(@"JS :: %@",jsonObject);
            
       NSString    *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
       NSString    *strmessage = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
       NSString *str_success =@"success";
      
        if([str isEqualToString:str_success])
            {
                NSString *server_version = [NSString stringWithFormat:@"%@", [jsonObject valueForKey:@"IOSAPP"]];
                float server_value = [server_version floatValue];          // Server side version value
                float constant_App= [KversionConstant floatValue];    // App side version value
                
              if(server_value > constant_App)
                {
                     NSLog(@"Called If Server value is greater than app value ");
                    return NO;
                }
                else
                {
                    NSLog(@"Called If Server value is less than app value or equal");
                    return YES;
                }
            }
        }
    }
    else
    {
        return YES;
    }
    return YES;
}


-(BOOL) needsUpdate            //Check Version with the Current Version Available on App Store
{
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    // //NSLog(@"  [[UIDevice currentDevice] systemVersion] :: %@ AppVersionString:: %@",  [[UIDevice currentDevice] systemVersion],appVersionString);
    
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *str=[NSString stringWithFormat:@"%@",[lookup valueForKey:@"results"]];
    NSArray *arr=[[NSArray alloc]initWithArray:[lookup valueForKey:@"results"]];
    
    if(arr.count>0)
    {
        //NSLog(@"arr at object at index 0 :: %@",[arr objectAtIndex:0]);
        
        NSDictionary *dict=[[NSDictionary alloc]initWithDictionary:[arr objectAtIndex:0]];
        str=[NSString stringWithFormat:@"%@",[dict valueForKey:@"version"]];
    }
    
    if([str isEqualToString:appVersionString])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark -- Methods - facebookloginButtonClicked, RegisterNewUser & Prepare of Segue

-(IBAction)facebookloginButtonClicked:(id)sender
{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
   
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if(error){
             NSLog(@"Process error ::  %@",error);
         } 
         else if(result.isCancelled)
         {
             //NSLog(@"Cancelled");
         } 
         else
         {
            NSLog(@"Main FB result is:%@",result);
         
           if([FBSDKAccessToken currentAccessToken]) 
             {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, email, id"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if(!error)
                      {
                          NSLog(@"Fetched user :: %@", result);
                          //\UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Image Share on Facebook done" delegate:self cancelButtonTitle:@"OKKKK" otherButtonTitles:nil];
                          Dict = [[NSDictionary alloc]initWithDictionary:result];
                          [self Login_Facebook:Dict];
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
    [email_textfield resignFirstResponder];
    [mobile_textfield resignFirstResponder];
    [email_text resignFirstResponder];
    [Password resignFirstResponder];
    [N_mobile_text resignFirstResponder];
    [emailId resignFirstResponder];
    
    [textField resignFirstResponder];
    
    if(textField.tag==1336)
    {
        [self loginButtonClicked:loginButton];
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
        [emailId resignFirstResponder];
      [email_textfield resignFirstResponder];
      [mobile_textfield resignFirstResponder];
      [email_text resignFirstResponder];
      [Password resignFirstResponder];
      [N_mobile_text resignFirstResponder];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag ==105)
    {
        int length = [textField.text length] ;
        
        if (length >= MAXLENGTH && ![string isEqualToString:@""]) {
            textField.text = [textField.text substringToIndex:MAXLENGTH];
            return NO;
        }
    }
   else if(textField.tag ==106)
    {
        int length = [textField.text length] ;
        
        if (length >= MAXLENGTH && ![string isEqualToString:@""]) {
            textField.text = [textField.text substringToIndex:MAXLENGTH];
            return NO;
        }
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
    NSLog(@"facebook_id:: %@",facebook_id);
    
    //NSLog(@"CAlled Facebook :: %@,%@,%@",firstname,email,facebook_id);
    BOOL Network=[self Reachability_To_Chechk_Network];
 
    if(Network)
    {
        if(email.length>10) //FAcebook with Email Id
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
                //checkfacebookmobile.php
                NSString *myRequestString = [NSString stringWithFormat:@"%@checkfacebookmobile.php",kAPIEndpointLatestPath];
              
                NSLog(@"myRequestString:: %@",myRequestString);
                
                NSDictionary *userNameDict12 = @{
                                               @"facebook_id" : facebook_id
                                               };
                
                //  userNameDict = @{@"facebook_id" : facebook_id };
                //  facebook_id
                
                NSError  *error;
                NSLog(@"Email userNameDictVC :: %@",userNameDict12);
                
                NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict12 options:0 error:&error];
                NSLog(@"Post :: %@",post);
                
                NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:myRequestString]];
                // set Request Type
                [request2 setHTTPMethod:@"POST"];
                // Set content-type
                [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
                // Set Request Body
                [request2 setHTTPBody:post];
                
                // Now send a request and get Response
                NSData *returnData = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
              //  NSLog(@"ERO %@",error);
                // Log Response
                NSString *response2 = [[NSString alloc]initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
                NSLog(@"with email id response 2 :: %@",response2);
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    //NSLog(@"Postdata to server VC F :: %@",response2);
                    if(response2.length>0)
                    {
                        //    {"response_code":"Fail","response_message":"facebook_id is not registered.!"}
                        
                        NSDictionary *jsonObject=[NSJSONSerialization
                                                  JSONObjectWithData:returnData
                                                  options:NSJSONReadingMutableLeaves
                                                  error:nil];
                        NSLog(@"JSF :: %@",jsonObject);
                        // userid
                        // NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                    
                        //    輸入你的電子郵件ID  -Email id
                        
                        NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                        
                        //  NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                        
                        //NSLog(@"USER LOGIN ID :: %@",str1);
                        
                        //NSLog(@"Facebook REsponse called :: %@",str);
                        
                        if([strVerify isEqualToString:@"Success"])  //Already user is present
                        {
                            
                            NSString *myRequestString = [NSString stringWithFormat:@"%@testSignup.php",kAPIEndpointLatestPath];
                            ///   testSignup.php registration_new.php
                            
                            NSDictionary *userNameDict = @{@"facebook_id" : facebook_id,
                                                           @"name" : firstname
                                                           };
                            NSString *status = @"1";
                            NSString *phone       = @" " ;   //nil; // [[NSString alloc]init];       //= @"";
                            NSString *password =  @" ";   //nil; //[[NSString alloc]init];  // = @"";
                            
                            if(email.length>0)
                            {
                                userNameDict = @{
                                                 @"facebook_id" : facebook_id,
                                                 @"name" : firstname,
                                                 @"email" : email,
                                                 @"status" : status,
                                                 @"password" : password,
                                                 @"phone" : phone
                                                 };
                            }
                            //    NSDictionary *userNameDict;
                            NSError  *error;
                            NSLog(@"userNameDictVC :: %@",userNameDict);
                            
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
                            
                            if(response2.length>0)
                            {
                                NSDictionary *jsonObject=[NSJSONSerialization
                                                          JSONObjectWithData:returnData
                                                          options:NSJSONReadingMutableLeaves
                                                          error:nil];
                                NSLog(@"JSF :: %@",jsonObject);
                                
                                // userid
                             //   NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                
                                NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                                
                             //   NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                                
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
                                    
                                    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                                    [[NSUserDefaults standardUserDefaults]synchronize];
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
                     
                        }
                        else  // Show the Alert view to enter the user Mobile number
                        {
                                //Called New File
                            
                                [N_mobile_text setPlaceholder: NSLocalizedString(@"Phone", nil)];
                            
                                [NcancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
                                [NokBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
                                
                                [self.N_externalsubview setFrame:CGRectMake((self.view.frame.size.width/2)-120, (self.view.frame.size.height/2)-64, 240, 128)];
                                [self.N_externalsubview.layer setShadowColor:[UIColor blackColor].CGColor];
                                [self.N_externalsubview.layer setShadowOpacity:0.5];
                                [self.N_externalsubview.layer setShadowRadius:1.0];
                                [self.N_externalsubview.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
                                
                                CGFloat borderWidth = 1.5f;
                                self.N_externalsubview.layer.borderColor = [UIColor lightGrayColor].CGColor;
                                self.N_externalsubview.layer.borderWidth = borderWidth;
                                
                                //Bottom Line Code
                                UIColor *green_color  = [self getUIColorObjectFromHexString:@"#28AC70" alpha:1.0];
                                
                                CALayer *bottomBorder = [CALayer layer];
                                bottomBorder.frame = CGRectMake(0.0f,N_mobile_text.frame.size.height - 1, N_mobile_text.frame.size.width+200, 3.0f);
                                bottomBorder.backgroundColor = green_color.CGColor;
                                [N_mobile_text.layer addSublayer:bottomBorder];
                                
                                [self.view addSubview:self.N_externalsubview];
                            }
                            [self.indicator setHidden:YES];
                            [self.indicator removeFromSuperview];
                    }
                }];
            }];
         }
        else //FAcebook with Mobile number As Id
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
                
                //  https://panel.carbo.com.hk/Carboservices/checkfacebookemail.php
                
                NSString *myRequestString = [NSString stringWithFormat:@"%@checkfacebookemail.php",kAPIEndpointLatestPath];
                
                NSDictionary *userNameDict ;
                
                userNameDict = @{
                                 @"facebook_id" : facebook_id
                                 };
                
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
                
                NSLog(@"checkfacebookemail.php Response 2 : : %@",response2);
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    //NSLog(@"Postdata to server VC F :: %@",response2);
                    if(response2.length>0)
                    {
                        //    {"response_code":"Fail","response_message":"facebook_id is not registered.!"}
                        
                        NSDictionary *jsonObject=[NSJSONSerialization
                                                  JSONObjectWithData:returnData
                                                  options:NSJSONReadingMutableLeaves
                                                  error:nil];
                        NSLog(@"JSF :: %@",jsonObject);
                        
                        // userid
                        // NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                        
                        NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                        
                        //  NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                        
                        //NSLog(@"USER LOGIN ID :: %@",str1);
                        
                        //NSLog(@"Facebook REsponse called :: %@",str);
                        
                        if([strVerify isEqualToString:@"Success"])  //Already user is present
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
                            
                            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                        }
                        else  // Show the Alert view to enter the user Email id
                        {
                            // response_message_eng":"Email is not verified.!
                            
                            NSString *response_message_eng = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message_eng"]];
                            
                            NSString *str_email = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"email"]];
                            
                            if([response_message_eng isEqualToString:@"Email is not verified.!"])
                            {
                                
                                [[NSUserDefaults standardUserDefaults]setObject:str_email forKey:@"userEmail"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                                // Call to Get the verification code  DDDDDDDDDDD
                                NSString *myRequestString = [NSString stringWithFormat:@"%@forgetPassword.php",kAPIEndpointLatestPath];
                                
                                NSDictionary *userNameDict = @{
                                                               @"email" : str_email
                                                               };
                                NSLog(@"Str email _ %@",str_email);
                                NSError  *error;
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
                                NSData *returnData  = [NSURLConnection sendSynchronousRequest: request2 returningResponse: nil error: nil];
                                // Log Response
                                NSString *response2 = [[NSString alloc]initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
                                
                                if(response2.length>6)
                                {
                                    //NSLog(@"Postdata to server :: %@",response2);
                                    NSDictionary *jsonObject=[NSJSONSerialization
                                                              JSONObjectWithData:returnData
                                                              options:NSJSONReadingMutableLeaves
                                                              error:nil];
                                    NSLog(@"Str email  ID JSON Object :: %@",jsonObject);
                                    
                                    NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                                    str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"verification_code"]];
                                    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Verifycode"];
                                    [[NSUserDefaults standardUserDefaults]synchronize];
                                    str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                                    //Code for GCM Key Storing on server Side
                                    
                                    NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                                    //NSLog(@"FAcebook str1 ::- %@",str1);
                                    
                                    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebook_id"];
                                    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"USERID"];
                                    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebookID"];
                                    
                                    NSString *myRequestString = [NSString stringWithFormat:@"%@sendGCMKey.php",kAPIEndpointLatestPath];
                                    
                                    // DeviceToken
                                    NSString *deviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
                                    NSString *str11=@"IOS";
                                    NSDictionary *userNameDict = @{
                                                                   @"DeviceID" : deviceID,
                                                                   @"DeviceOS" : str11,
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
                                    
                                    //Jump to Verification of Email screen
                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    FB_emailVerfication_code *rootController = (FB_emailVerfication_code*)[storyboard instantiateViewControllerWithIdentifier:@"FB_emailVerfication_code"];
                                    [self.navigationController pushViewController:rootController animated:YES];
                                }
                            }
                            else
                            {
                                [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
                                [okBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
                                
                                [externalSubview setFrame:CGRectMake((self.view.frame.size.width/2)-120, (self.view.frame.size.height/2)-90, 240, 168)];
                                
                                [email_textfield setPlaceholder:NSLocalizedString(@"Email", nil)];
                                
                                [mobile_textfield setPlaceholder: NSLocalizedString(@"Phone", nil)];
                                
                                [self.externalSubview.layer setShadowColor:[UIColor blackColor].CGColor];
                                [self.externalSubview.layer setShadowOpacity:0.5];
                                [self.externalSubview.layer setShadowRadius:1.0];
                                [self.externalSubview.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
                                
                                CGFloat borderWidth = 1.5f;
                                externalSubview.layer.borderColor = [UIColor lightGrayColor].CGColor;
                                externalSubview.layer.borderWidth = borderWidth;
                                
                                //Bottom Line Code
                                UIColor *green_color  = [self getUIColorObjectFromHexString:@"#28AC70" alpha:1.0];
                                
                                CALayer *bottomBorder = [CALayer layer];
                                bottomBorder.frame = CGRectMake(0.0f,email_textfield.frame.size.height - 1, email_textfield.frame.size.width+200, 3.0f);
                                bottomBorder.backgroundColor = green_color.CGColor;
                                [email_textfield.layer addSublayer:bottomBorder];
                                
                                CALayer *bottomBorder1 = [CALayer layer];
                                bottomBorder1.frame = CGRectMake(0.0f,mobile_textfield.frame.size.height - 1, mobile_textfield.frame.size.width+200, 3.0f);
                                bottomBorder1.backgroundColor = green_color.CGColor;
                                [mobile_textfield.layer addSublayer:bottomBorder1];
                                
                                [self.view addSubview:externalSubview];
                            }
                            [self.indicator setHidden:YES];
                            [self.indicator removeFromSuperview];
                        }
                    }
                }];
            }];
            //NSLocalizedString(@"Please Enter Valid Email ID", nil)
            //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Email Id", nil) message:@"" preferredStyle:UIAlertControllerStyleAlert];
            //
            //            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //                textField.placeholder = NSLocalizedString(@"Email", nil);
            //
            //                //textField.secureTextEntry = YES;
            //            }];
            //
            //            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                NSLog(@"Current password %@,  %d", [[alertController textFields][0] text], [[alertController textFields][0] text].length);
            //                //compare the current password and do action here
            //            }];
            //
            //            [alertController addAction:confirmAction];
            //            [self presentViewController:alertController animated:YES completion:nil];
            //
        }
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No Network Connection!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
        [alert show];
    }

//if(Network)
//  {
//       if(email.length>10)  //Popup view for Mobile number if not present
//        {    }else                //Popup view for Mobile number login
//    {
//        
//        [mpView removeFromSuperview];
//        [mob_text becomeFirstResponder];
//        
//        mpView=[[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2)-125, ([UIScreen mainScreen].bounds.size.height / 2)-60 ,250,145)];
//        //NSLog(@"PV::: %@",pView);
//        [mpView setBackgroundColor:[UIColor lightGrayColor]];
//        // pView.layer.cornerRadius = 2;
//        mpView.layer.masksToBounds = YES;
//        //[win addSubview:pView];
//        mcancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(4,155,119,30)];
//        [mcancelBtn setBackgroundColor:[UIColor whiteColor]];
//        [mcancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
//        [mcancelBtn setTag:101];
//        mcancelBtn.layer.cornerRadius = 5;
//        [mcancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [mcancelBtn addTarget:self action:@selector(mcancelcalled:) forControlEvents:UIControlEventTouchUpInside];
//        [mcancelBtn addSubview:cancelBtn];
//        
//        mOKBtn=[[UIButton alloc]initWithFrame:CGRectMake(126, 155, 119, 30)];
//        [mOKBtn setBackgroundColor:[UIColor whiteColor]];
//        [mOKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [mOKBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
//        mOKBtn.layer.cornerRadius = 5;
//        [mOKBtn addTarget:self action:@selector(mokcalled:) forControlEvents:UIControlEventTouchUpInside];
//        [mOKBtn setTag:112];
//        [mpView addSubview:mOKBtn];
//        
//        
//        mtitle_label = [[UILabel alloc]initWithFrame:CGRectMake(5,10 ,119, 30 )];
//        [mtitle_label setText:@"Enter Details"];
//        [mtitle_label setBackgroundColor:[UIColor whiteColor]];
//        [mpView addSubview:mtitle_label];
//        
//        email_text = [[UITextField alloc]initWithFrame:CGRectMake(126,55, 119, 40)];
//        email_text.delegate =self;
//        [email_text setBackgroundColor:[UIColor whiteColor]];
//        email_text.layer.cornerRadius =5;
//        email_text.layer.masksToBounds = YES;
//        email_text.secureTextEntry=YES;
//        email_text.tag=105;
//        email_text.textAlignment = NSTextAlignmentCenter;
//        // NSString *strmob = [NSString stringWithFormat:Nsloca]
//        email_text.placeholder=NSLocalizedString(@"Enter your mobile number", nil);
//        [mpView addSubview:email_text];
//
//        
//        email_text = [[UITextField alloc]initWithFrame:CGRectMake(126,55, 119, 40)];
//        email_text.delegate =self;
//        [email_text setBackgroundColor:[UIColor whiteColor]];
//        email_text.layer.cornerRadius =5;
//        email_text.layer.masksToBounds = YES;
//        email_text.secureTextEntry=YES;
//        email_text.tag=105;
//        email_text.textAlignment = NSTextAlignmentCenter;
//        // NSString *strmob = [NSString stringWithFormat:Nsloca]
//        email_text.placeholder=NSLocalizedString(@"Enter your mobile number", nil);
//        [mpView addSubview:email_text];
//        
//        
//        
//        mob_text=[[UITextField alloc]initWithFrame:CGRectMake(4,105, 242,40)];
//        mob_text.delegate=self;
//        [mob_text setBackgroundColor:[UIColor whiteColor]];
//        mob_text.layer.cornerRadius = 5;
//        mob_text.layer.masksToBounds = YES;
//        mob_text.secureTextEntry=YES;
//        mob_text.tag=105;
//        mob_text.textAlignment = NSTextAlignmentCenter;
//        // NSString *strmob = [NSString stringWithFormat:Nsloca]
//        mob_text.placeholder=NSLocalizedString(@"Enter your mobile number", nil);
//        [mpView addSubview:mob_text];
//        //    [pass_text becomeFirstResponder];
//        [self.view addSubview:mpView];
//        
////        [self  call_NEW_facebooklogin:dict];
//      }
//    }
//    else
//    {
//        NSString *str=@"Check Network!!!";
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No Network Connection!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
//        [alert show];
//    }
}

-(IBAction)mcancelcalled:(id)sender
{
    N_mobile_text.text=@"";
    [N_mobile_text setPlaceholder: NSLocalizedString(@"Phone", nil)];
  
    [mpView removeFromSuperview];
    [self.indicator removeFromSuperview];
    [externalSubview removeFromSuperview];
    [self.N_externalsubview removeFromSuperview];
}

-(IBAction)mokcalled:(id)sender;
{
    BOOL  checkEmail = [self  validateEmailWithString:email_text.text];
    
//         NSLog(@"%@",dict,[dict valueForKey:@"id"],[dict valueForKey:@"email"],[dict valueForKey:@"first_name"]);
//         NSString *firstname = [NSString stringWithFormat:@"%@",[dict valueForKey:@"first_name"]];
//         NSString *email = [NSString stringWithFormat:@"%@",[dict valueForKey:@"email"]];
//         NSString *facebook_id = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
//         NSLog(@" ");
//           NSString *firstname = [NSString stringWithFormat:@"%@",[dict valueForKey:@"first_name"]];
//           NSString *email = [NSString stringWithFormat:@"%@",[dict valueForKey:@"email"]];
//           NSString *facebook_id = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
         
         
         NSString *firstname = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"first_name"]];
         NSString *facebook_id = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"id"]];
         NSString *email = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"email"]];
         
         //NSLog(@"CAlled Facebook :: %@,%@,%@",firstname,email,facebook_id);
         BOOL Network=[self Reachability_To_Chechk_Network];
         
         if(Network)
         {
           //FAcebook with Mobile number As Id
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
             
             NEWmobile = N_mobile_text.text;
   
             if(N_mobile_text.text.length>0){
             
                 if(N_mobile_text.text.length==8)
                 {
                     NSOperationQueue *myQueuesvc = [[NSOperationQueue alloc] init];
                     [myQueuesvc addOperationWithBlock:^{
                         //  https://panel.carbo.com.hk/Carboservices/checkfacebookemail.php
                         
                         
                         NSString *myRequestString = [NSString stringWithFormat:@"%@testSignup.php",kAPIEndpointLatestPath];
                         ///   testSignup.php registration_new.php
                         
                         NSDictionary *userNameDict = @{@"facebook_id" : facebook_id,
                                                        @"name" : firstname
                                                        };
                         NSString *status = @"1";
                         NSString *password =@" ";
                         NSString *phone = N_mobile_text.text;
                         
                         if(email.length>0)
                         {
                             userNameDict = @{
                                              @"facebook_id" : facebook_id,
                                              @"name" : firstname,
                                              @"email" : email,
                                              @"status" : status,
                                              @"password" : password,
                                              @"phone" : phone
                                              };
                         }
                      
                         NSError  *error;
                         NSLog(@"userNameDictVC :: %@",userNameDict);
                         
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
                         
                         NSLog(@"mcalled Response 2 : : %@",response2);
                         
                         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             
                             //NSLog(@"Postdata to server VC F :: %@",response2);
                             if(response2.length>0)
                             {
                                 //    {"response_code":"Fail","response_message":"facebook_id is not registered.!"}
                                 
                                 NSDictionary *jsonObject=[NSJSONSerialization
                                                           JSONObjectWithData:returnData
                                                           options:NSJSONReadingMutableLeaves
                                                           error:nil];
                  
                                 NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                  
                                 
                                 if([strVerify isEqualToString:@"Success"])  //Already user is present
                                 {
                                   
                                     //LOGGED IN CODE KEY
                                     [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                     
                                     NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                                     
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
                                     
                                     [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                     [self.indicator removeFromSuperview];
                                 }
                                 else{
                                     
                                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                     [alert show];
                                 }
                             }
                         }];
                     }];
                 }
                 else{
                     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Carbo" message:NSLocalizedString(@"PleaseEnterValidMobileNo", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
                     [alert show];
                     [self.indicator removeFromSuperview];
                 }
            }else{
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Carbo" message:NSLocalizedString(@"EnterYourPhoneNo", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
                 [alert show];
                 [self.indicator removeFromSuperview];
             }
           }
         else
         {
             //  NSString *str=@"Check Network!!!";
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No Network Connection!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
             [alert show];
         }
}

-(IBAction)call_ok_Button
{
    NSString *firstname = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"first_name"]];
    NSString *facebook_id = [NSString stringWithFormat:@"%@",[Dict valueForKey:@"id"]];
    
    NSLog(@"email_textfield.text :: %@",email_textfield.text);
    BOOL Network=[self Reachability_To_Chechk_Network];
    
if(Network)
{
    BOOL ValEmail = [self validateEmailWithString:email_textfield.text];
    
if(email_textfield.text.length>0 && mobile_textfield.text.length>0)
{
    if(ValEmail == YES)
    {
        if(mobile_textfield.text.length == 8)
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
                //registration_new.php
                NSString *myRequestString = [NSString stringWithFormat:@"%@testSignup.php",kAPIEndpointLatestPath];
                
                NSDictionary *userNameDict;
                NSString *password=@"";
                NSString *status = @"1";
                
                if(email_textfield.text.length>0)
                {
                    userNameDict = @{
                                     @"facebook_id" : facebook_id,
                                     @"name" : firstname,
                                     @"email" :  email_textfield.text,
                                     @"phone" : mobile_textfield.text
                                     };
                }
                
               if(email_textfield.text.length>0)
                {
                    userNameDict = @{
                                     @"facebook_id" : facebook_id,
                                     @"name" : firstname,
                                     @"email" : email_textfield.text,
                                     @"status" : status,
                                     @"password" : password,
                                     @"phone" : mobile_textfield.text
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
                        NSLog(@"testSignup.php JSF :: %@",jsonObject);
                        
                        // userid
                        NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                        
                        NSLog(@"Str :: %@",str);
                        
                        NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                        
                        //    NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                        
                        if([strVerify isEqualToString:@"Success"])
                        {
                            NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                            NSLog(@"FAcebook str1 ::- %@",str1);
                            
                            [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebook_id"];
                            [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"USERID"];
                            [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebookID"];
                            
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
                            //  [alert show];
                            
                            
                            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            FB_emailVerfication_code *rootController=(FB_emailVerfication_code*)[storyboard instantiateViewControllerWithIdentifier:@"FB_emailVerfication_code"];
                            
                            [self.navigationController pushViewController:rootController animated:YES];
                            
                            [[NSUserDefaults standardUserDefaults]setObject:email_textfield.text forKey:@"userEmail"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            
                            //    [self performSegueWithIdentifier:@"GTOM" sender:self];
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
            
            [externalSubview removeFromSuperview];
        }
        else       //Enter Valid Mobile Number
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"PleaseEnterValidMobileNo", nil) message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [alert show];
        }
    }
    else      //Enter Valid Email Id
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please Enter Valid Email ID", nil) message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }

}else{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please enter all fields", nil) message:@"" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    [alert show];
}
    
}
else
{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No Network Connection!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
    [alert show];
}
}

-(IBAction)call_Cancel_Button:(id)sender
{
    email_textfield.text=@"";
    mobile_textfield.text=@"";
    
    [email_textfield setPlaceholder:NSLocalizedString(@"Email", nil)];
    
    [mobile_textfield setPlaceholder: NSLocalizedString(@"Phone", nil)];
    
    [externalSubview removeFromSuperview];
}




-(void)call_NEW_facebooklogin:(NSDictionary*)dict
{
    
    //    "Driving Exp"="牌齡";
    //    "DEYearss"="年";
    //    "AGE"＝"年齡";
    //    "AYears"="歲";
    
    //NSLog(@"%@",dict,[dict valueForKey:@"id"],[dict valueForKey:@"email"],[dict valueForKey:@"first_name"]);
    NSString *firstname = [NSString stringWithFormat:@"%@",[dict valueForKey:@"first_name"]];
    NSString *email = [NSString stringWithFormat:@"%@",[dict valueForKey:@"email"]];
    NSString *facebook_id = [NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
    
    //NSLog(@"CAlled Facebook :: %@,%@,%@",firstname,email,facebook_id);
    BOOL Network=[self Reachability_To_Chechk_Network];
    
    if(Network)
    {
        if(email.length>10) //FAcebook with Email As Id
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
                    ///   testSignup.php registration_new.php
                    
                    NSDictionary *userNameDict = @{@"facebook_id" : facebook_id,
                                                   @"name" : firstname
                                                   };
                    NSString *status = @"1";
                    
                    if(email.length>0)
                    {
                        userNameDict = @{
                                         @"facebook_id" : facebook_id,
                                         @"name" : firstname,
                                         @"email" : email,
                                         @"status" : status,
                                         @"phone" : NEWmobile
                                         };
                    }
                    //    NSDictionary *userNameDict;
                    NSError  *error;
                    NSLog(@"userNameDictVC :: %@",userNameDict);
                    
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
                            NSLog(@"JSF :: %@",jsonObject);
                            
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
                                
                                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
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
        else //FAcebook with Mobile number As Id
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
                
                //  https://panel.carbo.com.hk/Carboservices/checkfacebookemail.php
                
                NSString *myRequestString = [NSString stringWithFormat:@"%@checkfacebookemail.php",kAPIEndpointLatestPath];
                
                NSDictionary *userNameDict ;
                
                userNameDict = @{
                                 @"facebook_id" : facebook_id
                                 };
                
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
                
                NSLog(@"checkfacebookemail.php Response 2 : : %@",response2);
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    //NSLog(@"Postdata to server VC F :: %@",response2);
                    if(response2.length>0)
                    {
                        //    {"response_code":"Fail","response_message":"facebook_id is not registered.!"}
                        
                        NSDictionary *jsonObject=[NSJSONSerialization
                                                  JSONObjectWithData:returnData
                                                  options:NSJSONReadingMutableLeaves
                                                  error:nil];
                        //NSLog(@"JSF :: %@",jsonObject);
                        
                        // userid
                        // NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                        
                        NSString *strVerify=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                        
                        //  NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                        
                        //NSLog(@"USER LOGIN ID :: %@",str1);
                        
                        //NSLog(@"Facebook REsponse called :: %@",str);
                        
                        if([strVerify isEqualToString:@"Success"])  //Already user is present
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
                            
                            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Log"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            
                        }
                        else  // Show the Alert view to enter the user Email id
                        {
                            // response_message_eng":"Email is not verified.!
                            
                            NSString *response_message_eng = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message_eng"]];
                            
                            NSString *str_email = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"email"]];
                            
                            if([response_message_eng isEqualToString:@"Email is not verified.!"])
                            {
                                
                                [[NSUserDefaults standardUserDefaults]setObject:str_email forKey:@"userEmail"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                                // Call to Get the verification code  DDDDDDDDDDD
                                NSString *myRequestString = [NSString stringWithFormat:@"%@forgetPassword.php",kAPIEndpointLatestPath];
                                
                                NSDictionary *userNameDict = @{
                                                               @"email" : str_email
                                                               };
                                NSLog(@"forget password :: %@",userNameDict);
                                NSError  *error;
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
                                
                                if(response2.length>6)
                                {
                                    //NSLog(@"Postdata to server :: %@",response2);
                                    NSDictionary *jsonObject=[NSJSONSerialization
                                                              JSONObjectWithData:returnData
                                                              options:NSJSONReadingMutableLeaves
                                                              error:nil];
                                    NSLog(@"Forget password JSON Object :: %@",jsonObject);
                                    
                                    NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                                    str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"verification_code"]];
                                    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Verifycode"];
                                    [[NSUserDefaults standardUserDefaults]synchronize];
                                    str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                                    //Code for GCM Key Storing on server Side
                                    
                                    NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                                    //NSLog(@"FAcebook str1 ::- %@",str1);
                                    
                                    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebook_id"];
                                    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"USERID"];
                                    [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"facebookID"];
                                    
                                    NSString *myRequestString = [NSString stringWithFormat:@"%@sendGCMKey.php",kAPIEndpointLatestPath];
                                    
                                    // DeviceToken
                                    NSString *deviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
                                    NSString *str11=@"IOS";
                                    NSDictionary *userNameDict = @{
                                                                   @"DeviceID" : deviceID,
                                                                   @"DeviceOS" : str11,
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
                                    
                                    //Jump to Verification of Email screen
                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    FB_emailVerfication_code *rootController = (FB_emailVerfication_code*)[storyboard instantiateViewControllerWithIdentifier:@"FB_emailVerfication_code"];
                                    [self.navigationController pushViewController:rootController animated:YES];
                                }
                            }
                            else
                            {
                                [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
                                [okBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
                                
                                [externalSubview setFrame:CGRectMake((self.view.frame.size.width/2)-120, (self.view.frame.size.height/2)-64, 240, 128)];
                                
                                [self.externalSubview.layer setShadowColor:[UIColor blackColor].CGColor];
                                [self.externalSubview.layer setShadowOpacity:0.5];
                                [self.externalSubview.layer setShadowRadius:1.0];
                                [self.externalSubview.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
                                
                                CGFloat borderWidth = 1.5f;
                                externalSubview.layer.borderColor = [UIColor lightGrayColor].CGColor;
                                externalSubview.layer.borderWidth = borderWidth;
                                
                                //Bottom Line Code
                                UIColor *green_color  = [self getUIColorObjectFromHexString:@"#28AC70" alpha:1.0];
                                
                                CALayer *bottomBorder = [CALayer layer];
                                bottomBorder.frame = CGRectMake(0.0f,email_textfield.frame.size.height - 1, email_textfield.frame.size.width+200, 3.0f);
                                bottomBorder.backgroundColor = green_color.CGColor;
                                [email_textfield.layer addSublayer:bottomBorder];
                                
                                [self.view addSubview:externalSubview];
                            }
                            [self.indicator setHidden:YES];
                            [self.indicator removeFromSuperview];
                        }
                    }
                }];
            }];
            //NSLocalizedString(@"Please Enter Valid Email ID", nil)
            //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Email Id", nil) message:@"" preferredStyle:UIAlertControllerStyleAlert];
            //
            //            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            //                textField.placeholder = NSLocalizedString(@"Email", nil);
            //
            //                //textField.secureTextEntry = YES;
            //            }];
            //
            //            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //                NSLog(@"Current password %@,  %d", [[alertController textFields][0] text], [[alertController textFields][0] text].length);
            //                //compare the current password and do action here
            //            }];
            //
            //            [alertController addAction:confirmAction];
            //            [self presentViewController:alertController animated:YES completion:nil];
            //
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
///B com.bitware.carboApplication C com.carbo.carinsuranceapp
@end
