//
//  userProfile.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userProfile : UIViewController<UITextFieldDelegate>
{
    IBOutlet UIButton *updateBtn;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *emailtext;
@property (weak, nonatomic) IBOutlet UITextField *nametext;
@property (weak, nonatomic) IBOutlet UITextField *phonetext;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageview;

@end
