//
//  PremiumDetails_FVC.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PremiumDetails_FVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{

    UIScrollView *scrollview;

}

@property (weak, nonatomic) IBOutlet UILabel *premium_label;
@property (weak, nonatomic) IBOutlet UILabel *acount_name_text;
@property (weak, nonatomic) IBOutlet UILabel *account_no_text;

@property (weak,nonatomic) IBOutlet UILabel *feesAmount;
@property (weak, nonatomic) IBOutlet UILabel *bank_name_text;
@property (weak, nonatomic) IBOutlet UIImageView *payment_receipt;
@property (strong, nonatomic) UITableView *banklistTableview;
@property (strong, nonatomic) IBOutlet UIButton *continueBtn
;
@property (strong, nonatomic) IBOutlet UILabel *heading;
@property (strong, nonatomic) IBOutlet UILabel *banklabel;
@property (strong, nonatomic) IBOutlet UILabel *accountlabel;
@property (strong, nonatomic) IBOutlet UILabel *companylabel;
@property (strong, nonatomic) IBOutlet UILabel *premiumlabel;
@property (strong, nonatomic) IBOutlet UILabel *uploadlabel;
@property(strong,nonatomic) UIActivityIndicatorView *indicator;
@property(strong,nonatomic) UIActivityIndicatorView *indicatorrenewal;

@end
