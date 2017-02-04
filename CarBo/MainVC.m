
//  Created by Shirish Vispute on 02/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

//#import <GoogleMapsM4B/GoogleMaps.h>
#import "MainVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LoginVC.h"
#import "notificationListVC.h"
#import "Reachability.h"
#import "Constant.h"

//carbo car insurance 汽車保險

@interface MainVC()
{
   NSMutableArray *arr_policy_id;
   NSMutableArray *arr_notification;
  
   UILabel *locationLabel;
   NSString *latitude ;
   NSString *longitude;
   NSString *deslatitude ;
   NSString *deslongitude;
   float lat;
   float longi;
   
   NSMutableArray *FuelstationID;
   NSMutableArray *FuelstationName;
   NSMutableArray *fuelStationLat;
   NSMutableArray *fuelstationLong;
      
   UIView *pView;
   UIButton *cancelBtn;
   UIButton *navigateBtn;
   UIButton *updateBtn;
   UILabel *nameLabel; 
   UILabel *fuelstationName; 
   UILabel *kerosene_Price;
   UILabel *petrol_Price;
   UILabel *diesel_Price; 
   UILabel *Kprice;
   UILabel *Pprice;
   UILabel *Dprice; 
   NSString *fuelStation_name; 

    
   CALayer *sublayer;
   CALayer *sublayer3 ;
   CALayer *sublayer2;
    
   UIImageView *menuimage;
   UIImageView *personimage;
   UILabel  *personName;
   UILabel  *nickName;
   UILabel  *Logout;
   UIColor  *colour;
   UIView   *Pview1;

   NSString *notiStr;
   NSString *renewalStr;
   UIColor  *colourgreen;
    
    UITextField *textfield;
}

@end

@implementation MainVC

@synthesize Kprice_text,Dprice_text,Pprice_text,Pview1,menu_Button_table,sideview,menuView,policyBtn,notificationBtn,indicatorview,InstantBtn,InstantLabel
,policyLabel,notificationLabel,notificationCount,policylistCount;

#pragma mark -- View Cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
        [self.view setUserInteractionEnabled:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
   /// 16BC7B  2879bc
    colour = [self getUIColorObjectFromHexString:Klightcolor alpha:1.0]; // navigation bar colour: 3319b7
    colourgreen = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0]; // navigation
    
    UIColor *barcolor = [self getUIColorObjectFromHexString:Kmain alpha:1.0];
    
    self.navigationController.navigationBar.barTintColor = barcolor;
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"CarBo", nil)];
    
    self.navigationItem.title = Home;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"logo.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsCompact];
    
    menu_Button_table=[[UITableView alloc]init];
    self.menu_Button_table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.menu_Button_table.frame = CGRectMake(-10,0, 150, [[UIScreen mainScreen] bounds].size.height);
    [menu_Button_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    menu_Button_table.scrollEnabled = YES;
    [menu_Button_table setBackgroundColor:colourgreen];
    menu_Button_table.tag=1011;
    menu_Button_table.dataSource = self;
    menu_Button_table.delegate=self;
  
    personimage=[[UIImageView alloc]initWithFrame:CGRectMake(40,20,80,30)];
    [personimage setUserInteractionEnabled:YES];
    UIImage *image2=[UIImage imageNamed:@"carboIcon2.png"];

    personimage.image=image2;
   
    UIButton *menuBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 44.0f)];
    [menuBtn setImage:[UIImage imageNamed:@"mobile-nav.png"]  forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(called_menu_Option:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
  
    NSString *Phone=[NSString stringWithFormat:NSLocalizedString(@"Phone", nil)];
    
    NSString *NSl=[NSString stringWithFormat:NSLocalizedString(@"Instant Quote", nil) ];
    [InstantLabel setText:NSl];
    
    NSl=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil) ];
    [policyLabel setText:NSl];
    
    NSl = [NSString stringWithFormat:NSLocalizedString(@"Notifications", nil) ];
    [notificationLabel setText:NSl];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.view setUserInteractionEnabled:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [menuView removeFromSuperview];
    NSString *str21=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Log"]];
    
    //NSLog(@"USERID :: %@, LOG :: %@ ",[[NSUserDefaults standardUserDefaults]objectForKey:@"USERID"],str21);
 
    [policylistCount setTextColor:colourgreen];
    [policylistCount setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"circle.png"]]];
  
    [notificationCount setTextColor:colourgreen];
    [notificationCount setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"circle.png"]]];

    NSString *deviceID=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"DeviceToken"]];
    textfield = [[UITextField alloc]initWithFrame:CGRectMake(0,60,[UIScreen mainScreen].bounds.size.width,40)];
    [textfield setText:deviceID];
    textfield.delegate=self;
    
    BOOL Bool = YES;  ; //=  [self needsUpdate];        //Call To Check The Current Version
    
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
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/%@?mt=8", appID]];
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Carbo update available" message:@"Please update the latest version to continue" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [[UIApplication sharedApplication] openURL:url];
                                                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [self.view setUserInteractionEnabled:YES];
    [self NotificationDetails];
    [self Renewal_list];
}

#pragma  mark --- Check Version with the Current Version Available on App Store

-(BOOL) needsUpdate    //Check Version with the Current Version Available on App Store
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

#pragma mark -- Textfield Delegate ---

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField;  
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
{
    if(buttonIndex == 0)//OK button pressed
    {
        //NSLog(@"Called 0");
        //do something
    }
    else if(buttonIndex == 1)//Annul button pressed.
    {
        //NSLog(@"Called 1");
        //do something
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0);
{
    if(buttonIndex == 0)//OK button pressed
    {
        //NSLog(@"Called 0");
        //do something
    }
    else if(buttonIndex == 1)//Annul button pressed.
    {
        //NSLog(@"Called 1");
        //do something
    }
}

#pragma mark -- Call to Segue Method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"MTOSP"]) 
    {
    }
    else if ([[segue identifier] isEqualToString:@"MTOLOG"])
    {
    }
    else if ([[segue identifier] isEqualToString:@"MTOLO"])
    {
    }
    else if([[segue identifier] isEqualToString:@"MTONL"]) 
    {
    }
} 

#pragma mark   -----   UITableView Delegate & Datasource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
        return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    ///Custom cell
    static NSString *cellIdentifier1 = @"simpleIdentifier1";
    maincell *cell = (maincell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    
    cell = [[maincell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];

    //Cell Default
    static NSString *cellIdentifier = @"simpleIdentifier";
    UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cells = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cells.selectionStyle = UITableViewCellSelectionStyleNone;

    // 16BC7B
    UIColor *colour1 = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
     colour = [self getUIColorObjectFromHexString:Klightcolor alpha:1.0];
    /// UIColor *colour2 = [self getUIColorObjectFromHexString:@"#f9f9f9" alpha:1.0];
     cell.textLabel.textColor = colour;
 
    CGSize is;
    is.height=25;
    is.width=25;
        
   if(indexPath.row==0)
    {
        cells.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage *pimage   = [UIImage imageNamed:@"carboIcon2.png"];
        personimage.image = pimage;
        [cells.contentView addSubview:personimage];
        cells.backgroundColor=colour1;
        return cells;
    }
   if(indexPath.row==1)
    {
           // navigation bar colour: 3319b7
           //cell.textLabel.textColor=colour;
         UIImage *image1=[[UIImage alloc]init];
         image1 = [UIImage imageNamed:@"drawer_home.png"];

         UIImage *imagp =[self imageResize:image1 andResizeTo:is];
        cell.iconimageview.image=imagp;
        NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Home", nil)];
        cell.name_Label.text = Home;
    }
    if(indexPath.row==2)
    {
          UIImage *image1=[[UIImage alloc]init];
          image1 = [UIImage imageNamed:@"drawer_user.png"];
          UIImage *imagp =[self imageResize:image1 andResizeTo:is];
         
        cell.iconimageview.image=imagp;
        
        NSString *Profile_Info=[NSString stringWithFormat:NSLocalizedString(@"Profile Info", nil)];
        
        cell.name_Label.text = Profile_Info;
        cell.backgroundColor=colour1;
    }
    
    if(indexPath.row==3)
    {
            UIImage *image1=[[UIImage alloc]init];
            image1 = [UIImage imageNamed:@"drawer_noti_new.png"];
            UIImage *imagp =[self imageResize:image1 andResizeTo:is];
            cell.iconimageview.image=imagp;
        
        NSString *Notification=[NSString stringWithFormat:NSLocalizedString(@"Notification", nil)];
        
            cell.name_Label.text =Notification;
        }
if(indexPath.row==4)
   {  
            UIImage *image1=[[UIImage alloc]init];
            image1 = [UIImage imageNamed:@"aboutus.png"];
            
            UIImage *imagp =[self imageResize:image1 andResizeTo:is];
            cell.iconimageview.image=imagp;
            NSString *Logoutt=[NSString stringWithFormat:NSLocalizedString(@"About us", nil)];
            cell.name_Label.text = Logoutt;
            cell.backgroundColor=colour1;
    }
 if(indexPath.row==5)
        {  
            UIImage *image1=[[UIImage alloc]init];
            image1 = [UIImage imageNamed:@"drawer_logout.png"];
            
            UIImage *imagp =[self imageResize:image1 andResizeTo:is];
            cell.iconimageview.image=imagp;
            NSString *Logoutt=[NSString stringWithFormat:NSLocalizedString(@"Logout", nil)];
            cell.name_Label.text = Logoutt;
            cell.backgroundColor=colour1;
        }
    
    cell.backgroundColor=colour1;
    
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row==0)
     {
       return 70;
     }
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    self.navigationController.navigationBarHidden = NO;
    [tableView removeFromSuperview];
    [self.menuView removeFromSuperview];
    [sublayer removeFromSuperlayer];
    
    if(indexPath.row == 1)
    {
        //NSLog(@"Home");
    }
    else if(indexPath.row == 2)
    {
       [self performSegueWithIdentifier:@"MTOUP" sender:self];
        //NSLog(@"Profile");
    }
    else if(indexPath.row == 3)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        notificationListVC *rootController=(notificationListVC*)[storyboard instantiateViewControllerWithIdentifier:@"notificationListVC"];
        [self.navigationController pushViewController:rootController animated:YES];
        //NSLog(@"Donate");
    }
    else if(indexPath.row == 4)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.carbo.com.hk"]];
    }
    else if(indexPath.row==5)
    {  
        [[FBSDKLoginManager new] logOut];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Log"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        //  Login
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginVC *rootController=(LoginVC*)[storyboard instantiateViewControllerWithIdentifier:@"Login"];
        [self.navigationController pushViewController:rootController animated:YES];
        //NSLog(@"Advertise with US");
    }
}


-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.navigationController.navigationBarHidden = NO;
    [menuView removeFromSuperview];
    [menu_Button_table removeFromSuperview];
    [sublayer removeFromSuperlayer];

    [UIView animateWithDuration:0.3 animations:^{
    }];
}

#pragma  mark -- Methods

-(IBAction)calledSelectPolicy:(id)sender;
{
    [self.view setUserInteractionEnabled:NO];
    [self performSegueWithIdentifier:@"MTOSP" sender:self];   
}

-(IBAction)notification:(id)sender;
{
     [self.view setUserInteractionEnabled:NO];
  [self performSegueWithIdentifier:@"MTONO" sender:self];  
}
-(IBAction)calledrenewalpolicy:(id)sender;
{
  [self.view setUserInteractionEnabled:NO];
  [self performSegueWithIdentifier:@"MTOR" sender:self];  
}

-(IBAction)called_menu_Option:(id)sender;
{
    self.navigationController.navigationBarHidden = YES;
    menuView = [[UIView alloc]init];
    [menuView setFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
    [menuView setBackgroundColor:[UIColor whiteColor]];
    [menuView setAlpha:0.7];
    [menuView setUserInteractionEnabled:YES];
    [self.view addSubview:menuView];
    
    [self.view addSubview:menu_Button_table];
    [menu_Button_table reloadData];
    
    sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor whiteColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 5);
    sublayer.shadowRadius = 2.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 1.0;
    sublayer.frame = CGRectMake(menu_Button_table.frame.size.width-10,-10 ,2,menu_Button_table.frame.size.height+10);

    [UIView animateWithDuration:3 animations:^{
    }];
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


#pragma  mark --- Get  Notification Count  &  Policy List Count

-(void)NotificationDetails
{
    NSString *myRequestString = [NSString stringWithFormat:@"%@getNotifications.php",kAPIEndpointLatestPath];
 
    NSString *struserid = [[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
   
    NSDictionary *userNameDict = @{@"user_id" : struserid
                                   };
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
    //NSLog(@"Postdata to server :: %@",response2);
   
        NSString *str;
        NSDictionary *jsonObject;
        NSArray *arr;
        NSString *strm;
        
 if(response2.length>0)
        {
          jsonObject = [NSJSONSerialization
                         JSONObjectWithData:returnData
                         options:NSJSONReadingMutableLeaves
                         error:nil];
          
          arr=[[NSArray alloc]initWithArray:[jsonObject valueForKey:@"result"]];
            
          str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
            
          strm = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
        
          arr_notification = [[NSMutableArray alloc]init];
         
       if([str isEqualToString:@"Success"])
          {
                for (int i=0;i<arr.count;i++) 
                {
                    NSDictionary *dictmsg = [[NSDictionary alloc]initWithDictionary:[arr objectAtIndex:i]];
                    str = [NSString stringWithFormat:@"%@",[dictmsg valueForKey:@"createDate"]];
                    [arr_notification addObject:str];
                }
                NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)[arr_notification count]];
                [notificationCount setText:count];
            }
          else
            {  }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            //  [alert show];
        }
      }
 else
 {
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
     //[alert show];
 }
}



-(void)Renewal_list             //   Get Policy List Count
{
    
BOOL Network=[self Reachability_To_Chechk_Network];

if(Network)
    {
    
        NSString *myRequestString = [NSString stringWithFormat:@"%@getpolicylist.php",kAPIEndpointLatestPath];
        
        NSString *struserid=[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"];
        //NSString *str1=@"20";
        NSDictionary *userNameDict = @{@"user_id" : struserid};
        NSError  *error;
      //  //NSLog(@"userNameDict REviewcalled :: %@",userNameDict);
        //NSLog(@"userNameDict :: %@, myRequestString :: %@",userNameDict,myRequestString);

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
     //   //NSLog(@"Postdata to server REnewal List:: %@",response2);
        
 if(response2.length>0)
    {
      NSDictionary *jsonObject = [NSJSONSerialization
                                    JSONObjectWithData:returnData
                                    options:NSJSONReadingMutableLeaves
                                    error:nil];
        NSString *str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_code"]];
        
       if([str isEqualToString:@"Fail"])
        {
            
        }
        else
        {
            NSArray *arr=[[NSArray alloc]initWithArray:[jsonObject valueForKey:@"result"]];
            
            arr_policy_id   = [[NSMutableArray alloc]init];
                      
            for (int i=0;i<arr.count; i++) 
            {
                NSDictionary *dict=[[NSDictionary alloc]initWithDictionary:[arr objectAtIndex:i]];
                
                NSString *strdate = [NSString stringWithFormat:@"%@",[dict valueForKey:@"createDate"]];
                
                NSString *strpolicyid = [NSString stringWithFormat:@"%@",[dict valueForKey:@"policy_id"]];
                
               [arr_policy_id addObject:strpolicyid];
            }
            NSString *count=[NSString stringWithFormat:@"%lu",(unsigned long)[arr_policy_id count]];
            [policylistCount setText:count];
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


