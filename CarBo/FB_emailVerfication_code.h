//
//  FB_emailVerfication_code.h
//  CarBo
//
//  Created by Dinesh on 17/03/17.
//  Copyright © 2017 Shirish Vispute. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FB_emailVerfication_code : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *verify_Label;
@property (weak, nonatomic) IBOutlet UITextField *verify_code_text;
@property (weak, nonatomic) IBOutlet UIButton *resend_code_btn;
@property (weak, nonatomic) IBOutlet UIButton *Verify_Btn;

@end
