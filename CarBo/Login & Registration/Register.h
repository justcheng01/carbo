//
//  Register.h
//  FuelPadi
//
//  Created by Shirish Vispute on 15/06/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import <GoogleSignIn/GoogleSignIn.h>

@interface Register : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>
{
    IBOutlet UITextField *UserName;
    
    IBOutlet UITextField *Name;
    
    IBOutlet UITextField *email;
    
    IBOutlet UITextField *phone;
    
    IBOutlet UITextField *password;
    
    IBOutlet UITextField *confirmpassword;
    
    IBOutlet UIButton *signUpBtn;
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    UILabel *locationLabel;
    NSString *latitude ;
    NSString *longitude;
    
    float lat;
    float longi;
}
-(IBAction)back:(UIButton*)sender;
-(IBAction)registeruser:(id)sender;
@end
