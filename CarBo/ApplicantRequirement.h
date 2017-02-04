//
//  ApplicantRequirement.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
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

@interface ApplicantRequirement : UIViewController<UIScrollViewDelegate>
{
  //  UImuta
    UITextField *textf1;
    __weak IBOutlet UITextView *textView1;
    UITextView *textview1;
    
   IBOutlet UILabel *labelfield;
   IBOutlet UILabel *label1;
   UILabel *titlelabel;
    UILabel *LastLabel;
   UITextView *textview2;
   IBOutlet UIScrollView *scrollview;
    UIButton *continueBtn;
    UISwitch *switchbtn;
    
}
@property(strong,nonatomic) NSAttributedString *tfAttributedString1;
@property(strong,nonatomic) NSAttributedString *tfAttributedString2;
@end
