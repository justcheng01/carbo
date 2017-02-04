//
//  carRegistrationCellTableViewCell.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface carRegistrationCell: UITableViewCell<UITextFieldDelegate>
{
    
}
@property(strong,nonatomic) UILabel *heading_Label;
@property(strong,nonatomic) UILabel *name_Label;
@property(strong,nonatomic) UITextField *name_textfield;
@property(strong,nonatomic) UIImageView *logoImageView;
@property(strong,nonatomic) UILabel *backgroundlabel;
@property(strong,nonatomic)UIImageView  *logoDownArrow;
@end
