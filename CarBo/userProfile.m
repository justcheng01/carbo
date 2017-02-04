//
//  userProfile.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "userProfile.h"
#import "MainVC.h"
#define kOFFSET_FOR_KEYBOARD 100.0
#import "Constant.h"
#import "Reachability.h"
@interface userProfile ()

@end

@implementation userProfile
@synthesize nametext,emailtext,phonetext,profileImageview,scrollview;



- (void)viewDidLayoutSubviews
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self GetUserDetails];
    
        NSString *UserProfile=[NSString stringWithFormat:NSLocalizedString(@"Profile Info", nil)];
    self.navigationItem.title = UserProfile;
    
    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    nametext.delegate=self;
    phonetext.delegate=self;

    NSString *Name=[NSString stringWithFormat:NSLocalizedString(@"Name", nil)];
    [nametext setPlaceholder:Name];
    
    NSString *email=[NSString stringWithFormat:NSLocalizedString(@"Email", nil)];
    [emailtext setPlaceholder:email];
    
    NSString *Phone=[NSString stringWithFormat:NSLocalizedString(@"Phone", nil)];
    [phonetext setPlaceholder:Phone];
    
    [updateBtn setTitle:NSLocalizedString(@"Update Profile", nil) forState:UIControlStateNormal];
    
// Keyboard Resign code
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

#pragma mark -- Web SerVice to Ge User Details

-(void)GetUserDetails
{
    BOOL Network=[self Reachability_To_Chechk_Network];
    
    if(Network){
    
    NSString *myRequestString = [NSString stringWithFormat:@"%@getUserdetails.php",kAPIEndpointLatestPath];
   
    NSString *struserid = [[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
    
   // NSString *str1=@"20";
    
    NSDictionary *userNameDict = @{@"user_id" : struserid
                                   };
    NSError  *error;
    //NSLog(@"userNameDict REviewcalled :: %@",userNameDict);
    
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
        NSDictionary *jsonObject = [NSJSONSerialization
                                    JSONObjectWithData:returnData
                                    options:NSJSONReadingMutableLeaves
                                    error:nil];
        
        //NSLog(@"JSF Object :: %@",jsonObject);
        
        NSDictionary *dict=[[NSDictionary alloc]initWithDictionary:[jsonObject valueForKey:@"result"]];
        
        NSString *str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
        //NSLog(@"STR :: %@",str);
        
        nametext.text = str;
        
        NSString *str21= [NSString stringWithFormat:@"%@",[dict valueForKey:@"email"]];
        //NSLog(@"STR :: %@",str21);
        emailtext.text = str21;
        
        NSString *str31= [NSString stringWithFormat:@"%@",[dict valueForKey:@"phone"]];
        //NSLog(@"STR :: %@",str31);
        phonetext.text = str31;
        
        NSString *str41= [NSString stringWithFormat:@"%@",[dict valueForKey:@"profile_image"]];
        //NSLog(@"STR :: %@",str41);
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
        
}
else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    
    }
}

-(IBAction)UpdateUserDetails:(id)sender
{
   
    NSString *myRequestString = [NSString stringWithFormat:@"%@updateProfile.php",kAPIEndpointLatestPath];
    
    NSString *struserid = [[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
   
    NSDictionary *userNameDict = @{@"user_id" : struserid,
                                   @"name" :  nametext.text,
                                   @"phone" : phonetext.text
                                   };
    
    NSString *myRequestString1 = [NSString stringWithFormat:@"%@updateProfile.php",kAPIEndpointLatestPath];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:myRequestString1]];
    UIImage *image=[UIImage imageNamed:@"test.png"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"unique-consistent-string";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"imageCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
    
     [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(data.length > 0)
        {
            //success
        }
    }];
    

    if(nametext.text.length>0 && phonetext.text>0)
    {
       // NSString *myRequestString = [NSString stringWithFormat:@"http://74.208.12.101/Carboservices/updateProfile.php"];
        
        NSString *myRequestString = [NSString stringWithFormat:@"%@updateProfile.php",kAPIEndpointLatestPath];
        
        NSString *struserid = [[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
        
     //   NSString *str1=@"20";
        
        NSDictionary *userNameDict = @{@"user_id" : struserid,
                                       @"name" :  nametext.text,
                                       @"phone" : phonetext.text
                                       };
        NSError  *error;
  
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
        
        //RR
        if(response2.length>6)
        {
            NSDictionary *jsonObject = [NSJSONSerialization
                                        JSONObjectWithData:returnData
                                        options:NSJSONReadingMutableLeaves
                                        error:nil];
            
            //NSLog(@"JSF Object :: %@",jsonObject);
            
            NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
            
            if([str isEqualToString:@"Success"])
            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Profile Updated successfully!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                [alert show];
                
                NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
                
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainVC  *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
                [self.navigationController pushViewController:rootController animated:YES];
            }
            else
            {
                
                NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please enter all fields", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [nametext resignFirstResponder];
    [phonetext resignFirstResponder];
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- Text Field 
-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [nametext resignFirstResponder];
    [phonetext resignFirstResponder];
   // [textField resignFirstResponder];
    return YES;
}

-(void)keyboardWillShow 
{
    // Animate the current view out of the way
    //if()
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
}

-(void)keyboardWillHide {
    
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{
    if(textField.tag==1337)
    {
        // Prevent crashing undo bug – see note below.
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 15;
    }
    
    return YES;
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    // [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
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



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
