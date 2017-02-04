//
//  changePassword.m
//  FuelPadi
//
//  Created by Shirish Vispute on 19/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "changePassword.h"
#import "Constant.h"
#define kOFFSET_FOR_KEYBOARD 210.0
#import "Reachability.h"

@interface changePassword ()

@end

@implementation changePassword
@synthesize passwordtext,confirmpasswordtext,submit_Password;

- (void)viewDidLoad {
    [super viewDidLoad];
    passwordtext.delegate=self;
    confirmpasswordtext.delegate=self;
    
    self.navigationItem.title = NSLocalizedString(@"Update Password", nil);
    
    [passwordtext setPlaceholder:NSLocalizedString(@"New Password", nil)];
    [confirmpasswordtext setPlaceholder:NSLocalizedString(@"Confirm Password", nil)];
      [submit_Password setTitle:NSLocalizedString(@"Update Password", nil) forState:UIControlStateNormal];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIColor  *colourgreen = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    //
    self.navigationController.navigationBar.barTintColor = colourgreen;

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    CALayer *border     = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor  = colourgreen.CGColor;
    
    border.frame = CGRectMake(0, passwordtext.frame.size.height-1, passwordtext.frame.size.width+210,2);
    border.borderWidth = borderWidth;
    [passwordtext.layer addSublayer:border];
    passwordtext.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    border1.borderColor = colourgreen.CGColor;
    border1.frame = CGRectMake(0, confirmpasswordtext.frame.size.height-1, confirmpasswordtext.frame.size.width+210,2);
    border1.borderWidth = borderWidth;
    [confirmpasswordtext.layer addSublayer:border1];
    confirmpasswordtext.layer.masksToBounds = YES;
  
        ////Frame Movement code
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    // Do any additional setup after loading the view.
}


-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//CPTOM

#pragma mark -- Submit Password Service

-(IBAction)Submit_Password:(id)sender;
{

    NSString *userid=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];
    
    BOOL Network=[self Reachability_To_Chechk_Network];
if(Network) 
{

    if([passwordtext.text isEqualToString: confirmpasswordtext.text])
     {
        
        NSString *myRequestString = [NSString stringWithFormat:@"%@reset_pwd.php",kAPIEndpointLatestPath];
        
         NSString *StrEmail=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"forgotEmail"]];
        
        NSDictionary *userNameDict = @{
                             @"email" : StrEmail,
                             @"password" : passwordtext.text                                      };
        
        //    NSDictionary *userNameDict;
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
         
        //NSLog(@"response2 :: %@",response2);
         
        if(response2.length>6)
        {
            //NSLog(@"Postdata to server :: %@",response2);
            
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:returnData
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            
            //NSLog(@"JSonObject :: %@",jsonObject);
            
            NSString *str_responsecode=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
            
            if([str_responsecode isEqualToString:@"Success"])
            {
                NSString *str_Verificationcode=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"verification_code"]];
                
                [self performSegueWithIdentifier:@"CPTOM" sender:self];
                
                [[NSUserDefaults standardUserDefaults]setObject:str_Verificationcode forKey:@"Verifycode"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSString  *str1=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str1 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
            }
            else
            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Entered Password doesn't match", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles:nil];
        [alert show];
    } 

}else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [passwordtext resignFirstResponder];
    [confirmpasswordtext resignFirstResponder];
    
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

#pragma mark --- Text Field Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect rect1 = self.view.frame;
    rect1.origin.y = 0.0f;
    rect1.size.height =  [[UIScreen mainScreen] bounds].size.height
    ;//568;
    self.view.frame = rect1;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [passwordtext resignFirstResponder];
    [confirmpasswordtext resignFirstResponder];
    // [textField resignFirstResponder];
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{ 
    if([[segue identifier] isEqualToString:@"CPTOM"]) 
    {
    }
} 

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


-(IBAction)backcalled:(id)sender;
{
    [self.navigationController popViewControllerAnimated:YES];
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
