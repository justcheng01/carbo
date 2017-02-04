//
//  Select Policy.m
//  CarBo
//
//  Created by Shirish Vispute on 27/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "Select Policy.h"
#import "MainVC.h"
#import "Constant.h"


#import <sys/sysctl.h>


//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface Select_Policy ()
{
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
    UILabel *personName;
    UILabel  *nickName;
    UILabel *Logout;
    UIColor *colour;
    UIView *Pview1; 
}
@end

@implementation Select_Policy
@synthesize Pview1,menu_Button_table,menuView,labeltext,comprehensiveBtn,thirdBtn,compre_label,
third_label;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //    <color name="colorPrimary">#f6a854</color>
    //    <color name="colorDarkPrimary">#f98810</color>  //f98810
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    colour = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    // navigation bar colour: 3319b7
    UIColor *barcolor = [self getUIColorObjectFromHexString:Kmain alpha:1.0];
    self.navigationController.navigationBar.barTintColor = barcolor;    //  self.loginButton.backgroundColor = colour;
    //  self.loginButton.layer.cornerRadius = 10;
    NSString *PolicyDetails=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title =PolicyDetails ;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"logo.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsCompact];
  
    personimage=[[UIImageView alloc]initWithFrame:CGRectMake(40,20,120,105)];
    [personimage setUserInteractionEnabled:YES];
    UIImage *image2=[UIImage imageNamed:@"carbo_icon1024.png"];
    personimage.image=image2;
 
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJumps) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    NSString *NSl=[NSString stringWithFormat:NSLocalizedString(@"Comprehensive Policy", nil) ];
    [compre_label setText:NSl];
    
    NSl = [NSString stringWithFormat:NSLocalizedString(@"Third Party Policy", nil) ];
    [third_label setText:NSl];
    
    NSString     *str = @"你好";
    NSData      *data = [NSKeyedArchiver archivedDataWithRootObject:str];
    NSString *thatStr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //NSLog(@"%@,%@,%@",str,data,thatStr);
    
    NSData *dataenc = [str dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *encodevalue = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    //NSLog(@"encodevalue :: %@",encodevalue);
    
    
     data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
    //NSLog(@"decodevalue:: %@",decodevalue);

    
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    //NSLog(@"Width :: %f",result.width);
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        
//        CGSize result = [[UIScreen mainScreen] bounds].size;
//        
//        if (result.height == 480) {
//            // 3.5 inch display - iPhone 4S and below
//            //NSLog(@"Device is an iPhone 4S or below");
//        }
//        
//        else if (result.height == 568) {
//            // 4 inch display - iPhone 5
//            //NSLog(@"Device is an iPhone 5/S/C");
//        }
//        
//        else if (result.height == 667) {
//            // 4.7 inch display - iPhone 6
//            //NSLog(@"Device is an iPhone 6");
//        }
//        
//        else if (result.height == 736) {
//            // 5.5 inch display - iPhone 6 Plus
//            //NSLog(@"Device is an iPhone 6 Plus");
//        }
//    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

- (NSString *) platformType:(NSString *)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (Verizon)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (Wi-Fi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (Wi-Fi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (China)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (Wi-Fi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G (China)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (Wi-Fi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7\" (Wi-Fi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7\" (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9\" (Wi-Fi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9\" (Cellular)";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([platform isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    if ([platform isEqualToString:@"Watch1,1"])     return @"Apple Watch Series 1 (38mm, S1)";
    if ([platform isEqualToString:@"Watch1,2"])     return @"Apple Watch Series 1 (42mm, S1)";
    if ([platform isEqualToString:@"Watch2,6"])     return @"Apple Watch Series 1 (38mm, S1P)";
    if ([platform isEqualToString:@"Watch2,7"])     return @"Apple Watch Series 1 (42mm, S1P)";
    if ([platform isEqualToString:@"Watch2,3"])     return @"Apple Watch Series 2 (38mm, S2)";
    if ([platform isEqualToString:@"Watch2,4"])     return @"Apple Watch Series 2 (42mm, S2)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

#pragma mark -- Call to car Registration Policy

-(IBAction)call_Comprehensive_policy:(id)sender;
{
   [self performSegueWithIdentifier:@"SPTOCR" sender:self];   
    self.labeltext.text=@"Comprehensive";
   
    NSString *strc=@"Comprehensive";
    
    [[NSUserDefaults standardUserDefaults]setObject:strc forKey:@"Policyselected"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(IBAction)call_thirdParty_policy:(id)sender;
{
    [self performSegueWithIdentifier:@"SPTOCR2" sender:self]; 
    NSString *strc=@"Third Party";
    
    [[NSUserDefaults standardUserDefaults]setObject:strc forKey:@"Policyselected"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    //[[GIDSignIn sharedInstance] signOut];
    lat = [latitude floatValue];
    longi = [longitude floatValue];
    
   
    NSString *str21=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Log"]];
    //NSLog(@"USERID :: %@, LOG :: %@ ",[[NSUserDefaults standardUserDefaults]objectForKey:@"USERID"],str21);
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0);
{
    if(buttonIndex == 0)//OK button pressed
    {
        //NSLog(@"Called 0");
        //do something
    }
    else if(buttonIndex == 1)//Annul button pressed.
    {  //MTOAFS
        // [self performSegueWithIdentifier:@"MTOAFS" sender:self];
        //NSLog(@"Called 1");
        //do something
    }
}

#pragma mark -- Textfield Delegate ---

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField;  
{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if([[segue identifier] isEqualToString:@"SPTOCR"]) 
    {
        
    }
    else if([[segue identifier] isEqualToString:@"SPTOCR2"]) 
    {
        //        MainVC *vc = [segue destinationViewController]; 
    }
    else if([[segue identifier] isEqualToString:@"MTOAUS"]) 
    {
        // MTOAFS
    }
    else if([[segue identifier] isEqualToString:@"MTOAUS"]) 
    {
    }
} 


#pragma mark ----- UITableView Delegate & Datasource Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   

    return 6;
  }

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    //Cell Identifier
    static NSString *simpleIdentifier = @"simpleIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleIdentifier];
    
    UIColor *colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    cell.textLabel.textColor = colour;
    
    if(indexPath.row==0)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImage *pimage = [UIImage imageNamed:@"app_icon.png"];
        [cell.contentView addSubview:personimage];
        cell.backgroundColor=colour;
    }
    
    if(indexPath.row==1)
    {   
        // navigation bar colour: 3319b7
        //cell.textLabel.textColor=colour;
        cell.textLabel.text = @"Home";
    }
    
    if(indexPath.row==2)
    {  
        cell.textLabel.text = @"Policy";
    }
    if(indexPath.row==3)
    {  
        cell.textLabel.text = @"Logout"; 
    }
    if(indexPath.row==4)
    {  
        //  cell.textLabel.text = @"Advertise with us"; 
    }
    if(indexPath.row==5)
    {  
        //cell.textLabel.text = @"Logout"; 
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 180;
    }
    else  if(indexPath.row==8)
    {
        return 100;
    }
    else
    {
        return 50;
    }
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    self.navigationController.navigationBarHidden = NO;
    [tableView removeFromSuperview];
    [self.menuView removeFromSuperview];
    [sublayer removeFromSuperlayer];
    
   }

// MTOAFS   MTOAUS

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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{    self.navigationController.navigationBarHidden = NO;
    [menuView removeFromSuperview];
    [menu_Button_table removeFromSuperview];
    [sublayer removeFromSuperlayer];
    ///TableFlag= NO;
    // [sideview setFrame:CGRectMake(-133, 0, sideview.frame.size.width,sideview.frame.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
        //  [sideview setFrame:CGRectMake(-133, 0, sideview.frame.size.width,sideview.frame.size.height)];
    }];
}

-(void)backJumps
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)called_menu_Option:(id)sender;
{
    self.navigationController.navigationBarHidden = YES;
    menuView = [[UIView alloc]init];
    [menuView setFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
    [menuView setBackgroundColor:[UIColor whiteColor]];
    [menuView setAlpha:0.7];
    //[self.view addSubview:menuView];
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
    
        [UIView animateWithDuration:0.3 animations:^{
        // [self.view bringSubviewToFront:self.menu_Button_table];
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


@end
