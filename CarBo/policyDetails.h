//
//  policyDetails.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface policyDetails : UIViewController
{

}
//Can Be used these parameter to modifiy the content.
@property (weak, nonatomic) IBOutlet UILabel *policyNameField;
@property (weak, nonatomic) IBOutlet UILabel *discountedPremiumField;
@property (weak, nonatomic) IBOutlet UILabel *LTOField;
@property (weak, nonatomic) IBOutlet UILabel *generalExcessField;
@property (weak, nonatomic) IBOutlet UILabel *TLEField;
@property (weak, nonatomic) IBOutlet UILabel *TPPDField;
@property (weak, nonatomic) IBOutlet UITextView *TPPD_textview;

////OK Btn
@property (weak, nonatomic) IBOutlet UIButton *OkBtn;
-(IBAction)called_OkBtn:(UIButton*)Btn;
@end
