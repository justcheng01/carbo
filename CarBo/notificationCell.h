//
//  notificationCell.h
//  CarBo
//
//  Created by Shirish Vispute on 05/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notificationCell : UITableViewCell
{
}
@property(strong,nonatomic) UILabel *heading_Label;
@property(strong,nonatomic) UILabel *backgroundlabel;
@property(strong,nonatomic) UILabel *reviewlabel;
@property(strong,nonatomic) UILabel *review_Date;
@property(strong,nonatomic) UITextField *name_textfield;
@end
