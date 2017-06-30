//
//  PremiumDetails_FVC.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "PremiumDetails_FVC.h"
#import "AlbumClass.h"
#import "PremiumDetails_SVC.h"
#import "Constant.h"
#import "Reachability.h"


@interface PremiumDetails_FVC ()
{
    NSMutableArray *arr_account_name;
    NSMutableArray *arr_account_no;
    NSMutableArray *arr_bank_name;
    UIColor *colour1;
    BOOL ImageFlag;
    NSString  *str2;
    UIActivityIndicatorView *indicator;
    NSString *strRenewal;
    UIColor *colourgreen;
}


@end


@implementation PremiumDetails_FVC

@synthesize payment_receipt,feesAmount,banklistTableview,bank_name_text,acount_name_text,continueBtn,account_no_text,premium_label,indicator,heading,indicatorrenewal,
banklabel,
accountlabel,
companylabel,
premiumlabel,
uploadlabel;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    NSString *NSlabelDOP=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    
    self.navigationItem.title = NSlabelDOP;
    
   ImageFlag=NO;

    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    tapGesture.delegate=self;
    tapGesture.numberOfTapsRequired=1;
    [payment_receipt addGestureRecognizer:tapGesture];
    [self getBankDetails];
    
    colour1 = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0]; 
    colourgreen = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0]; // navigation
    

    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1500)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.alwaysBounceHorizontal=NO;
    scrollview.alwaysBounceVertical=NO;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    // [scrollview setBackgroundColor:[UIColor redColor]];
    scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+2600);
    //[self.view addSubview:scrollview];
    
    banklistTableview=[[UITableView alloc]init];
    self.banklistTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.banklistTableview.frame = CGRectMake(0,60,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen]bounds].size.height+30);
   
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBank)];
    tapGesture3.delegate=self;
    tapGesture3.numberOfTapsRequired=1;
    [bank_name_text addGestureRecognizer:tapGesture3];
    
    [continueBtn setTitle:NSLocalizedString(@"Continue", nil) forState:UIControlStateNormal];

    [heading setText:NSLocalizedString(@"Please Bank IN the premium to below account", nil)];
    [heading setTextColor:colourgreen];

    [banklabel setText:NSLocalizedString(@"Bank Name", nil)];

    [accountlabel setText:NSLocalizedString(@"Account No", nil)];

    [companylabel setText:NSLocalizedString(@"Company Name", nil)];

    [uploadlabel  setText:NSLocalizedString(@"Upload Payment Receipt",nil)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"BtnFlagstr"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    strRenewal = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"RD"]];

    if([strRenewal isEqualToString:@"YES"])
    {
        [premiumlabel setText:NSLocalizedString(@"Renewal Premium",nil)];
        [continueBtn setTitle:NSLocalizedString(@"Renew Policy", nil) forState:UIControlStateNormal];  
    }
    else
    {
        [premiumlabel setText:NSLocalizedString(@"Discounted Premium",nil)];
        [continueBtn setTitle:NSLocalizedString(@"CONTINUE", nil) forState:UIControlStateNormal];
    }
       [heading setTextColor:colourgreen];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}


-(void)viewDidDisappear:(BOOL)animated
{
    ImageFlag = NO;
    [payment_receipt setImage:[UIImage imageNamed:@"upload-icon.png"]];
}

-(void)getBankDetails
{
    NSString *myRequestString = [NSString stringWithFormat:@"%@getBanks.php",kAPIEndpointLatestPath];
    
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
    
if(response2.length>6)
 {
   //NSLog(@"Postdata to server :: %@",response2);
    
   NSDictionary *jsonObject ;
    
    if([response2 isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
        //NSLog(@"Called the NSLog");
    }
    else
    {
        //NSLog(@"JSF Object :: %@",jsonObject);
      
        jsonObject = [NSJSONSerialization
                      JSONObjectWithData:returnData
                      options:NSJSONReadingMutableLeaves
                      error:nil];
     
        NSArray *arr=[[NSArray alloc]initWithArray:[jsonObject valueForKey:@"result"]];
        
        arr_account_name=[[NSMutableArray alloc]init];
        arr_account_no=[[NSMutableArray alloc]init];
        arr_bank_name=[[NSMutableArray alloc]init];
        
        for (int i=0; i<arr.count; i++) 
        {
            NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:[arr objectAtIndex:i]];
            
            //NSLog(@"Dict Log :: %@",dict);
            
            NSString *str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"account_name"]];
            
            [arr_account_name addObject:str];
            
            str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"account_no"]];
            [arr_account_no addObject:str]; 
            
            str = [NSString stringWithFormat:@"%@",[dict valueForKey:@"bank_name"]];
            [arr_bank_name addObject:str];
        }
        
        NSString  *strprem = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"discountPremium"]];
      
        
        NSMutableString *general_excesss = [NSMutableString stringWithString:strprem];
        [general_excesss replaceOccurrencesOfString:@".0000"
                                         withString:@""
                                            options:0
                                              range:NSMakeRange(0, general_excesss.length)];  
     if([general_excesss length] > 1)
        {    
           // str2 = [str2 substringToIndex:[str2 length] - 7];
        }
     else
        {
            strprem = @"In Process";
            //strprem=@"3456";
        }
        
        //NSLog(@"Str2 ::%@",strprem);
    
        
        NSString *strr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"RD"]];
        
       if([strr isEqualToString:@"YES"])
       {
           [premium_label setText:NSLocalizedString(@"Renewal premium", nil)];
          //old premium_label.text=@"@"" Amount";
           strprem=@"";
           strprem = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"renewal_amount"]];
           [feesAmount setText:strprem];  
       }
       else
       {
        //   Discounted Premium  Discounted Premium
       [premium_label setText:NSLocalizedString(@"Discounted Premium", nil)];
          
        if([strprem length] > 1)
           {    
             //str2 = [str2 substringToIndex:[str2 length] - 7];
           }
           else
           {
               strprem = @"In Process";
               //strprem=@"3456";
           }
          [feesAmount setText:strprem];  
       } 
   
        NSString *Str=[NSString stringWithFormat:@"%@",[arr_account_name objectAtIndex:0]];   
        acount_name_text.text = Str;
        
        Str=[NSString stringWithFormat:@"%@",[arr_account_no objectAtIndex:0]];
        account_no_text.text = Str;
      
        Str=[NSString stringWithFormat:@"%@",[arr_bank_name objectAtIndex:0]];
        bank_name_text.text = Str;
  
    }
   }
 else
  {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
        [alert show];
  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

 NSString *strr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"RD"]];
    
    if([strr isEqualToString:@"YES"])
    {
        if([segue.identifier isEqualToString:@"PFVCTOMM"])
        {  
            
        }
    }
    else
    {
        if([segue.identifier isEqualToString:@"PFVCTOPSVC"])
        {
        
        }
    }
}

#pragma  mark-- Continue button clicked ----
-(IBAction)ContinueClicked:(id)sender
{  

    
    
    [self.view setUserInteractionEnabled:NO];

BOOL Network=[self Reachability_To_Chechk_Network];
    
if(Network) //Network Check
{
    NSString *strr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"RD"]];
 
if([strr isEqualToString:@"YES"])
  {
      [self RenewalMethod];
  }
else // Non Renewal Loop
  {
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                     {
                         // Background work            
                         dispatch_async(dispatch_get_main_queue(), ^(void)
                                        {
                                            self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                            self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
                                            self.indicator.center = self.view.center;
                                            self.indicator.color=[UIColor whiteColor];
                                            self.indicator.layer.cornerRadius=10;
                                            [self.indicator setBackgroundColor:colourgreen];
                                            self.indicator.layer.zPosition++;
                                            self.indicator.layer.zPosition++;
                                            
                                            [self.indicator startAnimating];
                                            [self.view addSubview:self.indicator];  
                                            [self.view setUserInteractionEnabled:NO];
                                            [self.continueBtn setUserInteractionEnabled:NO];
                                            
                                        });
                     });
      
      [self.view setUserInteractionEnabled:NO];

      if(![feesAmount.text isEqualToString:@"In Process"] || [feesAmount.text isEqualToString:@"In Process"])
      {
          if(ImageFlag)
          {
              if(feesAmount.text.length>0)
                      {
                          NSString *urlString;
                          
                          NSString *user_id =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];
                          NSString *quotation_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_id"]];;
                          NSString *premium_amount=feesAmount.text;
                          NSString *account_no=[NSString stringWithFormat:@"%@",[arr_account_no objectAtIndex:0]];

                          NSString *trimmed;
                          
                          trimmed = [premium_amount stringByReplacingOccurrencesOfString: @" "
                                                                              withString: @""
                                                                                 options: NSRegularExpressionSearch
                                                                                   range: NSMakeRange(0, premium_amount.length)];
                          premium_amount = trimmed;
                         
                          PremiumDetails_SVC *controller = (PremiumDetails_SVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PremiumDetails_SVC"];
                          controller.bankReceiptImageview =[[UIImageView alloc]init];
                          
                          UIImage *img=[[UIImage alloc]init];
                          img = payment_receipt.image ;
                          controller.bankReceiptImageview.image = img;
                          
                          NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
                          
                          if([imgData length]>0)
                          {
                              NSOperationQueue *myQueuefvc = [[NSOperationQueue alloc] init];
                              [myQueuefvc addOperationWithBlock:^{
                                 
                                  [self.view setUserInteractionEnabled:NO];

                                  NSString  * urlString = [NSString stringWithFormat:@"%@savePaymentReciept_ios.php?user_id=%@&quotation_id=%@&premium_amount=%@&account_no=%@",kAPIEndpointLatestPath,user_id,quotation_id,premium_amount,account_no];
                                  
                                  //NSLog(@"urlString :: %@",urlString);
                                  
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
                                  //NSLog(@"quotation_id :: %@",quotation_id);
                                  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"quotation_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:quotation_id] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  
                                  //  premium_amount
                                  //NSLog(@"premium_amount :: %@",premium_amount);
                                  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"premium_amount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:premium_amount] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  
                                  //  account_no
                                  //NSLog(@"account_no :: %@",account_no);
                                  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"account_no\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:account_no] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  
                                  ///Pic para
                                  [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"payment_recipt_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"]  dataUsingEncoding:NSUTF8StringEncoding]];
                                  [body appendData:[NSData dataWithData:imgData]];
                                  [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                  
                                  [request setHTTPBody:body];
                                  
                                  NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                                  //NSLog(@"Return Data :: %@",returnData);
                                  
                                  NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                                  
                                  if(returnString.length>6)
                                  {
                                  [self.view setUserInteractionEnabled:YES];
                                  NSDictionary *jsonObject=[NSJSONSerialization
                                                            JSONObjectWithData:returnData
                                                            options:NSJSONReadingMutableLeaves
                                                            error:nil];
                                  //NSLog(@"JS :: %@",jsonObject);
                                  //NSLog(@"Return Data :: %@",returnString);
                                  
                                  NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
                                 
                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                      
                                      if([str isEqualToString:@"success"])
                                      {
                                          [self.view setUserInteractionEnabled:YES];

                                          [self performSegueWithIdentifier:@"PFVCTOPSVC" sender:self];

                                          ImageFlag=NO;
                                          
                                          [self.indicator setHidden:YES];
                                          
                                          [self.indicator removeFromSuperview];
                                          
                                          PremiumDetails_SVC *controller = (PremiumDetails_SVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PremiumDetails_SVC"];
                                          
                                          controller.bankReceiptImageview =[[UIImageView alloc]init];
                                          
                                          UIImage *img=[[UIImage alloc]init];
                                          img = payment_receipt.image ;
                                          controller.bankReceiptImageview.image = img;
                                          controller.strc=@"STRC";
                                          controller.Check=YES;
                                          
                                          dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                                         {
                                                             // Background work
                                                             dispatch_async(dispatch_get_main_queue(), ^(void)
                                                                            {
                                                                                [self.view setUserInteractionEnabled:YES];
                                                                                
                                                                                [self.indicator setHidden:YES];
                                                                                
                                                                                [self.indicator removeFromSuperview];
                                                                                
                                                                                [self.continueBtn setUserInteractionEnabled:YES];

                                                                                
                                                                                
                                                                            });
                                                         });
                                          
                                          

                                      }
                                      else
                                      {
                                          NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                          
                                          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                          [alert show];
                                          
                                          dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                                         {
                                                             // Background work
                                                             dispatch_async(dispatch_get_main_queue(), ^(void)
                                                                            {
                                                                                [self.view setUserInteractionEnabled:YES];
                                                                                
                                                                                [self.indicator setHidden:YES];
                                                                                
                                                                                [self.indicator removeFromSuperview];
                                                                                
                                                                                  [self.continueBtn setUserInteractionEnabled:YES];
                                                                                
                                                                                
                                                                            });
                                                         });
                                          
                                          [self.view setUserInteractionEnabled:YES];

                                          [self.indicator setHidden:YES];
                                          
                                          [self.indicator removeFromSuperview];
                                      }
                                      
                                  }];
                                }
                                else
                                { 
                                      [self.continueBtn setUserInteractionEnabled:YES];
                                    [self.view setUserInteractionEnabled:YES];
                                    
                                    [self.indicator setHidden:YES];
                                    
                                    [self.indicator removeFromSuperview];
                                    
                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                                    [alert show];
                                }
                            }];
                         }
                        else
                        {
                              [self.continueBtn setUserInteractionEnabled:YES];
                            [self.view setUserInteractionEnabled:YES];
                            
                            [self.indicator setHidden:YES];
                            
                            [self.indicator removeFromSuperview];
                            

                          [self.view setUserInteractionEnabled:YES];
                        } //Image length
                          
                      }
                      else
                      { [self.view setUserInteractionEnabled:YES];
                          
                          [self.indicator setHidden:YES];
                          
                          [self.indicator removeFromSuperview];
                          
                          dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                         {
                                             // Background work
                                             dispatch_async(dispatch_get_main_queue(), ^(void)
                                                            {
                                                                [self.view setUserInteractionEnabled:YES];
                                                                
                                                                [self.indicator setHidden:YES];
                                                                
                                                                [self.indicator removeFromSuperview];
                                                                
                                                                  [self.continueBtn setUserInteractionEnabled:YES];
                                                                
                                                                
                                                            });
                                         });
                          
                          
                            [self.continueBtn setUserInteractionEnabled:YES];
                          
                          [self.view setUserInteractionEnabled:YES];
                          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                          [alert show];
                      }
          }
          else
          {
              [self.view setUserInteractionEnabled:YES];

              [self.view setUserInteractionEnabled:YES];
              
              [self.indicator setHidden:YES];
              
              [self.indicator removeFromSuperview];
              dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                             {
                                 // Background work
                                 dispatch_async(dispatch_get_main_queue(), ^(void)
                                                {
                                                    [self.view setUserInteractionEnabled:YES];
                                                    
                                                    [self.indicator setHidden:YES];
                                                    
                                                    [self.indicator removeFromSuperview];
                                                      [self.continueBtn setUserInteractionEnabled:YES];
                                                    
                                                    
                                                    
                                                });
                             });
              
              


              UIAlertView * alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
              [alert show];
           }
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
                                                
                                                  [self.continueBtn setUserInteractionEnabled:YES];
                                                
                                                
                                            });
                         });
          
          

          
          [self.view setUserInteractionEnabled:YES];
          
          [self.indicator setHidden:YES];
          
          [self.indicator removeFromSuperview];
       
          UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"cover note", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
          [alert show];
      }
  }
}
else //Network Loop
{
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                       {
                           // Background work
                           dispatch_async(dispatch_get_main_queue(), ^(void)
                                          {
                                              [self.view setUserInteractionEnabled:YES];
                                              
                                              [self.indicator setHidden:YES];
                                              
                                              [self.indicator removeFromSuperview];
                                              
                                              [self.continueBtn setUserInteractionEnabled:YES];
                                              [self.view setUserInteractionEnabled:YES];
                                               
                                          });
                       });
        


        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)RenewalMethod
{
    [self.view setUserInteractionEnabled:NO];
    
    BOOL Network=[self Reachability_To_Chechk_Network];
    
    if(Network) //Network Check
    {
        NSString *strr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"RD"]];
        
        if([strr isEqualToString:@"YES"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"BtnFlagstr"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSString *BtnFlagstr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"BtnFlagstr"]];
            
            if([BtnFlagstr isEqualToString:@"YES"])
            {
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                               {
                                   dispatch_async(dispatch_get_main_queue(), ^(void)
                                                  {
                                                      self.indicatorrenewal = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                                                      self.indicatorrenewal.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
                                                      self.indicatorrenewal.center = self.view.center;
                                                      self.indicatorrenewal.color=[UIColor whiteColor];
                                                      self.indicatorrenewal.layer.cornerRadius=10;
                                                      [self.indicatorrenewal setBackgroundColor:colourgreen];
                                                      self.indicatorrenewal.layer.zPosition++;
                                                      self.indicatorrenewal.layer.zPosition++;                                         
                                                      [self.indicatorrenewal startAnimating];
                                                      [self.view addSubview:self.indicatorrenewal];  
                                                  });
                               });
                
                if(ImageFlag)
                {
                    NSString *strr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"RD"]];
                    
                    if([strr isEqualToString:@"YES"])
                    {
                        {
                            NSString *strRenewal=[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"renewal_amount"]];
                            
                            feesAmount.text=strRenewal;
                            
                            if(feesAmount.text.length>0)
                            {
                                NSString *user_id =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];
                                NSString *quotation_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_id"]];
                                NSString *renewal_amount=feesAmount.text;
                                NSString *trimmed;
                                
                                trimmed = [renewal_amount stringByReplacingOccurrencesOfString: @" "
                                                                                    withString: @""
                                                                                       options: NSRegularExpressionSearch
                                                                                         range: NSMakeRange(0, renewal_amount.length)];
                                renewal_amount=trimmed;
                                NSString *account_no=[NSString stringWithFormat:@"%@",[arr_account_no objectAtIndex:0]];
                                
                                UIImage *img=[[UIImage alloc]init];
                                img = payment_receipt.image ;
                                
                                NSData *imgData = UIImageJPEGRepresentation(img, 1.0);
                                
                                if([imgData length]>0)
                                {

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                    {
                                                       
                   NSString  * urlString = [NSString stringWithFormat:@"%@renewalPayment_ios.php?user_id=%@&quotation_id=%@&premium_amount=%@&account_no=%@",kAPIEndpointLatestPath,user_id,quotation_id,renewal_amount,account_no];
                                                       
                                                       //NSLog(@"urlString :: %@",urlString);
                                                       
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
                                                       //NSLog(@"quotation_id :: %@",quotation_id);
                                                       [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"quotation_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:quotation_id] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       
                                                       //  premium_amount
                                                       //NSLog(@"renewal_amount :: %@",renewal_amount);
                                                       [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"renewal_amount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:renewal_amount] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       
                                                       //  account_no
                                                       //NSLog(@"account_no :: %@",account_no);
                                                       [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"account_no\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:account_no] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       
                                                       ///Pic para
                                                       [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"payment_recipt_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"]  dataUsingEncoding:NSUTF8StringEncoding]];
                                                       [body appendData:[NSData dataWithData:imgData]];
                                                       [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                                       
                                                       [request setHTTPBody:body];
                                                       
                                                       NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                                                       //NSLog(@"Return Data :: %@",returnData);
                                                       
                                                       NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                                                       
                                                       if(returnString.length>6)
                                                       {
                                                           
                                                           NSDictionary *jsonObject=[NSJSONSerialization
                                                                                     JSONObjectWithData:returnData
                                                                                     options:NSJSONReadingMutableLeaves
                                                                                     error:nil];
                                                           //NSLog(@"JS :: %@",jsonObject);
                                                           //NSLog(@"Return Data :: %@",returnString);
                                                           
                                                           NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
                                                           //      [indicator stopAnimating];
                                                           
                                                           
                                                       // Background work
              dispatch_async(dispatch_get_main_queue(), ^(void)
               {
                                                                          
                     if([str isEqualToString:@"success"])
                        {
                                                                              
                                                                              [self performSegueWithIdentifier:@"PFVCTOMM" sender:self];
                                                                              
                                                                              
                                                                              
                                                                              ImageFlag=NO;
                                                                              
                                                                              NSString *strr = @"NO";
                                                                              [[NSUserDefaults standardUserDefaults]setObject:strr forKey:@"RD"];
                                                                              [[NSUserDefaults standardUserDefaults]synchronize];
                                                                              
                                                                              //NSLog(@"Email :: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"email"]);
                                                                              NSString *msgstr=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                                                              
                                                                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Paid policy", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles: nil];
                                                                              [alert show];
                                                                              
                                                                              [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"BtnFlagstr"];
                                                                              [[NSUserDefaults standardUserDefaults]synchronize];
                                                                              
                                                                              [self.view setUserInteractionEnabled:YES];
                                                                              
                                                                          }
                     else
                        {
                                                                              
                                                                              
                                                                              [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"BtnFlagstr"];
                                                                              [[NSUserDefaults standardUserDefaults]synchronize];
                                                                              
                                                                              NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                                                              
                                                                              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                                                              [alert show];
                                                                              
                                                                          }
                                                                    
                                                                          
                                                                          
                                                                          
                                                                          [self.view setUserInteractionEnabled:YES];
                                                                          
                                                                          [self.indicator setHidden:YES];
                                                                          
                                                                          [self.indicator removeFromSuperview];
                                                                          
                                                                          [self.continueBtn setUserInteractionEnabled:YES];
                                                                          [self.view setUserInteractionEnabled:YES];
                                                                          
                 });
                                                           
                                                       }
                                                       else
                                                       {
                                                           
                                                           [self.view setUserInteractionEnabled:YES];
                                                           
                                                           [self.indicator setHidden:YES];
                                                           
                                                           [self.indicator removeFromSuperview];
                                                           
                                                           [self.continueBtn setUserInteractionEnabled:YES];
                                                           [self.view setUserInteractionEnabled:YES];

                                                           
                                                           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                                                           [alert show];
                                                       }

                                                   });
                                        
                                      }
                                else
                                {
                                    [self.view setUserInteractionEnabled:NO];
                                    
                                    [self.indicatorrenewal setHidden:YES];
                                    
                                    [self.indicatorrenewal removeFromSuperview];
                                    
                                  
                                dispatch_async(dispatch_get_main_queue(), ^(void)
                                                                     {
                                                                          [self.view setUserInteractionEnabled:YES];
                                                                          
                                                                          [self.indicatorrenewal setHidden:YES];
                                                                          
                                                                          [self.indicatorrenewal removeFromSuperview];
                                                                          [self.continueBtn setUserInteractionEnabled:YES];
                                                                          
                                                                      });
                                    
                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                                    [alert show];
                                    [self.view setUserInteractionEnabled:YES];
                                }
                            }
                       }
                    }
           else
                    {
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                       {
                                           // Background work
                                           dispatch_async(dispatch_get_main_queue(), ^(void)
                                                          {
                                                              [self.view setUserInteractionEnabled:YES];
                                                              [self.indicatorrenewal setHidden:YES];
                                                              [self.indicatorrenewal removeFromSuperview];
                                                              [self.continueBtn setUserInteractionEnabled:YES];
                                                          });
                                       });
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                        [alert show];
                    }
                }
                else
                {
                   [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"BtnFlagstr"];
                   [[NSUserDefaults standardUserDefaults]synchronize];
                   
                    BtnFlagstr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"BtnFlagstr"]];
                    
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                   {
                                       // Background work
                                       dispatch_async(dispatch_get_main_queue(), ^(void)
                                                      {
                                                          [self.view setUserInteractionEnabled:YES];
                                                          [self.indicatorrenewal setHidden:YES];
                                                          [self.indicatorrenewal removeFromSuperview];
                                                          [self.continueBtn setUserInteractionEnabled:YES];
                                                      });
                                   });
                    
                    
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                    [alert show];
                }
                
            } 
            
        }
    }
    else //Network Loop
    {
        
       
                           // Background work
                           dispatch_async(dispatch_get_main_queue(), ^(void)
                                          {
                                              [self.indicator setHidden:YES];
                                              [self.indicator removeFromSuperview];
                                              [self.continueBtn setUserInteractionEnabled:YES];
                                              [self.view setUserInteractionEnabled:YES];
                                          });
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}


-(IBAction)selectImage:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
     popup.tag = 1;
    [popup showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    id sender;
    if(popup.tag == 1)
    {   
        switch (popup.tag) {
            case 1: {
                switch (buttonIndex) {
                    case 0:
                        [self selectImageFromGallary:sender];
                        break;
                    case 1:
                        [self shootNow:sender];
                        break;
                    default:
                        break;
                }
                break;
            }
              default:
                  break;
        }
    }  
}

-(IBAction)selectImageFromGallary:(id)sender
{
  UIImagePickerController *pickerController = [AlbumClass imagePickerControllerWithDelegate:self];
  [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)shootNow:(id)sender
{
    //    objCreative.photoView.image = nil;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   ImageFlag = YES;

    UIImage *photo;
    
    //NSLog(@"Info 1 :: %@",info);
    
    photo = [AlbumClass imageWithMediaInfo:info];
    
   [self dismissViewControllerAnimated:YES completion:nil];
    
    //Do not delete this block
    [UIView animateWithDuration:50.0
                     animations:^{
                
        self.navigationController.navigationBarHidden = NO;
                        
        self.payment_receipt.image = photo;
          
            ImageFlag= YES;
                         
                     } completion:^(BOOL finished) {
                         if ([UIScreen mainScreen].bounds.size.height == 480)
                         {   
                         }                         
                         //                         [pickerView removeFromSuperView];
                     }];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark -
#pragma mark - CameraDelegate

- (void)cameraDidTakePhoto:(UIImage *)image
{
    
    
    UIImage *photo;
    photo   = image;
    
    self.payment_receipt.image = photo;
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraWillTakePhoto
{
}

-(void)selectBank
{
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

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(void)didReceiveMemoryWarning {
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
- (IBAction)ApplyPayBtnPressed:(id)sender {
    // [Crittercism beginTransaction:@"checkout"];
    
    if([PKPaymentAuthorizationViewController canMakePayments]) {
        
        NSLog(@"Woo! Can make payments!");
        NSString *premium_amount=feesAmount.text;

        
        PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
        
 
        PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"Premium Amount"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:premium_amount]];
        
        request.paymentSummaryItems = @[total];
        request.countryCode = @"HK";
        request.currencyCode = @"HKD";
        request.supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
        request.merchantIdentifier = @"merchant.carbo";
        request.merchantCapabilities = PKMerchantCapabilityEMV;
        
        PKPaymentAuthorizationViewController *paymentPane = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
        paymentPane.delegate = self;
        [self presentViewController:paymentPane animated:TRUE completion:nil];
        
    } else {
        NSLog(@"This device cannot make payments");
    }
}

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    NSLog(@"Payment was authorized: %@", payment);
    
    // do an async call to the server to complete the payment.
    // See PKPayment class reference for object parameters that can be passed
    BOOL asyncSuccessful = FALSE;
    
    // When the async call is done, send the callback.
    // Available cases are:
    //    PKPaymentAuthorizationStatusSuccess, // Merchant auth'd (or expects to auth) the transaction successfully.
    //    PKPaymentAuthorizationStatusFailure, // Merchant failed to auth the transaction.
    //
    //    PKPaymentAuthorizationStatusInvalidBillingPostalAddress,  // Merchant refuses service to this billing address.
    //    PKPaymentAuthorizationStatusInvalidShippingPostalAddress, // Merchant refuses service to this shipping address.
    //    PKPaymentAuthorizationStatusInvalidShippingContact        // Supplied contact information is insufficient.
    
    if(asyncSuccessful) {
        completion(PKPaymentAuthorizationStatusSuccess);
        
        // do something to let the user know the status
        
        NSLog(@"Payment was successful");
        
        //        [Crittercism endTransaction:@"checkout"];
        
    } else {
        completion(PKPaymentAuthorizationStatusFailure);
        
        // do something to let the user know the status
        
        NSLog(@"Payment was unsuccessful");
        
        //        [Crittercism failTransaction:@"checkout"];
    }
    
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"Finishing payment view controller");
    
    // hide the payment window
    [controller dismissViewControllerAnimated:TRUE completion:nil];
}




@end
