//
//  PremiumDetails_SVC.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface PremiumDetails_SVC : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIActionSheetDelegate>
{
    UIView *pView;
    UIView *dView;
    UIButton *cancel_Btn;
    UIButton *Done_Btn;
    UILabel *dateLabel;
    UIDatePicker *datePicker;
    NSMutableArray *textcontaint;
    UILabel *first_heading;
    UILabel *second_heading;
    
}
@property(nonatomic,strong) NSString *strc; 
@property(nonatomic) BOOL Check;
@property(nonatomic,strong) UIImageView *bankReceiptImageview;
@property(nonatomic,strong) UIImageView *ID_CArd_Image;
@property(nonatomic,strong) UIImageView *Driving_lic_image;
@property(nonatomic,strong) UIImageView *Adress_proof_image;
@property(nonatomic,strong) UILabel *address_label;
@property(nonatomic,strong) UILabel *HKID_label;
@property(nonatomic,strong) UILabel *RegMark_label;
@property(nonatomic,strong) UITextView *address_textview;
@property(nonatomic,strong) UITextField *HKID_text;
@property(nonatomic,strong) UITextField *RegMark_text;

@property(nonatomic,strong) UILabel *ID_card_label;
@property(nonatomic,strong) UILabel *driving_label;

@property(nonatomic,strong) UITextField *reg_mark_pre_policy;
@property(nonatomic,strong) UITextField *pre_Insurance;
@property(nonatomic,strong) UITextField *pre_policy_no;
@property(nonatomic,strong) UITextField *email_text;
@property(nonatomic,strong) UITextField *hire_Purchaser;
@property(nonatomic,strong) UILabel *pre_expiry_date_VL;
@property(nonatomic,strong) UILabel *policy_effective_date_VL;
@property(nonatomic,strong) UITextField *reg_mark_current;
@property(nonatomic,strong) UILabel *CAR_info_label;
@property(nonatomic,strong) UILabel *reg_mark_pre_policy_label;
@property(nonatomic,strong) UILabel *reg_mark_current_label;
@property(nonatomic,strong) UILabel *pre_Insurance_lablel;
@property(nonatomic,strong) UILabel *pre_policy_no_lablel;
@property(nonatomic,strong) UILabel *pre_expiry_date_label;
@property(nonatomic,strong) UILabel *policy_effective_date_label;
@property(nonatomic,strong) UILabel *email_label;
@property(nonatomic,strong) UILabel *hire_Purchaser_label;

@end
