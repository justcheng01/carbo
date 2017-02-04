//
//  ForgotPassword.m
//  FuelPadi
//
//  Created by Shirish Vispute on 18/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "ForgotPassword.h"
#import "Constant.h"
#define kOFFSET_FOR_KEYBOARD 210.0
#import "Reachability.h"

@interface ForgotPassword ()

@end

@implementation ForgotPassword
@synthesize emailIDtext,process_emailID,titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    emailIDtext.delegate=self;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

    self.navigationItem.title = NSLocalizedString(@"Forget Password", nil);
    
    [titleLabel setText:NSLocalizedString(@"Enter your registered Email Id", nil)];
    [emailIDtext setPlaceholder:NSLocalizedString(@"Email Id", nil)];
    [process_emailID setTitle:NSLocalizedString(@"CONTINUE", nil) forState:UIControlStateNormal];
        
    UIColor  *colourgreen =[self getUIColorObjectFromHexString:Kmain alpha:1.0];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = colourgreen.CGColor;
    
    border.frame = CGRectMake(0, emailIDtext.frame.size.height-1, emailIDtext.frame.size.width+210,2);
    border.borderWidth = borderWidth;
    [emailIDtext.layer addSublayer:border];
    emailIDtext.layer.masksToBounds = YES;

    self.navigationController.navigationBar.barTintColor = colourgreen;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
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

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning 

{
    [super didReceiveMemoryWarning];
}

#pragma  mark -- TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [emailIDtext resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
   // return textField;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [emailIDtext resignFirstResponder];
  [UIView animateWithDuration:0.3 animations:^{
    }];
}
#pragma mark -- Process Email - ID Service

-(IBAction)Process_Email_ID:(id)sender;
{
    BOOL Check =[self validateEmailWithString:emailIDtext.text];
 BOOL Network=[self Reachability_To_Chechk_Network];
if(Network) {
    if(Check)
    {
     
     NSString *myRequestString = [NSString stringWithFormat:@"%@forgetPassword.php",kAPIEndpointLatestPath];
        
        
    NSDictionary *userNameDict = @{
                                   @"email" :emailIDtext.text
                                   };
        [[NSUserDefaults standardUserDefaults]setObject:emailIDtext.text forKey:@"forgotEmail"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    //NSDictionary *userNameDict;
    NSError  *error;
    //NSLog(@"userNameDict :: %@",userNameDict);
    
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
  
        //RR
        if(response2.length>6)
        {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:returnData
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            
            //NSLog(@"JSonObject :: %@",jsonObject);
        
            NSString *str_responsecode=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
            
            if([str_responsecode isEqualToString:@"Success"])
            {
                NSString *str_Verificationcode=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"verification_code"]];
                
                [self performSegueWithIdentifier:@"Verify" sender:self];
                
                [[NSUserDefaults standardUserDefaults]setObject:str_Verificationcode forKey:@"Verifycode"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSString  *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str1 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            }
            else
            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Email ID not Present" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                [alert show];
                
                NSString  *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str1 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please Enter Valid Email ID", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    } 
}
else
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}
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

#pragma mark -- Validate Email & Prepare for segue

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"^[^@]+@([-\\w]+\\.)+[A-Za-z]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //NSLog(@"validate ::%hhd",[emailTest evaluateWithObject:email]);
    return [emailTest evaluateWithObject:email];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{ 
    if ([[segue identifier] isEqualToString:@"Verify"]) 
    {
        //  MainVC *vc = [segue destinationViewController]; 
        //   [self.navigationController pushViewController:vc animated:YES];
        //   vc.dataThatINeedFromTheFirstViewController = self.theDataINeedToPass; 
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



@end
