//
//  car_imageVC.m
//  CarBo
//
//  Created by Shirish Vispute on 23/09/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "car_imageVC.h"
#import "renewalPolicylist.h"
#import "AlbumClass.h"
#import "Reachability.h"
#import "Constant.h"

@implementation car_imageVC
{
   UIColor *colour;
    BOOL ImageFlag;
}


@synthesize uploadBtn,carimage,policyid,indicator,supPicture;

-(void)viewDidLoad
{
    
    
    NSString *Uploadstrr=[NSString stringWithFormat:NSLocalizedString(@"Supplementary Picture", nil)];

    self.navigationItem.title = Uploadstrr;
    [supPicture setText:Uploadstrr];
    
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"imagePolicyID"]];
    
    colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(-10, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setHidesBackButton:YES];
    
    //NSLog(@"policyid Car ImageVC :: %@",policyid);
    
    ImageFlag = NO;
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    tapGesture.delegate=self;
    tapGesture.numberOfTapsRequired=1;
    [carimage addGestureRecognizer:tapGesture];
    
  NSString *Uploadstr=[NSString stringWithFormat:NSLocalizedString(@"Upload Supplementary Picture", nil)];
    [uploadBtn setTitle:NSLocalizedString(@"Upload", nil) forState:UIControlStateNormal];
    [_UploadLabel setText:Uploadstr];

}

-(void)viewWillAppear:(BOOL)animated
{

}

-(IBAction)selectImage:(id)sender
{
    [self.view endEditing:YES];
     
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
     popup.tag = 1;
    [popup showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    id sender;
    switch(buttonIndex)
        {
                    case 0:
                        [self selectImageFromGallary:sender];
                        break;
                    case 1:
                        [self shootNow:sender];
                        break;
                    default:
                        break;
       }
}

-(IBAction)selectImageFromGallary:(id)sender
{
    UIImagePickerController *pickerController = [AlbumClass imagePickerControllerWithDelegate:self];
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)shootNow:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}


-(IBAction)uploadImage:(id)sender;
{
        NSData *imageData = UIImageJPEGRepresentation(carimage.image, 90);
        
        NSString *user_id =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];

    BOOL Network=[self Reachability_To_Chechk_Network];
        
        if(Network)
        {
            self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
            self.indicator.center = self.view.center;
            self.indicator.color=[UIColor whiteColor];
            self.indicator.layer.cornerRadius=10;
            [self.indicator setBackgroundColor:colour];
            self.indicator.layer.zPosition++;
            self.indicator.layer.zPosition++;
            
            [self.indicator startAnimating];
            [self.view addSubview:indicator];
            
         if(ImageFlag)
            {
                NSOperationQueue *myQueuesvc = [[NSOperationQueue alloc] init];
                [myQueuesvc addOperationWithBlock:^{
                    
                 NSString   *urlString = [NSString stringWithFormat:@"%@resubmitcarphoto_ios.php?user_id=%@&policy_id=%@",kAPIEndpointLatestPath,user_id,policyid];
                    
                    //NSLog(@"urlString :: %@ Image length :: %d",urlString,imageData.length);
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:[NSURL URLWithString:urlString]];
                    [request setHTTPMethod:@"POST"];
                    
                    NSString *boundary = @"---------------------------14737809831466499882746641449";
                    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                    
                    NSMutableData *body = [NSMutableData data];
                    
                    // NSString *user_id=@"USer";// = userID;
                    //NSLog(@"user_id :: %@",user_id);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:user_id] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    //  policy_id
                    //NSLog(@"policy_id :: %@",policyid);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"policy_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:policyid] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    ///Pic para
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:imageData]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [request setHTTPBody:body];
                    
                    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    //NSLog(@"Return Data :: %@",returnData);
                    
                    
                    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                    
                  if(returnString.length > 6)
                  {
                      NSDictionary *jsonObject=[NSJSONSerialization
                                                JSONObjectWithData:returnData
                                                options:NSJSONReadingMutableLeaves
                                                error:nil];
                    
                      //NSLog(@"JS :: %@",jsonObject);
                      //NSLog(@"Return Data :: %@",returnString);
                      
                      NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
                      
                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                          
                          if([str isEqualToString:@"Success"])
                          {
                              [self.indicator setHidden:YES];
                              
                              [self.indicator removeFromSuperview];
                              ImageFlag=NO;
                              
                              [self.navigationController popViewControllerAnimated:YES];
                              
//                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Supplementary picture uploaded successfully", nil)  message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                              [alert show];
                              
                              NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                              
                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                              [alert show];
                              
                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                          renewalPolicylist  *rootController = (renewalPolicylist*)[storyboard instantiateViewControllerWithIdentifier:@"renewalPolicylist"];
                              
                              dispatch_async(dispatch_get_main_queue(), ^(void)
                                             {
                                                 [self.view setUserInteractionEnabled:YES];
                                                 
                                                 [self.indicator setHidden:YES];
                                                 
                                                 [self.indicator removeFromSuperview];
                                                 
                                                 
                                                 
                                                 
                                             });

                          }
                          else
                          {
                              dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                             {
                                                 // Background work
                                                 dispatch_async(dispatch_get_main_queue(), ^(void)
                                                                {
                                                                    [self.view setUserInteractionEnabled:YES];
                                                                    
                                                                    [self.indicator setHidden:YES];
                                                                    
                                                                    [self.indicator removeFromSuperview];
                                                                    
                                                                    
                                                                    
                                                                    
                                                                });
                                             });
                              
                              

                              [self.indicator setHidden:YES];
                              [self.indicator removeFromSuperview];
                              
                              NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                              [alert show];
                          }
                      }];
                  }
                  else
                  {
                      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                     {
                                         // Background work
                                         dispatch_async(dispatch_get_main_queue(), ^(void)
                                                        {
                                                            [self.view setUserInteractionEnabled:YES];
                                                            
                                                            [self.indicator setHidden:YES];
                                                            
                                                            [self.indicator removeFromSuperview];
                                                            
                                                            
                                                            
                                                            
                                                        });
                                     });
              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                      [alert show];
                  }
            }];
        }
    else
       {
           
           dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                          {
                              // Background work
                              dispatch_async(dispatch_get_main_queue(), ^(void)
                                             {
                                                 [self.view setUserInteractionEnabled:YES];
                                                 
                                                 [self.indicator setHidden:YES];
                                                 
                                                 [self.indicator removeFromSuperview];
                                           });
                          });
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please select image", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)  otherButtonTitles:nil];
                [alert show];
          }
        }
        else  ///Network
        {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                           {
                               // Background work
                               dispatch_async(dispatch_get_main_queue(), ^(void)
                                              {
                                                  [self.view setUserInteractionEnabled:YES];
                                                  
                                                  [self.indicator setHidden:YES];
                                                  
                                                  [self.indicator removeFromSuperview];
                                    });
                           });
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
        uploadBtn.userInteractionEnabled = YES;
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *photo;
    photo = [AlbumClass imageWithMediaInfo:info];
    
    // carinfoImage.image = photo;
    //    _photoView.image = [AlbumClass imageWithMediaInfo:info];
    ImageFlag=YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //Do not delete this block
    [UIView animateWithDuration:50.0
                     animations:^{
                         self.navigationController.navigationBarHidden = NO;
                         self.carimage.image = photo;
                         
                         ImageFlag=YES;
                         
                     } completion:^(BOOL finished) {
                         
                         if ([UIScreen mainScreen].bounds.size.height == 480)
                         {
                         }
                         //                         [pickerView removeFromSuperView];
                     }];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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


-(void)backJump
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
