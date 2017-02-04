//
//  notificationListVC.m
//  CarBo
//
//  Created by Shirish Vispute on 05/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "notificationListVC.h"
#import "notificationCell.h"
#import "Reachability.h"
#import "NotificationDetailVC.h"
#import "MainVC.h"
#import "Constant.h"
@interface notificationListVC ()
{
    NSMutableArray *arrdate;
    NSMutableArray *arrReview;
    NSMutableArray *arrNotification;
    
}
@end

@implementation notificationListVC

@synthesize notificationtableview;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *Noti=[NSString stringWithFormat:NSLocalizedString(@"Notification", nil)];

    self.navigationItem.title = Noti;
    [self NotificationDetails];
    
   UIColor *colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    
   notificationtableview=[[UITableView alloc]init];
   notificationtableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   notificationtableview.frame = CGRectMake(0,-35,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen]bounds].size.height+60);
   [notificationtableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [notificationtableview setSeparatorColor:colour];
    
   notificationtableview.scrollEnabled = YES;
    [notificationtableview setBackgroundColor:[UIColor whiteColor]];
   notificationtableview.tag=101;
    //[_notificationtableview setAlpha:1];
   notificationtableview.dataSource = self;
   notificationtableview.delegate=self;
    [self.view addSubview:notificationtableview];
    
    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump22) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

-(void)backJump22
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainVC  *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    [self.navigationController pushViewController:rootController animated:YES];
}

-(void)NotificationDetails
{
    NSString *myRequestString = [NSString stringWithFormat:@"%@getNotifications.php",kAPIEndpointLatestPath];
     NSString *struserid = [[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
    
    NSDictionary *userNameDict = @{@"user_id" : struserid
                                   };
    NSError *error;
  
    BOOL Network=[self Reachability_To_Chechk_Network];
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
    
   
        //RR
        if(response2.length>6)
        {
            NSDictionary *jsonObject = [NSJSONSerialization
                                        JSONObjectWithData:returnData
                                        options:NSJSONReadingMutableLeaves
                                        error:nil];
            
            //NSLog(@"JSF Object :: %@",jsonObject);
            
            NSArray *arr=[[NSArray alloc]initWithArray:[jsonObject valueForKey:@"result"]];
            
            NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
            
            // NSString *strm = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
            
            arr_createDate = [[NSMutableArray alloc]init];
            arr_msg        = [[NSMutableArray alloc]init];
            arrNotification=[[NSMutableArray alloc]init];
            if([str isEqualToString:@"Success"])
            {
                for (int i=0;i<arr.count;i++)
                {
                    NSDictionary *dictmsg = [[NSDictionary alloc]initWithDictionary:[arr objectAtIndex:i]];
                    
                    //??CREATE DATE
                    str = [NSString stringWithFormat:@"%@",[dictmsg valueForKey:@"createDate"]];
                    [arr_createDate addObject:str];
                    
                    //NOTIFICATION ID
                    str = [NSString stringWithFormat:@"%@",[dictmsg valueForKey:@"notification_id"]];
                    [arrNotification addObject:str];
                    
                    //MSG
                    str = [NSString stringWithFormat:@"%@",[dictmsg valueForKey:@"msg"]];
                    [arr_msg addObject:str];   
                }
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
      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
      [alert show];
 }
}

-(BOOL)DeleteNotification:(NSString*)noti_id
{
    NSString *myRequestString = [NSString stringWithFormat:@"%@removeNotification.php",kAPIEndpointLatestPath];
   
    NSDictionary *userNameDict = @{@"notification_id" : noti_id
                                   };
    NSError *error;
    //NSLog(@"userNameDict :: %@",userNameDict);
    
    BOOL Network=[self Reachability_To_Chechk_Network];
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
        
        //RR
        if(response2.length>6)
        {
            NSDictionary *jsonObject = [NSJSONSerialization
                                        JSONObjectWithData:returnData
                                        options:NSJSONReadingMutableLeaves
                                        error:nil];
      
            NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
            
            if([str isEqualToString:@"success"])
            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Successfully removed notification", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)otherButtonTitles:nil];
//                [alert show];
                
                NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                [alert show];
                return YES;
            }
            else
            {
                return NO;
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    return NO;
}

#pragma mark - TableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_msg.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"cellIdentifier";
    
    notificationCell *cell = (notificationCell*)[notificationtableview dequeueReusableCellWithIdentifier:cellIdentifier1];  
    
    cell = [[notificationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
 
    NSString *StrDate   = [NSString stringWithFormat:@"%@",[arr_createDate objectAtIndex:indexPath.row]];
    NSString *StrREview = [NSString stringWithFormat:@"%@",[arr_msg objectAtIndex:indexPath.row]];
    
    //NSLog(@"STRDATE :: %@, STRREVIEW :: %@ ",StrREview,StrDate);
    
    cell.reviewlabel.text = StrREview;
    cell.review_Date.text = StrDate;
  
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *str=[NSString stringWithFormat:@"%@",[arr_msg objectAtIndex:indexPath.row]];
  [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"valueKey"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NotificationDetailVC  *rootController =(NotificationDetailVC*)[storyboard instantiateViewControllerWithIdentifier:@"NotificationDetailVC"];
    rootController.notificationlabelA=str;
    [self.navigationController pushViewController:rootController animated:YES];

  //  NotificationDetailVC.h
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deletestr=[NSString stringWithFormat:@"%@",[arrNotification objectAtIndex:indexPath.row]];
   BOOL Flag = [self DeleteNotification:deletestr];
    if(Flag)
    {
        [arrdate removeObjectAtIndex:indexPath.row];                // DAte
        [arr_msg removeObjectAtIndex:indexPath.row];                 // Pdf 
        [notificationtableview reloadData];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    // return UITableViewCellEditingStyleDelete;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return UITableViewCellEditingStyleDelete;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
