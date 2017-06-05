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

//Subview External subview for email and mobile number
@property (strong, nonatomic) IBOutlet UIView *externalSubview;
@property (weak, nonatomic) IBOutlet UILabel *email_Label;
@property (weak, nonatomic) IBOutlet UITextField *email_textfield;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobile_textfield;

//New External Subview for fetching mobile number
@property (weak, nonatomic) IBOutlet UILabel      *Nemail_label;
@property (weak, nonatomic) IBOutlet UITextField *N_mobile_text;
@property (weak, nonatomic) IBOutlet UIButton *NcancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *NokBtn;
@property (strong, nonatomic) IBOutlet UIView *N_externalsubview;


-(IBAction)facebookloginButtonClicked:(id)sender;
-(IBAction)loginButtonClicked:(id)sender;
-(IBAction)ForgotPassword:(id)sender;
-(IBAction)RegisterNewUser:(id)sender;
//
// New External View
-(IBAction)mcancelcalled:(id)sender;
-(IBAction)mokcalled:(id)sender;
@end

