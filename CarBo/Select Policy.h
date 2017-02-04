//
//  Select Policy.h
//  CarBo
//
//  Created by Shirish Vispute on 27/07/16.
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

@interface Select_Policy : UIViewController
{

}
@property(strong,nonatomic) UILabel *labeltext;
@property(strong,nonatomic) UITableView *menu_Button_table;
@property(nonatomic,strong) UIView *menuView;
@property(nonatomic,strong) UIView *Pview1;
@property(nonatomic,strong) IBOutlet UIButton *comprehensiveBtn;
@property(nonatomic, strong) IBOutlet UIButton *thirdBtn;
@property(nonatomic, weak) IBOutlet UILabel *compre_label;
@property(nonatomic, weak) IBOutlet UILabel *third_label;

-(IBAction)call_Comprehensive_policy:(id)sender;
-(IBAction)call_thirdParty_policy:(id)sender;

@end
