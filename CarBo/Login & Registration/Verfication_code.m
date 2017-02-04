//
//  Verfication_code.m
//  FuelPadi
//
//  Created by Shirish Vispute on 18/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "Verfication_code.h"
#import "Constant.h"
#define kOFFSET_FOR_KEYBOARD 210.0

@interface Verfication_code ()

@end

@implementation Verfication_code
@synthesize verifyCodeText,resendBttn,verifyBtn,VerifyLabel;


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Verify Code", nil);
    
    [VerifyLabel setText:NSLocalizedString(@"Enter Verification Code that is sent to registered Email Id.", nil)];
    [verifyCodeText setPlaceholder:NSLocalizedString(@"Verification Code", nil)];
    [resendBttn setTitle:NSLocalizedString(@"Resend Code", nil) forState:UIControlStateNormal];
    [verifyBtn  setTitle:NSLocalizedString(@"VERIFY", nil) forState:UIControlStateNormal];
   
    // @"Verify Code";
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

    UIColor  *colourgreen = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    //
    self.navigationController.navigationBar.barTintColor = colourgreen;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = colourgreen.CGColor;
    
    border.frame = CGRectMake(0, verifyCodeText.frame.size.height-1, verifyCodeText.frame.size.width+210,2);
    border.borderWidth = borderWidth;
    [verifyCodeText.layer addSublayer:border];
    verifyCodeText.layer.masksToBounds = YES;
    
    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

// Do any additional setup after loading the view.
    verifyCodeText.delegate=self;
    
     ////Frame Movement code
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)Verify_code:(id)sender;
{
    NSString *verifycode=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Verifycode"]];
    
    if(verifycode.length > 0 && verifyCodeText.text.length>0)
    {
        if ([verifycode isEqualToString:verifyCodeText.text])
        {
             [self performSegueWithIdentifier:@"VTOP" sender:self];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"VerificationCodeInvalid", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Enter valid Number", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
//  Verify Code Here 
       
}

#pragma mark -- Verification code Service

-(IBAction)resendVerificationCode:(id)sender
{
    NSString *StrEmail=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"forgotEmail"]];
    
    //NSLog(@"Str :: %@",StrEmail);
    
    if(StrEmail.length>0)
    {
        {
            NSString *myRequestString = [NSString stringWithFormat:@"%@forgetPassword.php",kAPIEndpointLatestPath];
            
            NSDictionary *userNameDict = @{
                                           @"email" : StrEmail
                                           };
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
                
                NSDictionary *jsonObject=[NSJSONSerialization
                                          JSONObjectWithData:returnData
                                          options:NSJSONReadingMutableLeaves
                                          error:nil];
                
                NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];

                str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"verification_code"]];
                [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Verifycode"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
                
                if([str isEqualToString:@"Success"])
                {
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Successfully Sent Verification Code!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//                    [alert show];
                    
                    NSString  *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str1 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                    [alert show];
                }
                else
                {
                    NSString  *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str1 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                    [alert show];
                    
//                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
//                    [alert show];
                    // [self.view setUserInteractionEnabled:YES];
                }
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
                [alert show];
            }
        }
    }
    else
    {
        NSString *str=NSLocalizedString(@"Please enter Verification Code", nil);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }  
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{ 
    if([[segue identifier] isEqualToString:@"VTOP"]) 
    {
        //  MainVC *vc = [segue destinationViewController]; 
        //   [self.navigationController pushViewController:vc animated:YES];
        //   vc.dataThatINeedFromTheFirstViewController = self.theDataINeedToPass; 
    }
} 

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{   // self.navigationController.navigationBarHidden = NO;
    //    [menuView removeFromSuperview];
    //    [menu_Button_table removeFromSuperview];
    //    [sublayer removeFromSuperlayer];
    
    [verifyCodeText resignFirstResponder];
    ///TableFlag= NO;
    // [sideview setFrame:CGRectMake(-133, 0, sideview.frame.size.width,sideview.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
    //  [sideview setFrame:CGRectMake(-133, 0, sideview.frame.size.width,sideview.frame.size.height)];
    }];
}


#pragma mark -- Keyboard resign code

-(void)keyboardWillShow
{
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide
{
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    CGRect rect = self.view.frame;
    if(movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        // checkMoveval = m;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD ;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
        // checkMoveval = m;
    }
    self.view.frame = rect;
    
    //NSLog(@"Frame Transform :: origin.y :: %f,origin.x:: %f,size.height:: %f", rect.origin.y, rect.origin.x, rect.size.height);
    
    [UIView commitAnimations];
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



//-(IBAction)backcalled:(id)sender;
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField; 
//{   
//    //    [textField becomeFirstResponder];
//    return YES;
//    // return textField;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [verifyCodeText resignFirstResponder];
    //    [textField resignFirstResponder];
    return YES;
    // return textField;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
