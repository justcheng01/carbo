//
//  renewalCell.h
//  CarBo
//
//  Created by Shirish Vispute on 04/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
@class renewalCell;
@protocol RenewalDelegate <NSObject>
-(void)didselectImage:(renewalCell*)renewalCell;
@end


@interface renewalCell : UITableViewCell
{
}
@property(strong,nonatomic) UILabel *heading_Label1;
@property(strong,nonatomic) UILabel *heading_Label;
@property(strong,nonatomic) UILabel *policy_id;
@property(strong,nonatomic) UILabel *policy_id_value;
@property(strong,nonatomic) UILabel *created_Date;
@property(strong,nonatomic) UILabel *created_Date_value;
@property(strong,nonatomic) UILabel *status;
@property(strong,nonatomic) UILabel *policy_type;
@property(strong,nonatomic) UILabel *policy_type_val;
@property(strong,nonatomic) UILabel *vehical_name;
@property(strong,nonatomic) UILabel *regMark_val;
@property(strong,nonatomic) UILabel *regMark_Name;
@property(strong,nonatomic) UIButton *UploadBtn;
@property (nonatomic, weak) id <RenewalDelegate> rendelegate;
@property(strong,nonatomic) UILabel *manufactureLabel;
@property(strong, nonatomic) UILabel *supplementaryDoc;


-(void)calledResubmitmthd:(UIButton*)button;
@end
