//
//  car_imageVC.h
//  CarBo
//
//  Created by Shirish Vispute on 23/09/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface car_imageVC : UIViewController<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) NSString *policyid;
@property (strong, nonatomic) IBOutlet UIImageView *carimage;
@property (strong, nonatomic) IBOutlet UIButton *uploadBtn;
@property(strong,nonatomic) UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UILabel *UploadLabel;
@property (strong, nonatomic) IBOutlet UILabel *supPicture;

-(IBAction)uploadImage:(id)sender;
@end
