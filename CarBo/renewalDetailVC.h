//
//  renewalDetailVC.h
//  CarBo
//
//  Created by Shirish Vispute on 03/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface renewalDetailVC : UIViewController<UIDocumentInteractionControllerDelegate,UIGestureRecognizerDelegate>
{

}
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (weak, nonatomic) IBOutlet UILabel *policy_name;

@property (weak, nonatomic) IBOutlet UILabel *expiryDateValue;
@property (weak, nonatomic) IBOutlet UILabel *PolicyNoValue;
@property (weak, nonatomic) IBOutlet UILabel *FeesValue;


@property (weak, nonatomic) IBOutlet UIButton *pdfbtn;
@property (strong, nonatomic) IBOutlet UIButton *renewalBtn;

@property (strong, nonatomic) IBOutlet UILabel *expiry_label;
@property (strong, nonatomic) IBOutlet UILabel *policy_label;
@property (strong, nonatomic) IBOutlet UILabel *premium_label;

-(IBAction)Call_To_PDF_Viewer:(id)sender;
-(IBAction)CAll_To_PremiumDetails:(id)sender;
@end
