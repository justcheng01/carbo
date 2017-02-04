//
//  ForgotPassword.h
//  FuelPadi
//
//  Created by Shirish Vispute on 18/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassword : UIViewController<UITextFieldDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITextField *emailIDtext;
@property (weak, nonatomic) IBOutlet UIButton *process_emailID;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
-(IBAction)backcalled:(id)sender;

@end
