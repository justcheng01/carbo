//
//  ViewController.h
//  FuelPadi
//
//  Created by Shirish Vispute on 09/06/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface LoginVC : UIViewController <UITextFieldDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UITextField *Name;
    __weak IBOutlet UITextField *emailId;
    __weak IBOutlet UITextField *Password;
    __weak IBOutlet UIButton *Login;
 }

@property (weak, nonatomic) IBOutlet UIButton *FacebookCustom;
@property (strong, nonatomic) IBOutlet UIButton *fogetpasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton *signUp;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (atomic)  UIActivityIndicatorView *indicator;

-(IBAction)facebookloginButtonClicked:(id)sender;
-(IBAction)loginButtonClicked:(id)sender;
-(IBAction)ForgotPassword:(id)sender;
-(IBAction)RegisterNewUser:(id)sender;

@end

