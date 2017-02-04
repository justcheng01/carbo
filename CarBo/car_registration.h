//
//  car_registration.h
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Camera.h"

@interface car_registration : UIViewController<UITableViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIView *pView;
    UIView *dView;
    UIButton *cancel_Btn;
    UIButton *Done_Btn;
    UILabel *dateLabel;
    UIDatePicker *datePicker;
    NSMutableArray *textcontaint;
}

@property(strong,nonatomic) NSString *classvalF;
@property(strong,nonatomic) NSString *bodytypeValF;
@property(strong,nonatomic) NSString *makeTextF;
@property(strong,nonatomic) NSString *modelTextF;
@property(strong,nonatomic) NSString *yearTextF;
@property(strong,nonatomic) NSString *engineCapacityTextF;
@property(strong,nonatomic) NSString *SimageFlag;
@property(strong,nonatomic)UIImageView *imageviewF;

@property(strong,nonatomic)UITableView *carTableview;
@property(strong,nonatomic)UIImageView *imageview;
+ (NSString *)extractNumberFromText:(NSString *)text;

@end
