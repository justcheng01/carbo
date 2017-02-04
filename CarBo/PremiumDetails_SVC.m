//
//  PremiumDetails_SVC.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "PremiumDetails_SVC.h"
#import "AlbumClass.h"
#import "MainVC.h"
#import "Reachability.h"
#import "Constant.h"
@interface PremiumDetails_SVC ()
{
    UIColor *colour;
    UIColor *lightgraycolor;
    UIScrollView *scrollview;
    UIButton *confirmBtn;
    UIActivityIndicatorView *indicator;
    UILabel *regmark;
    
    UIImageView *PEDImage;
    
    UIImageView *ADDRImage;
    
    UIImageView *RMPPImage;
    
    UIImageView *RMCPImage;
    
    UIImageView *HKIDImage;
    
    
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UIView *view4;
    
    BOOL FlagOne;
    BOOL Flagtwo;
    BOOL FlagThree;
    BOOL FlagFour;
    BOOL FlagFive;
    BOOL FlagSix;
    
    UILabel *hkid_line;
    UILabel *regmark_line;
    UILabel *regmark_lineC;
    
}
@property(strong,nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation PremiumDetails_SVC
@synthesize  ID_CArd_Image,Driving_lic_image,address_label,Adress_proof_image,ID_card_label,driving_label,reg_mark_pre_policy,reg_mark_pre_policy_label,pre_Insurance,pre_policy_no,pre_expiry_date_VL,policy_effective_date_VL,email_text,hire_Purchaser,pre_Insurance_lablel,pre_policy_no_lablel,pre_expiry_date_label,policy_effective_date_label,email_label,hire_Purchaser_label,bankReceiptImageview,Check,strc,CAR_info_label,HKID_label,address_textview,HKID_text,RegMark_label,RegMark_text,indicator,reg_mark_current,reg_mark_current_label;

- (void)viewDidLoad 
{
    [super viewDidLoad];
// Do any additional setup after loading the view.

        FlagOne = NO;
        Flagtwo = NO;
        FlagThree = NO ;
        FlagFour = NO ;
        FlagFive = NO ;
        FlagSix = NO ;
    
    self.navigationItem.title = NSLocalizedString(@"Premium Details", nil);
  
    colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    lightgraycolor=[self getUIColorObjectFromHexString:@"#101111" alpha:0.1];

//    NSString *Phone=[NSString stringWithFormat:NSLocalizedString(@"Phone", nil)];
//    [phonetext setPlaceholder:Phone];
//    
//    [updateBtn setTitle:NSLocalizedString(@"Update Profile", nil) forState:UIControlStateNormal];
//Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //Scrollview Added Programmatically
    // scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+200)]; //OLD Code
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+700)];   //NEW Code
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.alwaysBounceHorizontal=NO;
    scrollview.alwaysBounceVertical=NO;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
   // [scrollview setBackgroundColor:[UIColor redColor]];  
    scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1550);
    [self.view addSubview:scrollview];
   
    
    ///OLD Code
    
    /// SEction 1
    NSString *MF=[NSString stringWithFormat:NSLocalizedString(@"Mandatory Fields", nil)];
    //    [phonetext setPlaceholder:Phone];
        /// Pre_Insurance_lablel
        first_heading=[[UILabel alloc]initWithFrame:CGRectMake(0,5,[UIScreen mainScreen].bounds.size.width,35)];
        [first_heading setTextColor:colour];
        [first_heading setFont:[UIFont boldSystemFontOfSize:17]];
        [first_heading setText:MF];
        //[reset_Lable setFont:boldFont];
        [first_heading setTextAlignment:NSTextAlignmentCenter];
        [scrollview addSubview:first_heading];
    
   //// view1
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(20,45, [UIScreen mainScreen].bounds.size.width -40,170)];
    [view1 setBackgroundColor:lightgraycolor];
    [scrollview addSubview:view1];

    
    //ID CArd
    ID_CArd_Image=[[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-160)/2,5,120,120)];
    ID_CArd_Image.userInteractionEnabled=YES;
    ID_CArd_Image.tag=21;
    
    UIImage *image1=[[UIImage alloc]init];
 //   image1 = [UIImage imageNamed:@"uploadimage.png"];
    image1 = [UIImage imageNamed:@"upload-icon.png"];
    ID_CArd_Image.image=image1;
    
    //[ID_CArd_Image setBackgroundColor:lightgraycolor];
    [view1 addSubview:ID_CArd_Image];

    ID_card_label = [[UILabel alloc]initWithFrame:CGRectMake(0,135,[[UIScreen mainScreen] bounds].size.width-40,40)];
    ID_card_label.userInteractionEnabled=YES;
    [ID_card_label setTextColor:[UIColor darkGrayColor]];
    [ID_card_label setTextAlignment:NSTextAlignmentCenter];

    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
     NSString *ICL=[NSString stringWithFormat:NSLocalizedString(@"Upload ID Card", nil)];
    [ID_card_label setFont:[UIFont boldSystemFontOfSize:14]];
    ID_card_label.text=ICL;
    [view1 addSubview:ID_card_label];
    
    //Driving License
    view2 = [[UIView alloc]initWithFrame:CGRectMake(20,225, [UIScreen mainScreen].bounds.size.width-40,170)];
    [view2 setBackgroundColor:lightgraycolor];
    [scrollview addSubview:view2];

    
    //  Photo assignment
    //  ID_CArd_Image.image = bankReceiptImageview.image;
    
    //Driving license
    Driving_lic_image=[[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-160)/2,5,120,120)];
    Driving_lic_image.userInteractionEnabled=YES;
    Driving_lic_image.image=image1;
    Driving_lic_image.tag=22;
    
    //[Driving_lic_image setBackgroundColor:[UIColor lightGrayColor]];
    [view2 addSubview:Driving_lic_image];
    
                                                                
    NSString *UDL=[NSString stringWithFormat:NSLocalizedString(@"Upload Driving Licence", nil)];
    driving_label = [[UILabel alloc]initWithFrame:CGRectMake(0,130,[[UIScreen mainScreen] bounds].size.width-40,40)];
    driving_label.userInteractionEnabled=YES;
    [driving_label setTextColor:[UIColor darkGrayColor]];
    [driving_label setFont:[UIFont boldSystemFontOfSize:14]];
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    driving_label.text=UDL;
    [driving_label setTextAlignment:NSTextAlignmentCenter];
    [view2 addSubview:driving_label];
    
    /// policy_effective_date_label
    // ICON
    
    view3 = [[UIView alloc]initWithFrame:CGRectMake(20,406,[UIScreen mainScreen].bounds.size.width-40,195)];
    [view3 setBackgroundColor:lightgraycolor];
    [scrollview addSubview:view3];
    
    PEDImage = [[UIImageView alloc]initWithFrame:CGRectMake(5,7,32,32)];
    PEDImage.userInteractionEnabled=YES;
    PEDImage.image=[UIImage imageNamed:@"icon2-48.png"];
    [view3 addSubview:PEDImage];
    
    
     NSString *PED=[NSString stringWithFormat:NSLocalizedString(@"Policy Effective Date", nil)];
    
    policy_effective_date_label=[[UILabel alloc]initWithFrame:CGRectMake(45,7,120, 45)];
    [policy_effective_date_label setTextColor:[UIColor darkGrayColor]];
    [policy_effective_date_label setFont:[UIFont boldSystemFontOfSize:14]];
    [policy_effective_date_label setText:PED];
    policy_effective_date_label.numberOfLines=2;
    //[reset_Lable setFont:boldFont];
    [policy_effective_date_label setTextAlignment:NSTextAlignmentLeft];
    [view3 addSubview:policy_effective_date_label];
    
    NSString *SD=[NSString stringWithFormat:NSLocalizedString(@"Select Date", nil)];
    /// policy_effective_date_VL Label
    policy_effective_date_VL = [[UILabel alloc]initWithFrame:CGRectMake(150,7,[UIScreen mainScreen].bounds.size.width-200, 40)];
    // [exercise_name setBackground:[UIImage imageNamed:@"btn-new-1.png"]];
    // policy_effective_date_VL.layer.borderWidth = 1;
    policy_effective_date_VL.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
    [policy_effective_date_VL setTextColor:[UIColor blackColor]];
    //[policy_effective_date_VL setBackgroundColor:colour];
    policy_effective_date_VL.userInteractionEnabled=YES;
    [policy_effective_date_VL setText:SD];
    [policy_effective_date_VL setFont:[UIFont boldSystemFontOfSize:14]];
    policy_effective_date_VL.layer.cornerRadius=10;
    policy_effective_date_VL.clipsToBounds=YES;
    [policy_effective_date_VL setTextAlignment:NSTextAlignmentCenter];
    // exercise_name.tag=100;
    [view3 addSubview:policy_effective_date_VL];
   
    //NEW Code
    //ID CArd
    ADDRImage = [[UIImageView alloc]initWithFrame:CGRectMake(5,55,32,32)];
    ADDRImage.userInteractionEnabled=YES;
    ADDRImage.image=[UIImage imageNamed:@"icon14-48.png"];
    [view3 addSubview:ADDRImage];
 
    NSString *Address=[NSString stringWithFormat:NSLocalizedString(@"Address", nil)];
    address_label = [[UILabel alloc]initWithFrame:CGRectMake(45,55,90,40)];
    address_label.userInteractionEnabled=YES;
    [address_label setTextColor:[UIColor darkGrayColor]];
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    [address_label setFont:[UIFont boldSystemFontOfSize:14]];
    address_label.text=Address;
    [view3 addSubview:address_label];
    
    
    address_textview =[[UITextView alloc]initWithFrame:CGRectMake(150,57,[UIScreen mainScreen].bounds.size.width - 200 ,130)];
    address_textview.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
    [address_textview setFont:[UIFont systemFontOfSize:16]];
   // [address_textview.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    address_textview.layer.borderColor=[colour CGColor];
    [address_textview.layer setBorderWidth:2.0];
    [address_textview setTextColor:[UIColor blackColor]];
    //The rounded corner part, where you specify your view's corner radius:
    address_textview.layer.cornerRadius = 5;
    address_textview.clipsToBounds = YES;
    address_textview.delegate=self;
    [address_textview setTextAlignment:NSTextAlignmentLeft];
    // exercise_name.tag=100;
    address_textview.delegate=self;
    [view3 addSubview:address_textview];

    
    //OPTIONAL FIELDS 
    NSString *Optionfield=[NSString stringWithFormat:NSLocalizedString(@"Optional Fields", nil)];
    /// Pre_Insurance_lablel
    second_heading=[[UILabel alloc]initWithFrame:CGRectMake(0,605,[UIScreen mainScreen].bounds.size.width, 35)];
    [second_heading setTextColor:colour];
    [second_heading setFont:[UIFont boldSystemFontOfSize:17]];
    [second_heading setText:Optionfield];
    //[reset_Lable setFont:boldFont];
    [second_heading setTextAlignment:NSTextAlignmentCenter];
    [scrollview addSubview:second_heading];
    
    // ***  View 4  ***
    view4 = [[UIView alloc]initWithFrame:CGRectMake(20,645,[UIScreen mainScreen].bounds.size.width-40,320)];
    [view4 setBackgroundColor:lightgraycolor];
    [scrollview addSubview:view4];

    NSString *UAP=[NSString stringWithFormat:NSLocalizedString(@"Upload Address Proof", nil)];
    //Address Proof Image
    Adress_proof_image=[[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-160)/2,5,120,120)];
    Adress_proof_image.userInteractionEnabled=YES;
    Adress_proof_image.image=image1;
    Adress_proof_image.tag=23;
    [view4 addSubview:Adress_proof_image];
    
    //Address
    address_label = [[UILabel alloc]initWithFrame:CGRectMake(0,130,[UIScreen mainScreen].bounds.size.width-40,40)];
    address_label.userInteractionEnabled=YES;
    [address_label setTextColor:[UIColor darkGrayColor]];
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    address_label.text=UAP;
    [address_label setTextAlignment:NSTextAlignmentCenter];
    [address_label setFont:[UIFont boldSystemFontOfSize:14]];
    [view4 addSubview:address_label];

   
    /// REG mark Policy label RMPI
    RMPPImage = [[UIImageView alloc]initWithFrame:CGRectMake(5,180,32,32)];
    RMPPImage.userInteractionEnabled=YES;
    RMPPImage.image=[UIImage imageNamed:@"icon14-48.png"];
    [view4 addSubview:RMPPImage];

    
    //REgmark Previous
    //Reg.Mark
    NSString *RM=[NSString stringWithFormat:NSLocalizedString(@"Reg.Mark", nil)];
    reg_mark_pre_policy_label=[[UILabel alloc]initWithFrame:CGRectMake(45,180,140,35)];
    [reg_mark_pre_policy_label setTextColor:[UIColor darkGrayColor]];
    [reg_mark_pre_policy_label setFont:[UIFont boldSystemFontOfSize:14]];
    [reg_mark_pre_policy_label setText:RM];
    reg_mark_pre_policy_label.numberOfLines=2;
    //[reset_Lable setFont:boldFont];
    [reg_mark_pre_policy_label setTextAlignment:NSTextAlignmentLeft];
    [view4 addSubview:reg_mark_pre_policy_label];
    
    
    regmark_line =[[UILabel alloc]initWithFrame:CGRectMake(180,217,[UIScreen mainScreen].bounds.size.width-230,2)];
    [regmark_line setBackgroundColor:colour];
    [view4 addSubview:regmark_line];
    
    
    /// REG mark Policy text    
    reg_mark_pre_policy=[[UITextField alloc]initWithFrame:CGRectMake(180,180,[UIScreen mainScreen].bounds.size.width-230,35)];
   [reg_mark_pre_policy setBorderStyle:UITextBorderStyleRoundedRect];
    reg_mark_pre_policy.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
    [reg_mark_pre_policy setTextAlignment:NSTextAlignmentLeft];
     [reg_mark_pre_policy setTextColor:[UIColor darkGrayColor]];
     [reg_mark_pre_policy setBorderStyle:UITextBorderStyleNone];
    // exercise_name.tag=100;
    reg_mark_pre_policy.delegate=self;
    [view4 addSubview:reg_mark_pre_policy];
   
    
    ///Regmark Current
    RMPPImage  = [[UIImageView alloc]initWithFrame:CGRectMake(5,230,32,32)];
    RMPPImage.userInteractionEnabled=YES;
    RMPPImage.image=[UIImage imageNamed:@"icon14-48.png"];
    [view4 addSubview:RMPPImage];
    
    NSString *RMC = [NSString stringWithFormat:NSLocalizedString(@"Reg.Mark in Prev Policy", nil)];
    reg_mark_current_label=[[UILabel alloc]initWithFrame:CGRectMake(45,225,100,40)];
    [reg_mark_current_label setTextColor:[UIColor darkGrayColor]];
    [reg_mark_current_label setFont:[UIFont boldSystemFontOfSize:14]];
    [reg_mark_current_label setText:RMC];
    reg_mark_current_label.numberOfLines=2;
    //[reset_Lable setFont:boldFont];
    [reg_mark_pre_policy_label setTextAlignment:NSTextAlignmentLeft];
    [view4 addSubview:reg_mark_current_label];
    
    
    regmark_line =[[UILabel alloc]initWithFrame:CGRectMake(180,264,[UIScreen mainScreen].bounds.size.width-230,2)];
    [regmark_line setBackgroundColor:colour];
    [view4 addSubview:regmark_line];
    
    
    /// REG mark Policy text    
    reg_mark_current=[[UITextField alloc]initWithFrame:CGRectMake(180,228,[UIScreen mainScreen].bounds.size.width-230,35)];
    [reg_mark_current setBorderStyle:UITextBorderStyleRoundedRect];
    reg_mark_current.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
     [reg_mark_current setTextColor:[UIColor darkGrayColor]];
    [reg_mark_current setTextAlignment:NSTextAlignmentLeft];
    [reg_mark_current setBorderStyle:UITextBorderStyleNone];
    reg_mark_current.delegate=self;
    [view4 addSubview:reg_mark_current];
    
 
    
    // HKID License Label & ImageView
    HKIDImage = [[UIImageView alloc]initWithFrame:CGRectMake(5,275,32,32)];
    HKIDImage.userInteractionEnabled=YES;
    HKIDImage.image=[UIImage imageNamed:@"icon8-48.png"];
    [view4 addSubview:HKIDImage];

    
    hkid_line =[[UILabel alloc]initWithFrame:CGRectMake(180,307,[UIScreen mainScreen].bounds.size.width-230,2)];
    [hkid_line setBackgroundColor:colour];
    [view4 addSubview:hkid_line];
    

    NSString *HKID=[NSString stringWithFormat:NSLocalizedString(@"HKID", nil)];
    HKID_label = [[UILabel alloc]initWithFrame:CGRectMake(45,270,150,40)];
    HKID_label.userInteractionEnabled=YES;
    [HKID_label setTextColor:[UIColor darkGrayColor]];
    [HKID_label setFont:[UIFont boldSystemFontOfSize:14]];
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    HKID_label.text=HKID;
    [HKID_text setReturnKeyType:UIReturnKeyDone];
    [view4 addSubview:HKID_label];
    
    //HKID TextField
    HKID_text=[[UITextField alloc]initWithFrame:CGRectMake(180,270,[UIScreen mainScreen].bounds.size.width-230,35)];
   HKID_text.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
    [HKID_text setBorderStyle:UITextBorderStyleRoundedRect];
    [HKID_text setTextColor:[UIColor darkGrayColor]];
    [HKID_text setBorderStyle:UITextBorderStyleNone];
    [HKID_text setTextAlignment:NSTextAlignmentLeft];
    [HKID_text setPlaceholder:@"HKID"];
    HKID_text.tag=777;
    HKID_text.delegate=self;
    // exercise_name.tag=100;
    HKID_text.delegate=self;
    [view4 addSubview:HKID_text];
    
    //Confirm Button
    confirmBtn=[[UIButton alloc]initWithFrame: CGRectMake(10,970,[[UIScreen mainScreen]bounds].size.width-20,40)];
    [confirmBtn setTitle:NSLocalizedString(@"CONFIRM", nil) forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius=10;
    [confirmBtn addTarget:self action:@selector(callToSavePremiumDetails) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitleColor:colour forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
    confirmBtn.layer.borderColor=[colour CGColor];
    confirmBtn.layer.cornerRadius=5;
    confirmBtn.layer.borderWidth=1;
    [scrollview addSubview:confirmBtn];

      ///Gesture Recognizer
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    tapGesture.delegate=self;
    tapGesture.numberOfTapsRequired=1;
    [ID_CArd_Image addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage2:)];
    tapGesture2.delegate=self;
    tapGesture2.numberOfTapsRequired=1;
    [Driving_lic_image addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage3:)];
    tapGesture3.delegate=self;
    tapGesture3.numberOfTapsRequired=1;
    [Adress_proof_image addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DAteSelection)];
    tapGesture4.delegate=self;
    tapGesture4.numberOfTapsRequired=1;
    [pre_expiry_date_VL addGestureRecognizer:tapGesture4];

    UITapGestureRecognizer *tapGesture5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DAteSelection2)];
    tapGesture5.delegate=self;
    tapGesture5.numberOfTapsRequired=1;
    [policy_effective_date_VL addGestureRecognizer:tapGesture5];
    
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(130.0,350.0, 80.0, 80.0);
    indicator.center = self.view.center;
    indicator.color=colour;
    indicator.layer.cornerRadius=10;
   // [indicator setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

#pragma mark DateSelection
-(void)DAteSelection
{
    [self.view endEditing:YES];
    
    [pView removeFromSuperview];
  
    pView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-320/2,self.view.frame.size.height-240,320,240)];
    [pView setBackgroundColor:[UIColor lightGrayColor]];
    //    pView.layer.cornerRadius = 5;
    //    pView.layer.masksToBounds = YES;
    [self.view addSubview:pView];
    
    //Cancel Btn
    cancel_Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,80,30)];
    [cancel_Btn addTarget:self action:@selector(selectedOption_date:) forControlEvents:UIControlEventTouchUpInside];
    [cancel_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel_Btn setBackgroundColor:colour];
    
    [cancel_Btn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    cancel_Btn.tag=101;
    
    //DAteLabel
    dateLabel=[[UILabel alloc]initWithFrame:CGRectMake((pView.frame.size.width-100)/2,0,100, 30)];
    [dateLabel setText:NSLocalizedString(@"Select Date", nil)];
    [pView addSubview:dateLabel];
    
    //DView
    dView=[[UIView alloc]initWithFrame:CGRectMake(3,30,pView.frame.size.width-7,200)];
    [dView setBackgroundColor:[UIColor whiteColor]];
    [pView addSubview:dView];
    
    //Done Btn
    Done_Btn=[[UIButton alloc]initWithFrame:CGRectMake((pView.frame.size.width-100), 0, 100,30)];
    [Done_Btn addTarget:self action:@selector(selectedOption_date:) forControlEvents:UIControlEventTouchUpInside];
    [Done_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Done_Btn setBackgroundColor:colour];
    Done_Btn.tag=102;
    [Done_Btn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    
    //DAte Picker
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,pView.frame.size.width,180)];
    
    ///setting Date Limits here
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:0];
    
    [comps setYear:-120];
 
    [datePicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [dView addSubview:datePicker];
    
    [pView addSubview:cancel_Btn];
    [pView addSubview:Done_Btn];
}


-(void)DAteSelection2
{
    [self.view endEditing:YES];
    
    [pView removeFromSuperview];
  
    pView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-320/2,self.view.frame.size.height-240,320,240)];
    [pView setBackgroundColor:[UIColor lightGrayColor]];
    //    pView.layer.cornerRadius = 5;
    //    pView.layer.masksToBounds = YES;
    [self.view addSubview:pView];
    
    //Cancel Btn
    cancel_Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,100,30)];
    [cancel_Btn addTarget:self action:@selector(selectedOption_date:) forControlEvents:UIControlEventTouchUpInside];
    [cancel_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel_Btn setBackgroundColor:colour];
    
    [cancel_Btn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    cancel_Btn.tag=101;
    
    //DAteLabel
    dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(100,0,pView.frame.size.width-200, 30)];
    [dateLabel setText:NSLocalizedString(@"Select Date", nil)];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [pView addSubview:dateLabel];
    
    //DView
    dView=[[UIView alloc]initWithFrame:CGRectMake(3,30,pView.frame.size.width-7,200)];
    [dView setBackgroundColor:[UIColor whiteColor]];
    [pView addSubview:dView];
    
    //Done Btn
    Done_Btn=[[UIButton alloc]initWithFrame:CGRectMake((pView.frame.size.width-100), 0, 100,30)];
    [Done_Btn addTarget:self action:@selector(selectedOption_date:) forControlEvents:UIControlEventTouchUpInside];
    [Done_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Done_Btn setBackgroundColor:colour];
    Done_Btn.tag=103;
    [Done_Btn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    
    // DAte Picker
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,pView.frame.size.width,180)];
    /// setting Date Limits here
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:0];
    
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    //[datePicker setMaximumDate:maxDate];
    
    [comps setYear:-120];
    
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    //[datePicker setMinimumDate:minDate];
    
    
    [datePicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [dView addSubview:datePicker];
    
    [pView addSubview:cancel_Btn];
    [pView addSubview:Done_Btn];
}

-(IBAction)pickerChanged:(UIDatePicker*)sender
{}

-(IBAction)selectedOption_date:(UIButton*)sender
{
    if(sender.tag==102)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
       pre_expiry_date_VL.text=strDate;
       [pView removeFromSuperview];
}
else
  {
      [pView removeFromSuperview];
  }
    
if(sender.tag==103)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        policy_effective_date_VL.text = strDate;
        [pView removeFromSuperview];
    }
    else    
    {
        [pView removeFromSuperview];
    }
}

#pragma mark-- UIImage Picker Code 

-(IBAction)selectImage:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
    popup.tag = 1;
    [popup showInView:self.view];
}

-(IBAction)selectImage2:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
    popup.tag = 2;
    [popup showInView:self.view];
}

-(IBAction)selectImage3:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
    popup.tag = 3;
    [popup showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    id sender;
    if(popup.tag == 1)
    {   
                switch (buttonIndex)
                {
                    case 0:
                        [self selectImageFromGallary:sender];
                        break;
                    case 1:
                        [self shootNow:sender];
                        break;
                    default:
                        break;
                }
    }
    else if (popup.tag==2)
    {
                switch (buttonIndex) {
                    case 0:
                        [self selectImageFromGallary2:sender];
                        break;
                    case 1:
                        [self shootNow2:sender];
                        break;
                    default:
                        break;
                }
    }
    else if (popup.tag==3)
    {
                switch (buttonIndex) {
                    case 0:
                        [self selectImageFromGallary3:sender];
                        break;
                    case 1:
                        [self shootNow3:sender];
                        break;
                    default:
                        break;
                }
    }
}

-(IBAction)selectImageFromGallary:(id)sender
{
    UIImagePickerController *pickerController =  [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.title=@"1";
    [self presentViewController:pickerController animated:YES completion:nil];
    
    FlagOne = YES;
    Flagtwo = NO;
    FlagThree = NO ;
    FlagFour = NO ;
    FlagFive = NO ;
    FlagSix = NO ;
}

-(IBAction)selectImageFromGallary2:(id)sender
{
    UIImagePickerController *pickerController2 = [[UIImagePickerController alloc] init];
    pickerController2.delegate = self;
    pickerController2.allowsEditing = YES;
    pickerController2.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerController2.title=@"2";
    [self presentViewController:pickerController2 animated:YES completion:nil];
    
    FlagOne = NO;
    Flagtwo = YES;
    FlagThree = NO ;
    FlagFour = NO ;
    FlagFive = NO ;
    FlagSix = NO ;
}


-(IBAction)selectImageFromGallary3:(id)sender
{
    UIImagePickerController *pickerController3= [[UIImagePickerController alloc] init];
    //= [AlbumClass imagePickerControllerWithDelegate:self];
    pickerController3.delegate = self;
    pickerController3.allowsEditing = YES;
    pickerController3.title=@"3";
//  NSArray *mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeLivePhoto];
//  pickerController3.mediaTypes = mediaTypes;
    pickerController3.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:pickerController3 animated:YES completion:nil];
    
    FlagOne = NO;
    Flagtwo = NO;
    FlagThree = YES ;
    FlagFour = NO ;
    FlagFive = NO ;
    FlagSix = NO ;

}

-(IBAction)shootNow:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.title=@"4";
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
    FlagOne = NO;
    Flagtwo = NO;
    FlagThree = NO ;
    FlagFour = YES ;
    FlagFive = NO ;
    FlagSix = NO ;

}

-(IBAction)shootNow2:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.title=@"5";
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
    FlagOne = NO;
    Flagtwo = NO;
    FlagThree = NO ;
    FlagFour = NO ;
    FlagFive = YES ;
    FlagSix = NO ;

}

-(IBAction)shootNow3:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.title=@"6";
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
    
    FlagOne = NO;
    Flagtwo = NO;
    FlagThree = NO ;
    FlagFour = NO ;
    FlagFive = NO ;
    FlagSix = YES ;

}


#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *photo;
    
   photo = info[UIImagePickerControllerEditedImage];
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //NSLog(@"Picker Title :: %@",picker.title);
    
  

    //Do not delete this block
    [UIView animateWithDuration:2.0
                     animations:^{
                        
                         if([picker.title isEqualToString:@"1"])
                         {
                              //NSLog(@"CAlled 1");
                              self.ID_CArd_Image.image = photo;
                         }
                         else if([picker.title isEqualToString:@"2"])
                         {
                              //NSLog(@"called 2");
                              self.Driving_lic_image.image = photo;
                         }
                         else if([picker.title isEqualToString:@"3"])
                         {
                              self.Adress_proof_image.image = photo;
                              //NSLog(@"called 3");
                         }
                         else if([picker.title isEqualToString:@"4"])
                         {
                              self.ID_CArd_Image.image = photo;
                              //NSLog(@"called 4");
                         }
                         else if([picker.title isEqualToString:@"5"])
                         {
                              self.Driving_lic_image.image = photo;
                              //NSLog(@"called 5");
                         }
                         else if([picker.title isEqualToString:@"6"])
                         {
                              self.Adress_proof_image.image = photo;
                              //NSLog(@"called 6");
                         }

                         if(FlagOne)
                        {
                            //NSLog(@"CAlled 1");
                            self.ID_CArd_Image.image = photo;
                        }
                        else if (Flagtwo)
                        {
                            
                            //NSLog(@"called 2");
                            self.Driving_lic_image.image = photo;
                        }
                        else if (FlagThree)
                        {
                            self.Adress_proof_image.image = photo;
                            //NSLog(@"called 3");

                        }
                        else if (FlagFour)
                        {
                            self.ID_CArd_Image.image = photo;
                            //NSLog(@"called 4");
                            
                        }
                        else if (FlagFive)
                        {
                            self.Driving_lic_image.image = photo;
                            //NSLog(@"called 5");
                            
                        }
                        else if (FlagSix)
                        {
                            self.Adress_proof_image.image = photo;
                            //NSLog(@"called 6");
                            
                        }
                         
                         FlagOne = NO;
                         Flagtwo = NO;
                         FlagThree = NO ;
                         FlagFour = NO ;
                         FlagFive = NO ;
                         FlagSix = NO ;
                         self.navigationController.navigationBarHidden = NO;

                     } completion:^(BOOL finished) {
                         
                         if ([UIScreen mainScreen].bounds.size.height == 480)
                         {   
                             
                         }                         
                    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - CameraDelegate

- (void)cameraDidTakePhoto:(UIImage *)image
{
    
    
    UIImage *photo;
    photo   = image;
    
    self.bankReceiptImageview.image = photo;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraWillTakePhoto
{
    //NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark ****** WEB SERVICE ****** Call To save Premium Details

-(void)callToSavePremiumDetails
{
  
    NSString *user_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];
   
    NSString *quotation_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_id"]];;
    
    
    //Image Data
    //  NSData *payment_recipt_pics_data = UIImageJPEGRepresentation(bankReceiptImageview.image, 90);
    NSData *id_card_pics_data        = UIImageJPEGRepresentation(ID_CArd_Image.image, 90);
    NSData *address_pics_image_data  = UIImageJPEGRepresentation(Adress_proof_image.image, 90);
    NSData *driving_pic_image_data   = UIImageJPEGRepresentation(Driving_lic_image.image, 90);;
    
    
    
    //Policy Effective Date
    NSString *policy_efficient_date=policy_effective_date_VL.text;
    NSString  *trimmed = [policy_efficient_date stringByReplacingOccurrencesOfString: @" "
                                                                          withString: @""
                                                                             options: NSRegularExpressionSearch
                                                                               range: NSMakeRange(0, policy_efficient_date.length)];
    policy_efficient_date=trimmed;
    //NSLog(@"policy_efficient_date:: %@ :: %@",policy_efficient_date,trimmed);
    
    
    //Address
    NSString *address=address_textview.text;
    trimmed = [address stringByReplacingOccurrencesOfString:@" "
                                                 withString: @"0"
                                                    options: NSRegularExpressionSearch
                                                      range: NSMakeRange(0, address.length)];
    address=trimmed;
    //NSLog(@"address:: %@",address);
    
    
    //REG Mark Previous Policy
    NSString *reg_mark_text=reg_mark_pre_policy.text;
    trimmed = [reg_mark_text stringByReplacingOccurrencesOfString:@" "
                                              withString: @""
                                                 options: NSRegularExpressionSearch
                                                   range: NSMakeRange(0,reg_mark_text.length)];
    reg_mark_text = trimmed;
    
     //NSLog(@"reg_mark_text :: %@",reg_mark_text);
    
    NSString *reg_mark_text_Current = reg_mark_current.text;
    trimmed = [reg_mark_text_Current stringByReplacingOccurrencesOfString:@" "
                                                       withString: @""
                                                          options: NSRegularExpressionSearch
                                                            range: NSMakeRange(0, reg_mark_text_Current.length)];
    reg_mark_text_Current = trimmed;
    
      //NSLog(@"reg_mark_text_Current :: %@",reg_mark_text_Current);
    //Hkid
    NSString *hkid=HKID_text.text;
    trimmed = [hkid stringByReplacingOccurrencesOfString:@" "
                                              withString: @""
                                                 options: NSRegularExpressionSearch
                                                   range: NSMakeRange(0, hkid.length)];
    hkid=trimmed;
  
    BOOL Network=[self Reachability_To_Chechk_Network];
    
    if(Network)
    {
        
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
        self.indicator.center = self.view.center;
        self.indicator.color=[UIColor whiteColor];
        self.indicator.layer.cornerRadius=10;
        [self.indicator setBackgroundColor:colour];
        self.indicator.layer.zPosition++;
        self.indicator.layer.zPosition++;
        
        [self.indicator startAnimating];
        [self.view addSubview:indicator];
        [self.view setUserInteractionEnabled:NO];
        
        if(policy_effective_date_VL.text>0 && address.length>0 && id_card_pics_data.length >0 && driving_pic_image_data.length>0)
        {
          
            if(![policy_effective_date_VL.text isEqualToString:@"Select Date"] && ![policy_effective_date_VL.text isEqualToString:@"選擇"]){
       
            
                 [self.view setUserInteractionEnabled:NO];
            NSOperationQueue *myQueuesvc = [[NSOperationQueue alloc] init];
                [myQueuesvc addOperationWithBlock:^{
                   
                           //New converted text
                    NSString*  regmakl ;
                    NSData *dataenc = [reg_mark_text dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                    regmakl = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                    
                    
                   
                    NSString *regmarkCl;
                 //   [reg_mark_text_Current stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    dataenc = [reg_mark_text_Current dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                    regmarkCl = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                    
                    
                    
                    NSString*   hkidl; //= [hkid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   
                    dataenc = [hkid dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                    hkidl = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                    
                    
                    
                    
                    
                    NSString*   addressl; // = [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    dataenc = [address dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                    addressl = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                    
                    
                    
                    
                    NSString *urlString;
                    urlString=[NSString stringWithFormat:@"%@makePayment_ios.php?",kAPIEndpointLatestPath];
            
                     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:[NSURL URLWithString:urlString]];
                    [request setHTTPMethod:@"POST"];
                    
                    NSString *boundary = @"---------------------------14737809831466499882746641449";
                    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                    
                    NSMutableData *body = [NSMutableData data];
                    
                    //NSLog(@"User_id :: %@",user_id);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:user_id] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    //NSLog(@"quotation_id :: %@",quotation_id);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"quotation_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:quotation_id] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    //NSLog(@"Policy_efficient_date :: %@",policy_efficient_date);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"policy_efficient_date\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:policy_efficient_date] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                   
                    //chinese
                    //NSLog(@"reg_mark_text_Current :: %@",reg_mark_text);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"regmark\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:reg_mark_text] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
              
                    //NSLog(@"reg_mark_text previous :: %@",reg_mark_text_Current);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"previous_policy\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:reg_mark_text_Current] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    //NSLog(@"HKID :: %@",hkid);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"hkid\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:hkid] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    //NSLog(@"Address :: %@",address);
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:address] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    /// ID Card Image  id_card_pics
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"id_card_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:id_card_pics_data]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    // Driving license PICS
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"driving_license\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:driving_pic_image_data]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    // Address Proof   address_pics
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[NSData dataWithData:address_pics_image_data]];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [request setHTTPBody:body];
                    
                    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    
                    //NSLog(@"Return Data :: %@",returnData);
                    
                    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        
                        if(returnString.length>6)
                        {
                            //NSLog(@"Return Data :: %@",returnString);

                            NSDictionary *jsonObject=[NSJSONSerialization
                                                      JSONObjectWithData:returnData
                                                      options:NSJSONReadingMutableLeaves
                                                      error:nil];
                            NSString *Str=[NSString stringWithFormat:@"%@",[jsonObject objectForKey:@"result"]];
                            //NSLog(@"Str SVC :: %@ ",Str);

                            if([Str isEqualToString:@"success"])
                            {
                                [self.view setUserInteractionEnabled:YES];
                                [self.indicator setHidden:YES];
                                [self.indicator removeFromSuperview];
                                
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Paid policy", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                                [alert show];
                                
                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                MainVC *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
                                [self.navigationController pushViewController:rootController animated:YES];
                                // [self performSegueWithIdentifier:@"CTOP" sender:self];
                            }
                            else
                            {
                                [self.view setUserInteractionEnabled:YES];
                                [self.indicator setHidden:YES];
                                [self.indicator removeFromSuperview];
                                
                                NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                [alert show];
                            }
                            
                            
                        }
                    }];
                }];
            }
            else //DAte
            {
                [self.indicator setHidden:YES];
                [self.indicator removeFromSuperview];
                [self.view setUserInteractionEnabled:YES];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please select Date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            } 
        }
        else
        {
            [self.indicator setHidden:YES];
            [self.indicator removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];

            [self.view setUserInteractionEnabled:YES];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"All the fields are mandatory", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        [self.indicator setHidden:YES];
        [self.indicator removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}



-(BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"^[^@]+@([-\\w]+\\.)+[A-Za-z]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //NSLog(@"validate ::%hhd",[emailTest evaluateWithObject:email]);
    return [emailTest evaluateWithObject:email];
}

-(void)backJump1
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- Touches & PrepareForSegue
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [RegMark_text resignFirstResponder];
    [address_textview resignFirstResponder];
    [HKID_text resignFirstResponder];    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{
if([text isEqualToString:@"\n"])
{
        [address_textview resignFirstResponder];
        return NO;
    }
 return YES;
}

#pragma mark -- TextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
     [RegMark_text resignFirstResponder];
    [textField resignFirstResponder];
    [HKID_text resignFirstResponder];    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [pView removeFromSuperview];
    
}

#pragma mark -- Reachability
-(BOOL)Reachability_To_Chechk_Network
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        //NSLog(@"Not REachable");
        return NO;
        //No internet
    }
    else if (status == ReachableViaWiFi)
    {
        //NSLog(@"REachable via WIFI");
        //WiFi
        return YES;
    }
    else if (status == ReachableViaWWAN)
    {
        //NSLog(@"REachable Mobile network 3G");
        //3G
        return YES;
    }
    else
    {
        //NSLog(@"Not Reachable");
        return NO;
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
