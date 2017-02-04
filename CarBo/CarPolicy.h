//
//  CarPolicy.h
//  CarBo
//
//  Created by Shirish Vispute on 08/11/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarPolicy : UIViewController<UIActionSheetDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    UIView *pView;
    UIView *dView;
    UIButton *cancel_Btn;
    UIButton *Done_Btn;
    UILabel *dateLabel;
    UIDatePicker *datePicker;
    NSMutableArray *textcontaint;
}
@property (weak, nonatomic) IBOutlet UILabel *UVSLabel;
@property (weak, nonatomic) IBOutlet UILabel *ORLabel;

@property (weak, nonatomic) IBOutlet UILabel *TitleLabelIVI;

@property(strong,nonatomic)IBOutlet UILabel *classlabel;
@property(strong,nonatomic)IBOutlet UILabel *makelable;
@property(strong,nonatomic)IBOutlet UILabel *modellabel;
@property(strong,nonatomic)IBOutlet UILabel *yearlabel;
@property(strong,nonatomic)IBOutlet UILabel *enginelabel;
@property(strong,nonatomic)IBOutlet UILabel *bodylabel;


// Vehicle Information
@property(strong,nonatomic)IBOutlet UILabel *classval;
@property(strong,nonatomic)IBOutlet UITextField *makeText;
@property(strong,nonatomic)IBOutlet UITextField *modelText;
@property(strong,nonatomic)IBOutlet UITextField *yearText;
@property(strong,nonatomic)IBOutlet UITextField *engineCapacityText;
@property(strong,nonatomic)IBOutlet UILabel *bodytypeVal;

///Vehicle sheet Image
@property(strong,nonatomic)IBOutlet UIImageView *carimageview;

//Next Btn
@property (weak, nonatomic) IBOutlet UIButton *Next;

-(IBAction)NextBtn:(id)sender;

//+ (NSString *)extractNumberFromText:(NSString *)text;


@end
