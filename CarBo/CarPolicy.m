//
//  CarPolicy.m
//  CarBo
//
//  Created by Shirish Vispute on 08/11/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "CarPolicy.h"
#import "car_registration.h"
#import "AlbumClass.h"
#import "Constant.h"
#define MAXLENGTH 4

@interface CarPolicy ()
{
    BOOL ImageFlag;
    NSString *NSSelectoption;
    NSString *NSCancel;
    UIColor *colourgreen;
}
@end

@implementation CarPolicy

@synthesize classval,bodytypeVal,makeText,modelText,yearText,engineCapacityText,carimageview,Next,classlabel,makelable,modellabel,yearlabel,enginelabel,bodylabel,TitleLabelIVI,ORLabel,UVSLabel;

-(void)viewDidLoad 
{
    [super viewDidLoad];
    //NSLog(@"Called Car Policy");
    
    NSSelectoption = [NSString stringWithFormat:NSLocalizedString(@"Select Option", nil)];
    NSCancel = [NSString stringWithFormat:NSLocalizedString(@"Cancel", nil)];
    
    self.navigationItem.title = NSLocalizedString(@"Quotation Form", nil);
    
     colourgreen = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    
    TitleLabelIVI.text=NSLocalizedString(@"Insured Vehicle Information", nil);
    [TitleLabelIVI setTextColor:colourgreen];
    
    UVSLabel.text=NSLocalizedString(@"", nil);
    
    NSString *NSLOR = [NSString stringWithFormat:NSLocalizedString(@"OR", nil)];
    NSString *ORS=[NSString stringWithFormat:@"--------- %@ ---------",NSLOR];
    ORLabel.text = ORS; 
    
    UVSLabel.text=NSLocalizedString(@"Upload Vehicle Sheet", nil); 
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
  //  UIColor *colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    
    /// Labels  all
    [Next setTitle:NSLocalizedString(@"NEXT", nil) forState:UIControlStateNormal];
    [classlabel setText:NSLocalizedString(@"Class", nil)];
    [makelable setText:NSLocalizedString(@"Make", nil)];
    [modellabel setText:NSLocalizedString(@"Model", nil)];
    [yearlabel setText:NSLocalizedString(@"Year of Manufacture", nil)];
    [enginelabel setText:NSLocalizedString(@"Engine Capacity", nil)];
    [bodylabel setText:NSLocalizedString(@"Body Type", nil)];
        
    [bodytypeVal setText:@"Convertible"];
    [classval setText:@"Private Car"];
    
    [makeText setPlaceholder:NSLocalizedString(@"Honda", nil)];
    [modelText setPlaceholder:NSLocalizedString(@"Beat", nil)];
    [yearText setPlaceholder:NSLocalizedString(@"2013", nil)];
    [engineCapacityText setPlaceholder:NSLocalizedString(@"300", nil)];
    // ,carimageview
    
    makeText.delegate=self;
    modelText.delegate=self;
    yearText.delegate=self;
    engineCapacityText.delegate=self;
    
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBodyType:)];
    tapGesture4.delegate=self;
    tapGesture4.numberOfTapsRequired=1;
    [bodytypeVal addGestureRecognizer:tapGesture4];
    
    UITapGestureRecognizer *tapGesture6=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClass:)];
    tapGesture6.delegate=self;
    tapGesture6.numberOfTapsRequired=1;
    [classval addGestureRecognizer:tapGesture6];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    tapGesture.delegate=self;
    tapGesture.numberOfTapsRequired=1;
    [carimageview addGestureRecognizer:tapGesture];

}


-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    //self.navigationItem.title = Home;
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)selectImage:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
    popup.tag = 1;
    [popup showInView:self.view];
}

-(void)selectBodyType:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSSelectoption delegate:self cancelButtonTitle:NSCancel destructiveButtonTitle:nil otherButtonTitles:@"Convertible",
                            @"HatchBack",
                            @"Saloon",
                            @"Sports",
                            @"Station Wagon",
                            nil];
    popup.tag = 3;
    [popup showInView:self.view];
}

-(IBAction)selectClass:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *NSLPC = [NSString stringWithFormat:NSLocalizedString(@"Private Car", nil)];
    
    NSString *NSLV = [NSString stringWithFormat:NSLocalizedString(@"Van", nil)];
    
    NSString *NSLMC = [NSString stringWithFormat:NSLocalizedString(@"Motorcycle", nil)];
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSSelectoption delegate:self cancelButtonTitle:NSCancel destructiveButtonTitle:nil otherButtonTitles:NSLPC,NSLV,NSLMC,nil];
    popup.tag = 4;
    [popup showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    id sender;
    if(popup.tag == 1)
    {
        switch (popup.tag) {
            case 1: {
                switch (buttonIndex) {
                    case 0:
                        [self selectImageFromGallary:sender];
                        break;
                    case 1:
                        [self shootNow:sender];
                        break;
                    default:
                        break;
                }
                break;
            }
            default:
                break;
        }
    }
   else if(popup.tag==3)
    {
      switch (buttonIndex)
        {
            case 0:
                bodytypeVal.text=@"Convertible";
                break;
            case 1:
                bodytypeVal.text=@"HatchBack";
                break;
            case 2:
                bodytypeVal.text=@"Saloon";
                break;
            case 3:
                bodytypeVal.text=@"Sports";
                break;
            case 4:
                bodytypeVal.text=@"Station Wagon";
                break;
            default:
                break;
        }
    }
    else if(popup.tag == 4)
    {
        NSString *NSLPC = [NSString stringWithFormat:NSLocalizedString(@"Private Car", nil)];
        
        NSString *NSLV = [NSString stringWithFormat:NSLocalizedString(@"Van", nil)];
        
        NSString *NSLMC = [NSString stringWithFormat:NSLocalizedString(@"Motorcycle", nil)];
        
        
        switch (buttonIndex) {
            case 0:
                classval.text=NSLPC;
                break;
            case 1:
                classval.text=NSLV;
                break;
            case 2:
                classval.text=NSLMC;
                break;
                
            default:
                break;
        }
    }

}



-(IBAction)selectImageFromGallary:(id)sender
{
    UIImagePickerController *pickerController = [AlbumClass imagePickerControllerWithDelegate:self];
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)shootNow:(id)sender
{
    //    objCreative.photoView.image = nil;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}



#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *photo;
    photo =  [info objectForKey:UIImagePickerControllerOriginalImage]; //[AlbumClass imageWithMediaInfo:info];
    
    // carinfoImage.image = photo;
    //    _photoView.image = [AlbumClass imageWithMediaInfo:info];
    
    ImageFlag=YES;
    
    self.carimageview.image = photo;
    
    ImageFlag = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //Do not delete this block
    [UIView animateWithDuration:50.0
                     animations:^{
                         
                         self.navigationController.navigationBarHidden = NO;
                         self.carimageview.image = photo;
                         
                         ImageFlag = YES;
                         
                     } completion:^(BOOL finished) {
                         
                         if ([UIScreen mainScreen].bounds.size.height == 480)
                         {
                         }
                         //                         [pickerView removeFromSuperView];
                     }];
}

-(IBAction)NextBtn:(id)sender;
{
 if(ImageFlag)
    {
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      car_registration *rootController =(car_registration*)[storyboard instantiateViewControllerWithIdentifier:@"car_registration"];
      [self.navigationController pushViewController:rootController animated:YES];
        rootController.classvalF = classval.text;
        rootController.makeTextF=makeText.text;
        rootController.modelTextF=modelText.text;
        rootController.yearTextF=yearText.text;
        rootController.engineCapacityTextF=engineCapacityText.text;  
        rootController.bodytypeValF=bodytypeVal.text; 
        rootController.SimageFlag=@"YES";
        
        UIImage *img = carimageview.image;
        //NSLog(@"Img Lemgth ");
        rootController.imageviewF=[[UIImageView alloc]init];
        rootController.imageviewF.image=img;
    }
    else if(makeText.text.length>0&&
             modelText.text.length>0&&
             yearText.text.length>0&&
             engineCapacityText.text.length>0)
    {
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      car_registration *rootController =(car_registration*)[storyboard instantiateViewControllerWithIdentifier:@"car_registration"];
      [self.navigationController pushViewController:rootController animated:YES];
        
        rootController.classvalF = classval.text;
        rootController.makeTextF=makeText.text;
        rootController.modelTextF=modelText.text;
        rootController.yearTextF=yearText.text;
        rootController.engineCapacityTextF=engineCapacityText.text;  
        rootController.bodytypeValF=bodytypeVal.text; 
        rootController.imageviewF=[[UIImageView alloc]init];
        rootController.SimageFlag=@"NO";
        
        UIImage *img = carimageview.image;
        //NSLog(@"Img Lemgth ");
        rootController.imageviewF.image=img;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Mandatory Fields", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:nil message:@"Enter complete Car registration information OR Select Vehicle Sheet Photo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
    }
}


#pragma mark -- TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [makeText resignFirstResponder];
    [modelText resignFirstResponder];
    [yearText resignFirstResponder];
    [engineCapacityText resignFirstResponder];   
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==1334)
    {
        int length = [textField.text length] ;
        if (length >= MAXLENGTH && ![string isEqualToString:@""]) {
            textField.text = [textField.text substringToIndex:MAXLENGTH];
            return NO;
        }
    }
    return YES;
}


#pragma mark -- Touches & PrepareForSegue
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [makeText resignFirstResponder];
    [modelText resignFirstResponder];
    [yearText resignFirstResponder];
    [engineCapacityText resignFirstResponder];   
    
}

-(void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


#pragma mark - colour Objects from hex Strings

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    return color;
}

-(unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    return hexInt;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
