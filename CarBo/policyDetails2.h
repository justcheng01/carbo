//
//  policyDetails2.h
//  CarBo
//
//  Created by Shirish Vispute on 19/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_5S (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD_PRO (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)

@interface policyDetails2 : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *status_value;
@property (weak, nonatomic) IBOutlet UILabel *disPremium;
@property (weak, nonatomic) IBOutlet UILabel *limited_time;
@property (weak, nonatomic) IBOutlet UILabel *general_excess;
@property (weak, nonatomic) IBOutlet UILabel *theft_loss;
@property (weak, nonatomic) IBOutlet UILabel *tppd;
@property (weak, nonatomic) IBOutlet UILabel *premium_amountVAL;
@property (strong, nonatomic) IBOutlet UITextView *TPPD_textview;
@property (strong, nonatomic) IBOutlet UITextView *TPPD_textview5;
@property (strong, nonatomic) IBOutlet UILabel *excesslabel;

@property (weak, nonatomic) IBOutlet UILabel *status_value_label;
@property (weak, nonatomic) IBOutlet UILabel *disPremium_label;
@property (weak, nonatomic) IBOutlet UILabel *limited_time_label;
@property (weak, nonatomic) IBOutlet UILabel *general_excess_label;
@property (weak, nonatomic) IBOutlet UILabel *theft_loss_label;
@property (weak, nonatomic) IBOutlet UILabel *tppd_label;
@property (weak, nonatomic) IBOutlet UILabel *premium_amountVAL_label;
@property (weak, nonatomic) IBOutlet UIButton *accept_Btn;
@property (weak, nonatomic) IBOutlet UIButton *decline_Btn;
@end
