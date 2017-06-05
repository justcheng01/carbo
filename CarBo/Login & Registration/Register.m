//
//  Register.m
//  FuelPadi
//
//  Created by Shirish Vispute on 15/06/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "Register.h"
//#import "MainVC.h"
#import "Reachability.h"
#import "Constant.h"
#define kOFFSET_FOR_KEYBOARD 450.0
#define MAXLENGTH 8
#define MINLENGTH 10



@interface Register ()
{
    UITextField *pass_text;
    UIButton *OKBtn;
    UIButton *cancelBtn;
    UIView  *pView;
  
}
@end

@implementation Register

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title =NSLocalizedString(@"Sign Up", nil);
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    UIColor  *colourgreen = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    //
    self.navigationController.navigationBar.barTintColor = colourgreen;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
       [Name setPlaceholder:NSLocalizedString(@"Name", nil)];
    
       [email setPlaceholder:NSLocalizedString(@"Email", nil)];
    
       [phone setPlaceholder: NSLocalizedString(@"Phone", nil)];
    
       [password setPlaceholder:NSLocalizedString(@"Password", nil)];
    
       [confirmpassword setPlaceholder:NSLocalizedString(@"Confirm Password", nil)];
    
       [signUpBtn setTitle:NSLocalizedString(@"SIGN UP", nil) forState:UIControlStateNormal];
    
   
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = colourgreen.CGColor;
    
    border.frame = CGRectMake(0, UserName.frame.size.height-1, UserName.frame.size.width+210,2);
    border.borderWidth = borderWidth;
    [UserName.layer addSublayer:border];
    UserName.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    border1.borderColor = colourgreen.CGColor;
    border1.frame = CGRectMake(0, Name.frame.size.height-1, Name.frame.size.width+210,2);
    border1.borderWidth = borderWidth;
    [Name.layer addSublayer:border1];
    Name.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = colourgreen.CGColor;
    border2.frame = CGRectMake(0, email.frame.size.height-1, email.frame.size.width+210,2);
    border2.borderWidth = borderWidth;
    [email.layer addSublayer:border2];
    email.layer.masksToBounds = YES;
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = colourgreen.CGColor;
    border3.frame = CGRectMake(0, phone.frame.size.height-1, phone.frame.size.width+210,2);
    border3.borderWidth = borderWidth;
    [phone.layer addSublayer:border3];
    phone.layer.masksToBounds = YES;
    
    CALayer *border4 = [CALayer layer];
    border4.borderColor = colourgreen.CGColor;
    border4.frame = CGRectMake(0,password.frame.size.height-1, password.frame.size.width+210,2);
    border4.borderWidth = borderWidth;
    [password.layer addSublayer:border4];
    password.layer.masksToBounds = YES;
    
    CALayer *border5 = [CALayer layer];
    border5.borderColor = colourgreen.CGColor;
    border5.frame = CGRectMake(0,confirmpassword.frame.size.height-1, confirmpassword.frame.size.width+210,2);
    border5.borderWidth = borderWidth;
    [confirmpassword.layer addSublayer:border5];
    confirmpassword.layer.masksToBounds = YES;
    
    
    UserName.delegate=self;
    
    Name.delegate=self;
    
    email.delegate=self;
    
    phone.delegate=self;
    
    password.delegate=self;
    
    confirmpassword.delegate=self;
    
    signUpBtn.layer.borderColor=colourgreen.CGColor;
    signUpBtn.layer.cornerRadius = 10;
    signUpBtn.layer.borderWidth = 2;
    signUpBtn.clipsToBounds = YES;
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
}

#pragma mark --- Text Field 
-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.{
{
  if(textField.tag==105)
    {
        return YES;
    }
    return YES;   
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag==5) 
    {
        [password resignFirstResponder];
        [pView removeFromSuperview];
        [pass_text becomeFirstResponder];
        
        pView=[[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2)-125, ([UIScreen mainScreen].bounds.size.height / 2)-60 ,250,95)];
        //NSLog(@"PV::: %@",pView);
        [pView setBackgroundColor:[UIColor lightGrayColor]];
        // pView.layer.cornerRadius = 2;
        pView.layer.masksToBounds = YES;
        //[win addSubview:pView];
        cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(4,55,119,30)];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [cancelBtn setTag:101];
        cancelBtn.layer.cornerRadius = 5;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelcalled:) forControlEvents:UIControlEventTouchUpInside];
        [pView addSubview:cancelBtn];
        
        OKBtn=[[UIButton alloc]initWithFrame:CGRectMake(126, 55, 119, 30)];
        [OKBtn setBackgroundColor:[UIColor whiteColor]];
        [OKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [OKBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        OKBtn.layer.cornerRadius = 5;
        [OKBtn addTarget:self action:@selector(okcalled:) forControlEvents:UIControlEventTouchUpInside];
        [OKBtn setTag:102];
        [pView addSubview:OKBtn];
        
        pass_text=[[UITextField alloc]initWithFrame:CGRectMake(4,10, 242,40)];
        pass_text.delegate=self;
        [pass_text setBackgroundColor:[UIColor whiteColor]];
        pass_text.layer.cornerRadius = 5;
        pass_text.layer.masksToBounds = YES;
        pass_text.secureTextEntry=YES;
        pass_text.tag=105;
        pass_text.textAlignment = NSTextAlignmentCenter;
        pass_text.placeholder=@"Enter Password";
        [pView addSubview:pass_text];
     //    [pass_text becomeFirstResponder];
        [self.view addSubview:pView];
        //[pass_text becomeFirstResponder];
    }
    else if (textField.tag==6)
    {
        [confirmpassword resignFirstResponder];
        [pView removeFromSuperview];
     
        pView=[[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2)-125, ([UIScreen mainScreen].bounds.size.height / 2)-60 ,250,95)];
        //NSLog(@"PV::: %@",pView);
        [pView setBackgroundColor:[UIColor lightGrayColor]];
       // pView.layer.cornerRadius = 2;
        pView.layer.masksToBounds = YES;
      
        cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(4,55,119,30)];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [cancelBtn setTag:101];
        cancelBtn.layer.cornerRadius = 5;
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelcalled:) forControlEvents:UIControlEventTouchUpInside];
        [pView addSubview:cancelBtn];
        
        OKBtn=[[UIButton alloc]initWithFrame:CGRectMake(126, 55, 119, 30)];
        [OKBtn setBackgroundColor:[UIColor whiteColor]];
        [OKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [OKBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        OKBtn.layer.cornerRadius = 5;
        [OKBtn addTarget:self action:@selector(okcalled:) forControlEvents:UIControlEventTouchUpInside];
        [OKBtn setTag:104];
        [pView addSubview:OKBtn];
        
        pass_text=[[UITextField alloc]initWithFrame:CGRectMake(4,10, 242,40)];
        pass_text.delegate=self;
        [pass_text setBackgroundColor:[UIColor whiteColor]];
        pass_text.layer.cornerRadius = 5;
        pass_text.layer.masksToBounds = YES;
        pass_text.secureTextEntry=YES;
        pass_text.tag=105;
        pass_text.textAlignment = NSTextAlignmentCenter;
        pass_text.placeholder=NSLocalizedString(@"Confirm Password", nil);
        [pView addSubview:pass_text];
        // [pass_text becomeFirstResponder];
        [self.view addSubview:pView];
    }
    else if (textField.tag==105)
    {
      [self.view addSubview:pView];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [phone resignFirstResponder];
}

-(void)cancelcalled:(UIButton*)sender
{
     [pView removeFromSuperview];
}

-(IBAction)okcalled:(UIButton*)sender
{
     [pView removeFromSuperview];
   
    if(sender.tag==102)
    {
        password.text=pass_text.text;
    }
    else  if(sender.tag==104)
    {
        confirmpassword.text=pass_text.text;
    }
}

-(IBAction)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
      CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
// //NSLog(@"origin.y :: %f,origin.x:: %f,size.height:: %f", rect.origin.y, rect.origin.x, rect.size.height);
    self.view.frame = rect;
    
// [UIView commitAnimations];
}

#pragma mark --- Register user ---
-(IBAction)registeruser:(id)sender;
{
   //[self.view setUserInteractionEnabled:NO];
    BOOL Network=[self Reachability_To_Chechk_Network];
    if(Network)
    {
    if(Name.text.length>0 && email.text.length>0 && phone.text.length>0 && password.text.length>0)
  {
      NSLog(@"Email Valid  ::  %@",email.text);
      
      BOOL ValEmail = [self validateEmailWithString:email.text];
      
      if(ValEmail==YES)
      {
          if(phone.text.length==8)
          {
              if([password.text isEqualToString:confirmpassword.text])
              {
                      NSString *myRequestString = [NSString stringWithFormat:@"%@registration_new.php",kAPIEndpointLatestPath];
                      // registration_new.php
                      NSDictionary *userNameDict = @{@"name" : Name.text,
                                                     @"email" : email.text,
                                                     @"phone" : phone.text,
                                                     @"password" : password.text
                                                     };
                      NSError  *error;
                      NSLog(@"userNameDict  :: %@",userNameDict);

                      NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
                      //  NSString *myRequestString = [NSString stringWithFormat:@"http://74.208.213.88/cakephpProjects/buzz/demofile.php?device_id=%@",deviceID];
                      //   http://161.202.18.46/~iwebsolutionz/Cakephpprojects/buzz/
                      
                      // Create Data from request
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
                       NSLog(@"Postdata to server :: %@",response2);
                      
                      if(response2.length>0)
                      {
                          NSDictionary *jsonObject=[NSJSONSerialization
                                                    JSONObjectWithData:returnData
                                                    options:NSJSONReadingMutableLeaves
                                                    error:nil];
                          
                          NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                          
                          if([str isEqualToString:@"Success"])
                          {
                              NSString *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"userid"]];
                              [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"USERID"];
                              [[NSUserDefaults standardUserDefaults]setObject:email.text forKey:@"userEmail"];
                              [[NSUserDefaults standardUserDefaults]synchronize];
                              
                              NSString *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                              [alert show];
                              [self performSegueWithIdentifier:@"RTOEV" sender:self];
                          }
                          else
                          {
                              NSString *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                              [alert show];
                              //          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@" " message:str delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                              //          [alert show];
                          }
                      }
                      else
                      {
                          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                          [alert show];
                      }
              }
              else
              {
                  //  NSString *str=@"Please Enter Password Field Properly";
                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Entered Password doesn't match", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                  [alert show];
              }
          }
          else{
              //  NSString *str=@"Please Enter Password Field Properly";   Please valid mobile number    請輸入有效的電話號碼
              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"PleaseEnterValidMobileNo", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
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
     //  NSString *str=NSLocalizedString(@"Please enter all fields", nil);
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"All the fields are mandatory", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
       [alert show];
  }
}
 else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSLog(@"String :: %@",string);
//    
////    if(textField==self.confirm_pwd_text)
////    {
////        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-@!@#$%^&*():;""{}[]?/,~`"] invertedSet];
////        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
////        if ([string isEqualToString:@" "] ) {
////            return NO;
////        }
////    }
////    else if(textField==self.txt_pwd)
////    {
////        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-@!@#$%^&*():;""{}[]?/,~`"] invertedSet];
////        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
////        if ([string isEqualToString:@" "] ) {
////            return NO;
////        }
////    }
//   if(textField.tag==3)
//    {
//        int length = [phone.text length] ;
//        
//        if (length >= MAXLENGTH && ![string isEqualToString:@""] && length >= MINLENGTH ) {
//            textField.text = [textField.text substringToIndex:MAXLENGTH];
//            return NO;
//        }
//    }
//}

//NEW
-(BOOL)validateEmailWithString:(NSString*)email
{   
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //NEW   NSString *emailRegex = @"([A-Z0-9a-z._%+-]{2,4})+@([A-Za-z0-9.-]{2,4})+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{ 
    if([[segue identifier] isEqualToString:@"RTOEV"]) 
    {}
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==1333)
    {
    int length = [textField.text length] ;
    if (length >= MAXLENGTH && ![string isEqualToString:@""]) {
          textField.text = [textField.text substringToIndex:MAXLENGTH];
          return NO;
        }
    }
    return YES;
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

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
