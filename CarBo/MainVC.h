//
//  MainVC.h
//  FuelPadi
//
//  Created by Shirish Vispute on 02/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "maincell.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MainVC : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{

}
@property (weak, nonatomic) IBOutlet UIButton *InstantBtn;
@property (weak, nonatomic) IBOutlet UIButton *policyBtn;
@property (weak, nonatomic) IBOutlet UIButton *notificationBtn;

@property (weak, nonatomic) IBOutlet UILabel *InstantLabel;
@property (weak, nonatomic) IBOutlet UILabel *policyLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationCount;
@property (weak, nonatomic) IBOutlet UILabel *policylistCount;


@property(nonatomic,strong) IBOutlet UIView *indicatorview;

@property(nonatomic,strong) UIView *menuView;
@property(nonatomic,strong) UITextField *Kprice_text;

@property(nonatomic,strong) UITextField *Pprice_text;
@property(nonatomic,strong) UITextField *Dprice_text;  
@property(nonatomic,strong) UIView *Pview1; 

@property(strong,nonatomic) UITableView *menu_Button_table;
@property(strong,nonatomic) IBOutlet UIView *sideview;
@property(strong,nonatomic) IBOutlet UIButton *menubtn;




-(IBAction)called_menu_Option :(id)sender;
-(IBAction)calledSelectPolicy:(id)sender;
-(IBAction)calledrenewalpolicy:(id)sender;
-(IBAction)notification:(id)sender;

@end
