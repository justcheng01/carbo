//
//  changePassword.h
//  FuelPadi
//
//  Created by Shirish Vispute on 19/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePassword : UIViewController<UITextFieldDelegate>
{

}
@property (weak, nonatomic) IBOutlet UIButton *submit_Password;
@property (weak, nonatomic) IBOutlet UITextField *passwordtext;
@property (weak, nonatomic) IBOutlet UITextField *confirmpasswordtext;
-(IBAction)backcalled:(id)sender;

-(IBAction)Submit_Password:(id)sender;
@end
