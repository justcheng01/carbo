//
//  emailVerfication_code.h
//  CarBo
//
//  Created by Shirish Vispute on 12/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface emailVerfication_code : UIViewController <UITextFieldDelegate>
{

}
@property (weak, nonatomic) IBOutlet UILabel *verifylabel;
@property (weak, nonatomic) IBOutlet UIButton *resendcodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeText;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@end
