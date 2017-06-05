//
//  renewalPolicylist.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "renewalPolicylist.h"
#import "PremiumDetails_FVC.h"
#import "renewalDetailVC.h"
#import "Reachability.h"
#import "policyDetails2.h"
#import "car_imageVC.h"
#import "Constant.h"
#define kRefreshTimeInSeconds 8
#define khideTimeInSeconds 12

@interface renewalPolicylist ()
{
    UIActivityIndicatorView *indicator;
    NSMutableArray *status;
    NSMutableArray *arr_policy_id;
    NSMutableArray *arr_policy_name;
    NSMutableArray *arr_date;
    NSMutableArray *expiry_DAte;
    NSMutableArray *arr_pdf;
    NSMutableArray *arr_pdf_url;
    NSMutableArray *renewalpolicylist;
    NSMutableArray *arr_amount;
    NSMutableArray *arr_policy_type;
    NSMutableArray *arr_vehical_name;
    UIColor *colour;
    NSMutableArray *arr_premium_amount;
    NSMutableArray *arr_premium_percentage;
    NSMutableArray *arr_submit;
    NSMutableArray *arr_renewal_amount;
    NSMutableArray *arr_Previous_amount;
    NSMutableArray *arr_email;
    NSMutableArray *arr_regmark;
    NSMutableArray *arr_resubmit_Flag;
    NSTimer *myTimerName;;
    NSTimer *hide_labelTimerName;;
    UILabel *alertlabel;
}
@end

@implementation renewalPolicylist
//@synthesize renewaltableview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0]; 
    
    self.navigationItem.title =NSLocalizedString(@"Policy List", nil);
    renewalpolicylist = [[NSMutableArray alloc]init];
    [renewalpolicylist addObject:@"str"];
    [renewalpolicylist addObject:@"str"];
    [renewalpolicylist addObject:@"str"];
    [renewalpolicylist addObject:@"str"];
    [renewalpolicylist addObject:@"str"];
    
    //_renewaltableview=[UITableView alloc]ini
    renewaltableview = [[UITableView alloc]init];
    renewaltableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    renewaltableview.frame = CGRectMake(0,30,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen]bounds].size.height);
    [renewaltableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    renewaltableview.scrollEnabled = YES;
    [renewaltableview setBackgroundColor:[UIColor whiteColor]];
    renewaltableview.tag=100000;
    //[_renewaltableview setAlpha:1];
 
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
  
}

-(void)viewWillAppear:(BOOL)animated
{
      [renewaltableview  setUserInteractionEnabled:YES];
   
    NSString *str=@"NO";
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"RD"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-40)/2,([[UIScreen mainScreen]bounds].size.height-40)/2, 80.0, 80.0);
    indicator.center = self.view.center;
    indicator.color=colour;
    indicator.layer.cornerRadius=10;
    // [indicator setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
// [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    [indicator startAnimating];
    
    myTimerName  =   [NSTimer scheduledTimerWithTimeInterval: kRefreshTimeInSeconds
                                                   target:self 
                                                 selector:@selector(Refreshcalled) 
                                                 userInfo:nil
                                                  repeats:YES];
    
//    hide_labelTimerName = [NSTimer scheduledTimerWithTimeInterval: khideTimeInSeconds
//                                                   target:self
//                                                 selector:@selector(hidealertlabel)
//                                                 userInfo:nil
//                                                  repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self Renewal_list];
    renewaltableview.dataSource = self;
    renewaltableview.delegate = self;
    [self.view addSubview:renewaltableview];
    [indicator stopAnimating];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [myTimerName invalidate];
    
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

#pragma mark --- Renewal list
-(void)Renewal_list
{
   BOOL Network=[self Reachability_To_Chechk_Network];
if(Network)
 {
   // NSString *myRequestString = [NSString stringWithFormat:@"http://74.208.12.101/Carboservices/getpolicylist.php"];
     
     NSString *myRequestString = [NSString stringWithFormat:@"%@getpolicylist.php",kAPIEndpointLatestPath];
     
    NSString *struserid=[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
    //NSString *str1=@"20";
    NSDictionary *userNameDict = @{@"user_id" : struserid};
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
   // //NSLog(@"Postdata to server REnewal List:: %@",response2);

if(response2.length>6)
     {
         NSDictionary *jsonObject = [NSJSONSerialization
                                     JSONObjectWithData:returnData
                                     options:NSJSONReadingMutableLeaves
                                     error:nil];
         //NSLog(@"JSF Object :: %@",jsonObject);
         
         NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
         if([str isEqualToString:@"Fail"])
         {
            alertlabel =[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-75,100 , 150,50)];
             [alertlabel setTextAlignment:NSTextAlignmentCenter];
             [alertlabel setText:NSLocalizedString(@"No policy available !", nil) ];
             [self.view addSubview:alertlabel];
             [renewaltableview setHidden:YES];
             
            //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"No policy available !", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            // [alert show];
         }
         else
         {
             [alertlabel removeFromSuperview];
             
             [renewaltableview setHidden:NO];
             NSArray *arr=[[NSArray alloc]initWithArray:[jsonObject valueForKey:@"result"]];

             arr_policy_id   = [[NSMutableArray alloc]init];
             arr_policy_name = [[NSMutableArray alloc]init];
             arr_date        = [[NSMutableArray alloc]init];
             status          = [[NSMutableArray alloc]init];
             arr_pdf_url     = [[NSMutableArray alloc]init];
             expiry_DAte     = [[NSMutableArray alloc]init];
             arr_pdf         = [[NSMutableArray alloc]init];
             arr_amount      = [[NSMutableArray alloc]init];
             arr_policy_type = [[NSMutableArray alloc]init];
             arr_vehical_name = [[NSMutableArray alloc]init];
             arr_premium_amount = [[NSMutableArray alloc]init];
             arr_premium_percentage = [[NSMutableArray alloc]init];
             arr_submit = [[NSMutableArray alloc]init];
             arr_Previous_amount = [[NSMutableArray alloc]init];
             arr_renewal_amount = [[NSMutableArray alloc]init];
             arr_email=[[NSMutableArray alloc]init];
             arr_regmark=[[NSMutableArray alloc]init];
             arr_resubmit_Flag=[[NSMutableArray alloc]init];
             
             for (int i=0;i<arr.count; i++)
             {
                 NSDictionary *dict=[[NSDictionary alloc]initWithDictionary:[arr objectAtIndex:i]];
                 
                 NSString *strdate = [NSString stringWithFormat:@"%@",[dict valueForKey:@"createDate"]];
                 
                 NSString *strpolicyid = [NSString stringWithFormat:@"%@",[dict valueForKey:@"policy_id"]];
                 
                 NSString *strpolicyname = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Name"]];
                 
                 NSString *strstatus = [NSString stringWithFormat:@"%@",[dict valueForKey:@"status"]];
                 
                 NSString *strpdf = [NSString stringWithFormat:@"%@",[dict valueForKey:@"pdf"]];
                 
                 NSString *strexpiry = [NSString stringWithFormat:@"%@",[dict valueForKey:@"expiry_date"]];
                 
                 NSString  *stramount=[NSString stringWithFormat:@"%@",[dict valueForKey:@"amount"]];
                 
                 NSString  *strpolicy_type=[NSString stringWithFormat:@"%@",[dict valueForKey:@"policy_type"]];
                 
                 NSString *strvehical_name=[NSString stringWithFormat:@"%@",[dict valueForKey:@"vehicle_name"]];
                 
                 NSString  *strpremium_amount = [NSString stringWithFormat:@"%@",[dict valueForKey:@"premium_amount"]];
                 
                 NSString *strpremium_percent = [NSString stringWithFormat:@"%@",[dict valueForKey:@"premium_percent"]];
                 
                 NSString *strsubmit = [NSString stringWithFormat:@"%@",[dict valueForKey:@"submitted"]];
                 
                 NSString *str_renewal_amount = [NSString stringWithFormat:@"%@",[dict valueForKey:@"renewal_amount"]];
                 
                 NSString *str_previousAmount = [NSString stringWithFormat:@"%@",[dict valueForKey:@"previousPayment"]];
                 NSString *str_email=[NSString stringWithFormat:@"%@",[dict valueForKey:@"agentEmail"]];
                 
                 NSString *str_regmark = [NSString stringWithFormat:@"%@",[dict valueForKey:@"registration_mark"]];
                 
                 NSString *image_resubmit=[NSString stringWithFormat:@"%@",[dict valueForKey:@"imageresubmitted"]];
                 
                 [arr_premium_amount  addObject:strpremium_amount];      // Premium amount
                 [arr_premium_percentage addObject:strpremium_percent];  //Premium Percentage
                 [arr_policy_name addObject:strpolicyname];              // policy name
                 [arr_policy_id addObject:strpolicyid];                  // policy ID
                 [status addObject:strstatus];                           // Status
                 [arr_date addObject:strdate];                           // DAte
                 [arr_pdf addObject:strpdf];                             // Pdf
                 [expiry_DAte addObject:strexpiry];                      // Expiry Date
                 [arr_amount addObject:stramount];                       // fees amount
                 [arr_policy_type addObject:strpolicy_type];             // policy Type
                 [arr_submit addObject:strsubmit];                       // Submit
                 [arr_vehical_name addObject:strvehical_name];           // vehical name
                 [arr_renewal_amount addObject:str_renewal_amount];      // Renewal_Amount
                 [arr_Previous_amount  addObject:str_previousAmount];      // previous Amount
                 [arr_email addObject:str_email];                    //Email
                 [arr_regmark addObject:str_regmark];              //Regmark
                 [arr_resubmit_Flag addObject:image_resubmit];    //Image Resubmit
             }
         }
     }
     else
     {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
         [alert show];
     }
     }
else
    {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Something went wrong! please try again later.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
             [alert show];
             
   }   
}

-(void)Refreshcalled
{
    [self Renewal_list];
    [renewaltableview reloadData];
}

-(void)hidealertlabel
{
  [alertlabel removeFromSuperview];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if([[segue identifier] isEqualToString:@"RLTOAR"]) 
    {
    }
} 

#pragma mark - TableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 9;
    return status.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"cellIdentifier";
    
    renewalCell *cell = (renewalCell*)[renewaltableview dequeueReusableCellWithIdentifier:cellIdentifier1];  
    
    cell = [[renewalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
    
    NSString *StrDate    = [NSString stringWithFormat:@"%@",[arr_date objectAtIndex:indexPath.row]];
    
    NSString *strpolicyn = [NSString stringWithFormat:@"%@",[arr_policy_name objectAtIndex:indexPath.row]];
    
    NSString *strstatus   = [NSString stringWithFormat:@"%@",[status objectAtIndex:indexPath.row]];
  
    NSString *strpolicyid = [NSString stringWithFormat:@"%@",[arr_policy_id objectAtIndex:indexPath.row]];
    
    NSString *strpolicytype = [NSString stringWithFormat:@"%@",[arr_policy_type objectAtIndex:indexPath.row]];
    
    NSString *strvehical_name = [NSString stringWithFormat:@"%@",[arr_vehical_name objectAtIndex:indexPath.row]];
    
    NSString *sumbitFlag=[NSString stringWithFormat:@"%@",[arr_submit objectAtIndex:indexPath.row]
                           ];
    
    NSString *status1= [NSMutableString stringWithFormat:@"%@",[status objectAtIndex:indexPath.row]];
    
    NSString *strRegMark=[NSString stringWithFormat:@"%@",[arr_regmark objectAtIndex:indexPath.row]];

    NSString *strImageResubmit=[NSString stringWithFormat:@"%@",[arr_resubmit_Flag objectAtIndex:indexPath.row]];

      NSString *PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Completed", nil)];
    
        if([sumbitFlag isEqualToString:@"1"])
        {
            if([status1 isEqualToString:@"Completed"])
            {
                PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Completed", nil)];
                cell.status.text=PolicyType;
            }
            else if([status1 isEqualToString:@"Processing"])
            {
                PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Paid", nil)];
                cell.status.text=NSLocalizedString(@"Paid", nil);
            }
            else if([status1 isEqualToString:@"Pending"])
            {
               PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Pending", nil)];
                cell.status.text=PolicyType;
            }  
        }
        else
        {
            if([status1 isEqualToString:@"Completed"])
            {
                cell.status.text=NSLocalizedString(@"Due Renewal", nil); // @"Due Renewal";
            }
            else if([status1 isEqualToString:@"Processing"])
            {
                 PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Processing", nil)];
                cell.status.text=PolicyType;
            }
            else if([status1 isEqualToString:@"Pending"])
            {
                PolicyType = [NSString stringWithFormat:NSLocalizedString(@"Pending", nil)];
                cell.status.text=PolicyType;
            } 
     }
   
    cell.heading_Label.text      = strpolicyn;
    cell.policy_id_value.text    = strpolicyid;
    cell.created_Date_value.text = StrDate;
    
    cell.policy_type_val.text = NSLocalizedString(strpolicytype, nil);
    cell.vehical_name.text =strvehical_name;
    cell.regMark_val.text=strRegMark;
    cell.UploadBtn.tag=indexPath.row;
    cell.rendelegate=self;
    cell.heading_Label.text = strpolicyid;

    return cell;
}


#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *str=[NSString stringWithFormat:@"%@",[status objectAtIndex:indexPath.row]];
 
    NSString  *submitFlag =[NSString stringWithFormat:@"%@",
                           [[NSUserDefaults standardUserDefaults]valueForKey:@"submitFlag"]];
    NSString *OK = [NSString stringWithFormat:NSLocalizedString(@"OK", nil)];
    
 if([str isEqualToString:@"Pending"])
  {
         UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"Without Cover note1", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
         [alert show];
  }
 else if([str isEqualToString:@"Processing"])
    {
        //Policy ID
        str=[NSString stringWithFormat:@"%@",[arr_policy_id objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_id"];
        
          //Policy Name
        str=[NSString stringWithFormat:@"%@",[arr_policy_name objectAtIndex:indexPath.row]]; 
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_Name"];
        
          //Policy Expiry DAte
        str=[NSString stringWithFormat:@"%@",[expiry_DAte objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_expiry_date"];
        
          //Policy PDF URL
        str=[NSString stringWithFormat:@"%@",[arr_pdf objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_pdf_url"];
        
        str=[NSString stringWithFormat:@"%@",[arr_premium_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"arr_premium_amount"];
        
        //Policy Amount
        str=[NSString stringWithFormat:@"%@",[arr_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_amount"];
        
        //Policy Premium amount
        str=[NSString stringWithFormat:@"%@",[arr_premium_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"premium_amount"];
        //NSLog(@"arr_premium_amount::%@", str);
    
        str=[NSString stringWithFormat:@"%@",[arr_email objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"email"];
       
        //Policu premium Percentage
        str=[NSString stringWithFormat:@"%@",[arr_premium_percentage objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"arr_premium_percentage"];

        str=[NSString stringWithFormat:@"%@",[arr_submit objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"submitFlag"];
        
        //NSLog(@"arr_premium_percentage::%@", str);
       
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //You already submitted data previously,you are about to resubmit
        
        if([str isEqualToString:@"1"])
        {
            UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Paid policy", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alertview show];
        }
        else
        {
            [renewaltableview  setUserInteractionEnabled:NO];
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          policyDetails2  *rootController =(policyDetails2*)[storyboard instantiateViewControllerWithIdentifier:@"policyDetails2"];
          [self.navigationController pushViewController:rootController animated:YES];
        }
    }
    else if([str isEqualToString:@"Completed"])
    {
        //Policu premium Percentage
        str=[NSString stringWithFormat:@"%@",[arr_premium_percentage objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"arr_premium_percentage"];
        
        str=[NSString stringWithFormat:@"%@",[arr_policy_id objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_id"];
      
        str=[NSString stringWithFormat:@"%@",[arr_policy_name objectAtIndex:indexPath.row]]; 
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_Name"];
      
        str=[NSString stringWithFormat:@"%@",[expiry_DAte objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_expiry_date"];
       
        str=[NSString stringWithFormat:@"%@",[arr_email objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"email"];

        
        //Previous_Amount
        str=[NSString stringWithFormat:@"%@",[arr_Previous_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Previous_amount"];
        
        //Policy Premium amount
        str=[NSString stringWithFormat:@"%@",[arr_premium_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"premium_amount"];
        
        str=[NSString stringWithFormat:@"%@",[arr_pdf objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_pdf_url"];
        
        str=[NSString stringWithFormat:@"%@",[arr_renewal_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"renewal_amount"];
       
       str=[NSString stringWithFormat:@"%@",[arr_amount objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Policy_amount"];
        //NSLog(@"Policy_amount Amount :: %@",str);
        
        str=@"YES";
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"RD"];
        
        str=[NSString stringWithFormat:@"%@",[arr_submit objectAtIndex:indexPath.row]];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"submitFlag"];
        
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if([str isEqualToString:@"1"])
        {
           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          renewalDetailVC *rootController =(renewalDetailVC*)[storyboard instantiateViewControllerWithIdentifier:@"renewalDetailVC"];
          [self.navigationController pushViewController:rootController animated:YES];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            policyDetails2  *rootController =(policyDetails2*)[storyboard instantiateViewControllerWithIdentifier:@"policyDetails2"];
            [self.navigationController pushViewController:rootController animated:YES];
        }
    }
}

-(void)didselectImage:(renewalCell*)renewalCell;
{
    NSInteger i=renewalCell.UploadBtn.tag;
 
    NSString *pID=[NSString stringWithFormat:@"%@",[arr_policy_id objectAtIndex:i]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    car_imageVC  *rootController =(car_imageVC*)[storyboard instantiateViewControllerWithIdentifier:@"car_imageVC"];
    rootController.policyid=pID;
    [self.navigationController pushViewController:rootController animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deletestr=[NSString stringWithFormat:@"%@",[arr_policy_id objectAtIndex:indexPath.row]];
    
    BOOL Flag = [self DeletePolicy:deletestr];
    
if(Flag)
    {
       [self Renewal_list];
        [renewaltableview reloadData];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)DeletePolicy:(NSString *)policyId
{
       NSString *myRequestString = [NSString stringWithFormat:@"%@removeQuotations.php",kAPIEndpointLatestPath];
       NSDictionary *userNameDict = @{@"quotation_id" : policyId
                                       };
        NSError *error;
    
        BOOL Network = [self Reachability_To_Chechk_Network];
    
if(Network)
        {
            NSData  *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
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
            
            //{"response_code":"Fail","response_message":"No Notification"}
            
 if(response2.length > 6)
     {
            NSDictionary *jsonObject = [NSJSONSerialization
                                        JSONObjectWithData:returnData
                                        options:NSJSONReadingMutableLeaves
                                        error:nil];
            
            //NSLog(@"JSF Object :: %@",jsonObject);
            
            // NSArray *arr=[[NSArray alloc]initWithArray:[jsonObject valueForKey:@"result"]];
            
            NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
            
        if([str isEqualToString:@"success"])
           {
//              UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Successfully removed policy", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                [alert show];
               
               NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
               
               UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
               [alert show];
                return YES;
            }
         else
            {
                
                NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
                return NO;
            }
        }
       else
          {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles:nil];
            [alert show];
          }
            
        }
   else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
        return NO;
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

#pragma mark - color 


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
