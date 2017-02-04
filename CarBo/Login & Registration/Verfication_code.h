//
//  Verfication_code.h
//  FuelPadi
//
//  Created by Shirish Vispute on 18/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Verfication_code : UIViewController<UITextFieldDelegate>
{
}
@property (weak, nonatomic) IBOutlet UILabel *VerifyLabel;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeText;
@property (weak, nonatomic) IBOutlet UIButton *resendBttn;
//-(IBAction)backcalled:(id)sender;
-(IBAction)Verify_code:(id)sender;
@end
