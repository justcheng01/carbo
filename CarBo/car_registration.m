//
//  car_registration.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "car_registration.h"
#import "carRegistrationCell.h"
#import "AlbumClass.h"
#import "Select Policy.h"
#import "Reachability.h"
#import "MainVC.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

#define kOFFSET_FOR_KEYBOARD 100.0

@interface car_registration ()
{
    UIButton *UploadImageBtn;
    UIScrollView *scrollview;
    UIImageView *carinfoImage;
    UILabel *datelabel;
    UILabel *heading1;
    UILabel *or;
    UILabel *heading2;
    UILabel *heading3;
    UILabel *line;
    UILabel *select_Date_label;
    UIButton *nextBtn;
    NSInteger Movevalue;
    UIColor *colour;
    NSMutableArray *userDetails;
    UILabel *NoClaimsDiscount;
    UILabel *NoClaimsDiscount_val;
    UILabel *NCD_Actual_Val;
    UILabel *line2;
    UIImageView  *arrow_imageview;
    
    //Body Type
    UILabel *bodytype;
    UILabel *bodytype_val;
    
    ///Class
    UILabel *class;
    UILabel *class_val;
    
    //Application Status
    UILabel *application_Status;
    UILabel *application_Status_val;
    NSString *NSSelectoption;
    NSString *NSCancel;
    NSString *NSLSDD;
    // UIActivityIndicatorView *indicator;
    carRegistrationCell *cell;
    BOOL ImageFlag;
    
    UIColor *lightgraycolor;
    UIColor *maincolor;
    UIImageView  *logoArrowImageView;
    UIImageView  *logoArrowImageView2;
    UIImageView  *logoArrowImageView3;
    UIImageView *logoImageView;
    UIImageView *logoImageView2;
    
    NSString *FlagDateArrow;
    UIView *userView;
    NSInteger calculate_age;
 }
@property(nonatomic,strong) UIActivityIndicatorView *indicator;

@end

@implementation car_registration
@synthesize carTableview,imageview,indicator,classvalF,
bodytypeValF,makeTextF,modelTextF,yearTextF,engineCapacityTextF,imageviewF,SimageFlag;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *NSLQF = [NSString stringWithFormat:NSLocalizedString(@"Quotation Form", nil)];
    self.navigationItem.title = NSLQF;
  
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    //NSLog(@"Select_Policy :: %@",strc);
    
    //NSLog(@"USERID :: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]);
    
    lightgraycolor = [self getUIColorObjectFromHexString:@"#101111" alpha:0.1];
    
    maincolor = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    
    // [indicator setHidden:YES];
    // [indicator bringSubviewToFront:self.carTableview];
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1500)];
    // scrollview.showsVerticalScrollIndicator=YES;
    scrollview.alwaysBounceHorizontal=NO;
    scrollview.alwaysBounceVertical=NO;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    // [scrollview setBackgroundColor:[UIColor redColor]];
    scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1500);
    //[self.view addSubview:scrollview];
    
    carTableview=[[UITableView alloc]init];
    self.carTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.carTableview.frame = CGRectMake(15,-45,[[UIScreen mainScreen] bounds].size.width-30,[[UIScreen mainScreen]bounds].size.height+150);
    [carTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    carTableview.scrollEnabled = YES;
    [carTableview setBackgroundColor:[UIColor whiteColor]];
    carTableview.tag=101;
    carTableview.dataSource = self;
    carTableview.delegate=self;
    [self.view addSubview:carTableview];
    
    userDetails=[[NSMutableArray alloc]init];
    
    for(int i=0;i<19;i++)
    {
        [userDetails addObject:@""];
    }
    
    carinfoImage = [[UIImageView alloc]init];
    colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(-10, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    // NSString *NSLDone = [NSString stringWithFormat:NSLocalizedString(@"Done", nil)];
    nextBtn = [[UIButton alloc]initWithFrame: CGRectMake(10,10,[[UIScreen mainScreen]bounds].size.width-50,35)];
    [nextBtn setTitle:@"Done" forState:UIControlStateNormal];
    [nextBtn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [nextBtn setTitleColor:colour forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(call_profile_Detail_view_NCD_AGE_EXP) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.layer.borderWidth=2;
    nextBtn.layer.cornerRadius=15;
    nextBtn.layer.borderColor= [colour CGColor];
    //[nextBtn setBackgroundColor:colour];
    
    //Heading 1
    NSString * NSLHeading1 = [NSString stringWithFormat:NSLocalizedString(@"Upload Vehicle Sheet", nil)];
   // Upload Vehicle Sheet
    heading1 = [[UILabel alloc]initWithFrame:CGRectMake(0,5,[[UIScreen mainScreen] bounds].size.width-35,40)];
    [heading1 setTextColor:colour];
    [heading1 setFont:[UIFont boldSystemFontOfSize:14]];
    [heading1 setText:NSLHeading1];
    [heading1 setTextAlignment:NSTextAlignmentLeft];
    
    //OR Heading
     NSString *NSLOR = [NSString stringWithFormat:NSLocalizedString(@"OR", nil)];
    or = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen]bounds].size.width-70)/2,175,30,30)];
    [or setTextColor:[UIColor whiteColor]];
    [or setBackgroundColor:colour];
    [or setFont:[UIFont boldSystemFontOfSize:14]];
    [or setText:NSLOR];
    [or setTextAlignment:NSTextAlignmentCenter];
    or.layer.masksToBounds = YES;
    or.layer.cornerRadius = 14.0;
    
    // 175
    line = [[UILabel alloc]initWithFrame:CGRectMake(0,189,[[UIScreen mainScreen] bounds].size.width,1)];
    [line setTextColor:[UIColor whiteColor]];
    [line setBackgroundColor:colour];
    
    NSLHeading1 = [NSString stringWithFormat:NSLocalizedString(@"Insured Vehicle Information", nil)];
    
    //Heading 2  195
    heading2=[[UILabel alloc]initWithFrame:CGRectMake(0,205,[[UIScreen mainScreen] bounds].size.width-35,30)];
    [heading2 setTextColor:colour];
    [heading2 setFont:[UIFont boldSystemFontOfSize:14]];
    [heading2 setText:NSLHeading1];
    [heading2 setTextAlignment:NSTextAlignmentCenter];
    
    //Date Label
    NSString *NSLDOB = [NSString stringWithFormat:NSLocalizedString(@"Date Of Birth", nil)];
    datelabel = [[UILabel alloc]initWithFrame:CGRectMake(45,15,140,20)];
    [datelabel setTextColor:[UIColor blackColor]];
    [datelabel setFont:[UIFont boldSystemFontOfSize:12]];
    [datelabel setText:NSLDOB];
    [datelabel setTextAlignment:NSTextAlignmentLeft];
    
    //Select Date Label to Select date
    NSLSDD = [NSString stringWithFormat:NSLocalizedString(@"Select Date", nil)];
    NSLSDD = [NSString stringWithFormat:@"%@",NSLSDD];
    
    select_Date_label = [[UILabel alloc]initWithFrame:CGRectMake(175,9,[[UIScreen mainScreen]bounds].size.width-215,35)];
    select_Date_label.userInteractionEnabled=YES;
   [select_Date_label setTextColor:[UIColor blackColor]];
    //[select_Date_label setBackgroundColor:colour];
    select_Date_label.layer.cornerRadius=5;
    select_Date_label.text=NSLSDD;
    select_Date_label.textAlignment=NSTextAlignmentLeft;
    [select_Date_label setClipsToBounds:YES];
    
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DAteSelection)];
    tapGesture2.delegate=self;
    tapGesture2.numberOfTapsRequired=1;
    [select_Date_label addGestureRecognizer:tapGesture2];
    
   // down-arrow1.png
    arrow_imageview = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-100)/2,10,70,70)];
    arrow_imageview.userInteractionEnabled=YES;
    //AAAAAA
    
    //  [arrow_imageview setBackgroundColor:lightgraycolor];
    UIImage *image11 = [[UIImage alloc]init];
    image11 = [UIImage imageNamed:@"down-arrow1.png"];
    [arrow_imageview setImage:image11];
    
    //ImageView Vehicale information (ImageV)
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-165)/2,40,120,120)];
    imageview.userInteractionEnabled=YES;
    //AAAAAA
    
    [imageview setBackgroundColor:lightgraycolor];
    UIImage *image1 = [[UIImage alloc]init];
    image1 = [UIImage imageNamed:@"upload-icon.png"];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    tapGesture.delegate=self;
    tapGesture.numberOfTapsRequired=1;
    [imageview addGestureRecognizer:tapGesture];
    
    NoClaimsDiscount=[[UILabel alloc]initWithFrame:CGRectMake(45,1,140,40)];
    [NoClaimsDiscount setTextColor:[UIColor blackColor]];
    [NoClaimsDiscount setFont:[UIFont boldSystemFontOfSize:12]];
    [NoClaimsDiscount setText:@"No Claims Discount(NCD)"];
    NoClaimsDiscount.numberOfLines=2;
    [NoClaimsDiscount setTextAlignment:NSTextAlignmentLeft];
    
    NoClaimsDiscount_val = [[UILabel alloc]initWithFrame:CGRectMake(175,5,[[UIScreen mainScreen]bounds].size.width-215,35)];
    NoClaimsDiscount_val.userInteractionEnabled=YES;
  [NoClaimsDiscount_val setTextColor:[UIColor blackColor]];
  //  [NoClaimsDiscount_val setBackgroundColor:colour];
    NoClaimsDiscount_val.textAlignment=NSTextAlignmentLeft;
    NoClaimsDiscount_val.text=@" 0";
    NoClaimsDiscount_val.layer.cornerRadius=5;
    [NoClaimsDiscount_val setClipsToBounds:YES];
    
    NCD_Actual_Val=[[UILabel alloc]init];
    
    // bodytype
    //bodytype_val
     NSString *NSLBodyType = [NSString stringWithFormat:NSLocalizedString(@"Body Type", nil)];
    bodytype=[[UILabel alloc]initWithFrame:CGRectMake(45,5,140,40)];
    [bodytype setTextColor:[UIColor blackColor]];
    [bodytype setFont:[UIFont boldSystemFontOfSize:12]];
    [bodytype setText:NSLBodyType];
    bodytype.numberOfLines=2;
    //[exercise_Lable setFont:boldFont];
    [bodytype setTextAlignment:NSTextAlignmentLeft];
    
    bodytype_val = [[UILabel alloc]initWithFrame:CGRectMake(175,5,[[UIScreen mainScreen]bounds].size.width-215,35)];
    bodytype_val.userInteractionEnabled=YES;
    [bodytype_val setTextColor:[UIColor blackColor]];
    [bodytype_val setBackgroundColor:colour];
    bodytype_val.textAlignment=NSTextAlignmentLeft;
    bodytype_val.text=@"Hatch Back";
    bodytype_val.layer.cornerRadius=10;
    [bodytype_val setClipsToBounds:YES];
    
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectBodyType:)];
    tapGesture4.delegate=self;
    tapGesture4.numberOfTapsRequired=1;
    [bodytype_val addGestureRecognizer:tapGesture4];
    
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectNCD:)];
    tapGesture3.delegate=self;
    tapGesture3.numberOfTapsRequired=1;
    [NoClaimsDiscount_val addGestureRecognizer:tapGesture3];
    
    //Class
    NSString *NSLClass = [NSString stringWithFormat:NSLocalizedString(@"Class", nil)];
    class=[[UILabel alloc]initWithFrame:CGRectMake(45,5,140,40)];
    [class setTextColor:[UIColor blackColor]];
    [class setFont:[UIFont boldSystemFontOfSize:12]];
    [class setText:NSLClass];
    class.numberOfLines=2;
    //[exercise_Lable setFont:boldFont];
    [class setTextAlignment:NSTextAlignmentLeft];
    
    NSString *NSLPC = [NSString stringWithFormat:NSLocalizedString(@"Private Car", nil)];
    
    class_val = [[UILabel alloc]initWithFrame:CGRectMake(175,10,[[UIScreen mainScreen]bounds].size.width-215,35)];
    class_val.userInteractionEnabled=YES;
    [class_val setTextColor:[UIColor whiteColor]];
    [class_val setBackgroundColor:colour];
    class_val.textAlignment = NSTextAlignmentLeft;
    class_val.userInteractionEnabled=YES;
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    class_val.text=NSLPC;
    class_val.layer.cornerRadius=10;
    [class_val setClipsToBounds:YES];
    
    UITapGestureRecognizer *tapGesture6=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectClass:)];
    tapGesture6.delegate=self;
    tapGesture6.numberOfTapsRequired=1;
    [class_val addGestureRecognizer:tapGesture6];
    
    //Application Status
    
    NSString *NSLapplication_Status = [NSString stringWithFormat:NSLocalizedString(@"Applicant Status", nil)];
    application_Status=[[UILabel alloc]initWithFrame:CGRectMake(45,5,140,40)];
    [application_Status setTextColor:[UIColor blackColor]];
    [application_Status setFont:[UIFont boldSystemFontOfSize:12]];
    [application_Status setText:NSLapplication_Status];
    application_Status.numberOfLines=2;
    //[exercise_Lable setFont:boldFont];
    [application_Status setTextAlignment:NSTextAlignmentLeft];
    
    NSLapplication_Status = [NSString stringWithFormat:NSLocalizedString(@"Individual", nil)];
    NSLapplication_Status = [NSString stringWithFormat:@"%@",NSLapplication_Status];
    application_Status_val = [[UILabel alloc]initWithFrame:CGRectMake(175,5,[[UIScreen mainScreen]bounds].size.width-215,35)];
    application_Status_val.userInteractionEnabled=YES;
    [application_Status_val setTextColor:[UIColor blackColor]];
   // [application_Status_val setBackgroundColor:colour];
    application_Status_val.textAlignment=NSTextAlignmentLeft;
    application_Status_val.userInteractionEnabled=YES;
    application_Status_val.text = NSLapplication_Status;
     application_Status_val.layer.cornerRadius=5;
    [application_Status_val setClipsToBounds:YES];
    
    UITapGestureRecognizer *tapGesture7=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAS:)];
    tapGesture7.delegate=self;
    tapGesture7.numberOfTapsRequired=1;
    [application_Status_val addGestureRecognizer:tapGesture7];
    
    CGSize is;
    is.height = 120;
    is.width  = 130;
    
    UIImage *imagp =[self imageResize:image1 andResizeTo:is];
    
    imageview.backgroundColor = [UIColor colorWithPatternImage:imagp];
    
    NSSelectoption = [NSString stringWithFormat:NSLocalizedString(@"Select Option", nil)];
    NSCancel       = [NSString stringWithFormat:NSLocalizedString(@"Cancel", nil)];
}


-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

-(void)backJump
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    FlagDateArrow=@"NO";
    imageview.image = imageviewF.image;
}

#pragma mark DateSelection
-(void)DAteSelection
{
    [self.view endEditing:YES];
    [pView removeFromSuperview];
  
    //OLD  pView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-320/2,self.view.frame.size.height/2-240/2,320,240)];
    pView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-320/2,self.view.frame.size.height-240,320,240)];
    [pView setBackgroundColor:[UIColor lightGrayColor]];
    //    pView.layer.cornerRadius = 5;
    //    pView.layer.masksToBounds = YES;
    [self.view addSubview:pView];
    
  //   [logoArrowImageView2 setHidden:YES];

    //Cancel Btn
    cancel_Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,100,30)];
    
    [cancel_Btn addTarget:self action:@selector(selectedOption_date:) forControlEvents:UIControlEventTouchUpInside];
    [cancel_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel_Btn setBackgroundColor:colour];
    [cancel_Btn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
   // [cancel_Btn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancel_Btn.tag=101;
    
    //DAteLabel
 
    //DView
    dView=[[UIView alloc]initWithFrame:CGRectMake(3,30,pView.frame.size.width-7,200)];
    [dView setBackgroundColor:[UIColor whiteColor]];
    [pView addSubview:dView];
    
    //Done Btn
    Done_Btn=[[UIButton alloc]initWithFrame:CGRectMake((pView.frame.size.width-100),0, 100,30)];
    [Done_Btn addTarget:self action:@selector(selectedOption_date:) forControlEvents:UIControlEventTouchUpInside];
    [Done_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Done_Btn setBackgroundColor:colour];
    Done_Btn.tag=102;
    [Done_Btn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
   // [Done_Btn setTitle:@"Done" forState:UIControlStateNormal];
    
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,0,(pView.frame.size.width-200),30)];
    [dateLabel setText:NSLSDD];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [pView addSubview:dateLabel];
    
    //DAte Picker
    datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,pView.frame.size.width,180)];
    
    ///setting Date Limits here
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:0];
    
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [ datePicker setMaximumDate:maxDate];
    [comps setYear:-120];
    
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [datePicker setMinimumDate:minDate];
    
    
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
    if(sender.tag==101)
    {
        NSLog(@"NSLSDD :: %@",NSLSDD);
        select_Date_label.text=NSLSDD;
        [pView removeFromSuperview];
    }
    else
    {
        [logoArrowImageView2 setHidden:YES];
        FlagDateArrow=@"YES";

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
        
        NSLog(@"NSLSDD :: %@",strDate);
        
        // Calculate Age from birthdate Entered
        
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate* birthday = [dateFormat dateFromString:strDate];
        NSLog(@"Birthday Date :: %@",birthday);
       
        NSDate* now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                           components:NSCalendarUnitYear
                                           fromDate:birthday
                                           toDate:now
                                           options:0];
       calculate_age = [ageComponents year];
        
       NSLog(@"Calculated Age :: %ld",(long)calculate_age);
       
        select_Date_label.text=strDate;
         [pView removeFromSuperview];
    }
}

#pragma mark -- Image selection code :: -

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

-(void)selectNCD:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSSelectoption delegate:self cancelButtonTitle:NSCancel destructiveButtonTitle:nil otherButtonTitles:@"0",
                          @"10",
                          @"20",
                          @"30",
                          @"40",
                          @"50",
                          @"60",
                            nil];
    popup.tag = 2;
    [popup showInView:self.view];
}

-(IBAction)selectImage:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Select Option", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Select Gallery Image", nil),NSLocalizedString(@"Take Photo", nil),
                            nil];
    popup.tag = 1;
    [popup showInView:self.view];
}

-(IBAction)selectClass:(id)sender
{
    [self.view endEditing:YES];
    
      NSString *NSLPC = [NSString stringWithFormat:NSLocalizedString(@"Private Car", nil)];
    
      NSString *NSLV = [NSString stringWithFormat:NSLocalizedString(@"Van", nil)];
    
      NSString *NSLMC = [NSString stringWithFormat:NSLocalizedString(@"Motorcycle", nil)];
    
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSSelectoption delegate:self cancelButtonTitle:NSCancel destructiveButtonTitle:nil otherButtonTitles:NSLPC,
                          NSLV,NSLMC,
                          nil];
    popup.tag = 4;
    [popup showInView:self.view];
}

-(IBAction)selectAS:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *NSLI = [NSString stringWithFormat:NSLocalizedString(@"Individual", nil)];
    
    NSString *NSLCOM = [NSString stringWithFormat:NSLocalizedString(@"Company", nil)];
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSSelectoption delegate:self cancelButtonTitle:NSCancel destructiveButtonTitle:nil otherButtonTitles:
                            NSLI,
                            NSLCOM,
                            nil];
    popup.tag = 5;
    [popup showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
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
    else if(popup.tag==2)
    {           switch (buttonIndex)
        {
            case 0:
                NoClaimsDiscount_val.text=@" 0";
                NCD_Actual_Val.text=@" 0";
               // [logoArrowImageView3 setHidden:YES];
                break;
            case 1:
                NoClaimsDiscount_val.text=@"10";
                NCD_Actual_Val.text=@"10";
              //  [logoArrowImageView3 setHidden:YES];

                break;
            case 2:
                NoClaimsDiscount_val.text=@"20";
                NCD_Actual_Val.text=@"20";
               // [logoArrowImageView3 setHidden:YES];

                break;
            case 3:
                NoClaimsDiscount_val.text=@"30";
                NCD_Actual_Val.text=@"30";
               // [logoArrowImageView3 setHidden:YES];

                break;
            case 4:
                NoClaimsDiscount_val.text=@"40";
                NCD_Actual_Val.text=@"40";
               // [logoArrowImageView3 setHidden:YES];

                break;
            case 5:
                NoClaimsDiscount_val.text=@"50";
                NCD_Actual_Val.text=@"50";
                //[logoArrowImageView3 setHidden:YES];

                break;
            case 6:
                NoClaimsDiscount_val.text=@"60";
                NCD_Actual_Val.text=@"60";
                //[logoArrowImageView3 setHidden:YES];

                break;
            default:
                break;
        }
    }
    else if(popup.tag==3)
    {
        switch (buttonIndex)
        {
            case 0:
                bodytype_val.text=@"Convertible";
                // NCD_Actual_Val.text=@"0";
                break;
            case 1:
                bodytype_val.text=@"HatchBack";
                //NCD_Actual_Val.text=@"10";
                break;
            case 2:
                bodytype_val.text=@"Saloon";
                // NCD_Actual_Val.text=@"20";
                break;
            case 3:
                bodytype_val.text=@"Sports";
                break;
            case 4:
                bodytype_val.text=@"Station Wagon";
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
                class_val.text=NSLPC;
                break;
            case 1:
                class_val.text=NSLV;
                break;
            case 2:
                class_val.text=NSLMC;
                break;

            default:
                break;
        }
      
    }
    else if(popup.tag == 5)
    {
        NSString *NSLI = [NSString stringWithFormat:NSLocalizedString(@"Individual", nil)];
        
        NSString *NSLCOM = [NSString stringWithFormat:NSLocalizedString(@"Company", nil)];
        
        switch (buttonIndex)
        {
            case 0:
                application_Status_val.text=NSLI;
                //[logoArrowImageView setHidden:YES];

                break;
            case 1:
                application_Status_val.text=NSLCOM;
               // [logoArrowImageView setHidden:YES];

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
    photo = [AlbumClass imageWithMediaInfo:info];
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //Do not delete this block
    [UIView animateWithDuration:50.0
                     animations:^{
                      
                         self.navigationController.navigationBarHidden = NO;
                         self.imageview.image = photo;
                         
                         ImageFlag=YES;
                         
                     } completion:^(BOOL finished) {
                         
                         if ([UIScreen mainScreen].bounds.size.height == 480)
                         {
                         }
                         //                         [pickerView removeFromSuperView];
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
    
    self.imageview.image = photo;
    ImageFlag = YES;
      [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraWillTakePhoto
{
    ImageFlag = YES;
    
    //NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark ----- UITableView Delegate & Datasource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        return 21;
    }
    else
    {
        return 21;
    }
   return 21;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cell Identifier
    static NSString *cellIdentifier = @"simpleIdentifier";
    UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cells = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    [cells setBackgroundColor:lightgraycolor];
    
    static NSString *cellIdentifier1 = @"cellIdentifier";
    cell = (carRegistrationCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    
    cell = [[carRegistrationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
    
    UIColor *colour1 = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    [cell setBackgroundColor:lightgraycolor];
    
    cell.name_textfield.delegate=self;
    
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str;
    
    if(indexPath.row <= 10)
    {
        str = [NSString stringWithFormat:@"%@",[userDetails objectAtIndex:indexPath.row]];
      
    }
    
    if(indexPath.row==0)
    {    // 117
        NSString *COI = [NSString stringWithFormat:NSLocalizedString(@"Car Owner Information", nil)];
        NSString *COIF = [NSString stringWithFormat:@" -------- %@ --------",COI];
        
        UILabel  * heading11=[[UILabel alloc]initWithFrame:CGRectMake(0,7,[[UIScreen mainScreen] bounds].size.width-30,40)];
        [heading11 setTextColor:colour];
        [heading11 setFont:[UIFont boldSystemFontOfSize:14]];
        //[heading1 setText:@"Upload Vehical Sheet"];
        [heading11 setTextAlignment:NSTextAlignmentLeft];
        
        [heading11 setText:COI];
        [cells.contentView addSubview:heading11];
       // [cells.contentView addSubview:arrow_imageview];
        
        // cells.textLabel.text=@"  ---- Car Owner Information ----";
        //cells.textLabel.textColor= colour1;
        [cells setBackgroundColor:[UIColor whiteColor]];
        
        return cells;
    }
    else if(indexPath.row==1)
    {
        UIImageView  *logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(1,7, 42, 36)];
        [logoImageView setImage:[UIImage imageNamed:@"icon14-48.png"]];
        [cells.contentView addSubview:logoImageView];
        
        
        [application_Status_val setBackgroundColor:[UIColor whiteColor]];
        [cells.contentView addSubview:application_Status];
        [cells.contentView addSubview:application_Status_val];
        
        logoArrowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(245,15,15,15)];
        [logoArrowImageView setImage:[UIImage imageNamed:@"arrow1.png"]];
        //[cells.contentView addSubview:logoArrowImageView];
        
        application_Status_val.tag=111;
        return cells;
        //        cell.name_Label.text = @"Application Status";
        //        [cell.name_textfield setPlaceholder:@"Individual"];
        //        cell.name_textfield.text = @"Individual";
        //        cell.name_textfield.tag = 118;
        
        if([str isEqualToString:@""])
        {
            NSString *Ind = [NSString stringWithFormat:NSLocalizedString(@"Individual", nil)];
            cell.name_textfield.text = Ind;
        }
        else
        {
            application_Status_val.text = str;
        }
        
        return cell;
        
    }
    else if(indexPath.row==2)
    {
        //119
        logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(6,7,30, 35)];
        [logoImageView setImage:[UIImage imageNamed:@"icon2-48.png"]];
        [cells.contentView addSubview:logoImageView];
        
        
        [select_Date_label setBackgroundColor:[UIColor whiteColor]];
        [cells.contentView addSubview:select_Date_label];
        [cells.contentView addSubview:datelabel];
        
        logoArrowImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(245,15,15,15)];
        [logoArrowImageView2 setImage:[UIImage imageNamed:@"arrow1.png"]];
        //[cells.contentView addSubview:logoArrowImageView2];
        

        if([FlagDateArrow isEqualToString:@"YES"])
        {
            [logoArrowImageView2 setHidden:YES];
        }
        else
        {
            [logoArrowImageView2 setHidden:NO];

        }
        
        select_Date_label.tag=112;
        return cells;
    }
    else if(indexPath.row==3)
    {   //120
        NSString *Ind = [NSString stringWithFormat:NSLocalizedString(@"Job Industry", nil)];
        cell.name_Label.text = Ind;
        [cell.name_textfield setPlaceholder: @"Banking"];
        cell.name_textfield.tag=113;
        [cell.logoImageView setImage: [UIImage imageNamed:@"icon6-48.png"]];
        
        if([str isEqualToString:@""])
        {}
        else
        {
            cell.name_textfield.text = str;
        }
        
        return cell;
    }
    else if(indexPath.row==4)
    {   // 121
        logoImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(5,2, 32, 32)];
        [logoImageView2 setImage:[UIImage imageNamed:@"icon4-48.png"]];
        [cells.contentView addSubview:logoImageView2];
        
        logoArrowImageView3=[[UIImageView alloc]initWithFrame:CGRectMake(245,15,15,15)];
        [logoArrowImageView3 setImage:[UIImage imageNamed:@"arrow1.png"]];
       // [cells.contentView addSubview:logoArrowImageView3];
        
        cell.name_Label.text = @"No Claims Discount (NCD)";
        [cell.name_textfield setPlaceholder: @"10"];
        cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
        
        NoClaimsDiscount_val.tag=114;
        
        [NoClaimsDiscount_val setBackgroundColor:[UIColor whiteColor]];

        
        [cells.contentView addSubview:NoClaimsDiscount];
        [cells.contentView addSubview:NoClaimsDiscount_val];
        return cells;
        
        if([str isEqualToString:@""])
        {}
        else
        {
          cell.name_textfield.text = str;
        }
        return cell;
    }
    else if(indexPath.row==5)
    {   //122
        NSString *Ind = [NSString stringWithFormat:NSLocalizedString(@"Driving Exp(Years)", nil)];
        cell.name_Label.text =Ind;
        [cell.name_textfield setPlaceholder:@""];
        cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
        cell.name_textfield.tag=115;
        [cell.logoImageView setImage: [UIImage imageNamed:@"icon12-48.png"]];
        
        UIImageView  *logoDownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(245,15,15,15)];
        [logoDownArrow setImage:[UIImage imageNamed:@"arrow1.png"]];
        [cells.contentView addSubview:logoDownArrow];

        if([str isEqualToString:@""])
        { }
        else
        {
          cell.name_textfield.text = str;
        }
        return cell;
    }
    else if(indexPath.row==6)
    {    //123
        NSString *JP = [NSString stringWithFormat:NSLocalizedString(@"Job Position", nil)];
        cell.name_Label.text = JP;
        JP = [NSString stringWithFormat:NSLocalizedString(@"Tailer", nil)];
        [cell.name_textfield setPlaceholder: @"Tailer"];
        cell.name_textfield.tag=116;
        
        NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
        
        [cell.logoImageView setImage: [UIImage imageNamed:@"icon15-48.png"]];
        
        if([strc isEqualToString:@"Comprehensive"])
        {
            
        }
        else
        {
            cell.name_textfield.returnKeyType=UIReturnKeyDone;
        }
        
        if([str isEqualToString:@""])
        {
            
        }
        else
        {
            cell.name_textfield.text = str;
        }
        
        return cell;
    }
    else if(indexPath.row==7)
    {    // 124
        //      cells.textLabel.text=@"          ---- Coverage Type ----";
        //      cells.textLabel.textColor=colour1;
        //      [cells.textLabel setTextAlignment:NSTextAlignmentCenter];
        NSString *COI = [NSString stringWithFormat:NSLocalizedString(@"Coverage Type", nil)];
        NSString *COIF = [NSString stringWithFormat:@" -------- %@ --------",COI];
        
        
        
        [cells setBackgroundColor:[UIColor whiteColor]];
        
        UILabel  * heading111=[[UILabel alloc]initWithFrame:CGRectMake(20,0,[[UIScreen mainScreen] bounds].size.width-30,40)];
        [heading111 setTextColor:colour];
        [heading111 setFont:[UIFont boldSystemFontOfSize:14]];
        //[heading1 setText:@"Upload Vehical Sheet"];
        [heading111 setTextAlignment:NSTextAlignmentLeft];
        
        [heading111 setText:COI];
        [cells.contentView addSubview:heading111];
        
        return cells;
    }
    else if(indexPath.row==8)
    {   // 125
        NSString *IT = [NSString stringWithFormat:NSLocalizedString(@"Insurance Type", nil)];
        cell.name_Label.text = IT;
        [cell.name_textfield setFont:[UIFont boldSystemFontOfSize:10]];
        
        // [cell.name_textfield setPlaceholder: @"Comprehensive"];
        // cell.name_textfield.text = @"Comprehensive";
        cell.name_textfield.tag=118;
        
        [cell.logoImageView setImage: [UIImage imageNamed:@"icon13-48.png"]];
        if([str isEqualToString:@""])
        {
            NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
            [cell.name_textfield setTextColor:[UIColor blackColor]];

            cell.name_textfield.text = NSLocalizedString(strc, nil);
            
        }
        else
        {
            NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policyselected"]];
            //NSLog(@"Third Party TEST ::%@",strc);
            [cell.name_textfield setTextColor:[UIColor blackColor]];

            cell.name_textfield.text = NSLocalizedString(strc, nil);
            
        }
        cell.name_textfield.enabled = NO;
        return cell;
    }
    else if(indexPath.row==9)
    {   //126
        NSString *COI = [NSString stringWithFormat:NSLocalizedString(@"Sum Insured", nil)];
        NSString *COIF = [NSString stringWithFormat:@"%@",COI];
        
        cell.name_Label.text =COIF;
        [cell.name_textfield setPlaceholder: @"300000"];
        cell.name_textfield.returnKeyType=UIReturnKeyDone;
        // cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
        cell.name_textfield.tag=119;
        // icon11-48.png
        
        NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
        
        if([strc isEqualToString:@"Comprehensive"])
        {                [cell.name_textfield setTextColor:[UIColor blackColor]];

            [cell.logoImageView setImage: [UIImage imageNamed:@"icon11-48.png"]];
            if([str isEqualToString:@""])
            {}
            else
            {
//                [cell.name_textfield setTextColor:[UIColor blackColor]];
                cell.name_textfield.text = NSLocalizedString(str, nil);
            }
        }
        else
        {
            [cells setBackgroundColor:[UIColor whiteColor]];
            [cells.contentView addSubview:nextBtn];
            return cells;
        }
        
        return cell;
    }
    else if(indexPath.row==10)
    {  // 127
        
        
        NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
        
        if([strc isEqualToString:@"Comprehensive"])
        {
            [cells setBackgroundColor:[UIColor whiteColor]];
            [cells.contentView addSubview:nextBtn];
        }
        else
        {
            //[cells.contentView addSubview:nextBtn];
            //return cell;
        }
    }
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cells setBackgroundColor:[UIColor whiteColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cells;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if(indexPath.row==7)
    {
        return 40;
    }
    else if(indexPath.row==0)
    {
        return 45;
    }
    else if(indexPath.row==7)
    {
        return 45;
    }
    // your dynamic height...
    return 48;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    int m = indexPath.row;
    carRegistrationCell *cell = [[carRegistrationCell alloc]init];
    
    if(indexPath.row==0||indexPath.row==14||indexPath.row==17||indexPath.row==7)
    {
        [textcontaint addObject:@" "];
    }
    else if(indexPath.row==1)
    {
        UILabel * textField = (UILabel *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
    }
    else if(indexPath.row==2)
    {
        UILabel * textField = (UILabel *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
    }
    else if(indexPath.row==3)
    {
        UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
    }
    else if(indexPath.row==4)
    {
        UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
    }
    else if(indexPath.row==5)
    {
        UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
    }
    else if(indexPath.row==6)
    {
        UILabel * textField = (UILabel *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
    }
    else if(indexPath.row==8)
    {
        UILabel * textField = (UILabel *)[self.carTableview viewWithTag:110+indexPath.row];
        NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
        [textcontaint addObject:strr];
        //NSLog(@"TExtfield 8 :: %@ Strr :: %@",textField,strr);
    }
    else if(indexPath.row==9)
    {
        NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
        //NSLog(@"Insurance Type SUM_Insured");
        
        if([strc isEqualToString:@"Comprehensive"])
        {
            UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
            NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
            [textcontaint addObject:strr];
        }
        else
        {
            [textcontaint addObject:@""];
        }
    }
}


+ (NSString *)extractNumberFromText:(NSString *)text
{
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[text componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}


#pragma mark ********* WB Car Registration information *********

-(void)Upload_car_Information
{
    [self.view setUserInteractionEnabled:NO];
    
    nextBtn.userInteractionEnabled = NO;
    // [indicator startAnimating];
    //NSLog(@"USerDeatails ::%@",userDetails);
    textcontaint = [[NSMutableArray alloc]init];
    
    for(int index=0;index<11;index++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:carTableview didSelectRowAtIndexPath:path];
    }
    
    //NSLog(@"textcontaint :: %@",textcontaint);
    
    NSString *trimmed;
    
    NSString *classstr=classvalF;
    trimmed = [classstr stringByReplacingOccurrencesOfString: @" "
                                                  withString: @""
                                                     options: NSRegularExpressionSearch
                                                       range: NSMakeRange(0, classstr.length)];
    classstr=trimmed;
    
    NSString *vehical_name=makeTextF;
    trimmed = [vehical_name stringByReplacingOccurrencesOfString: @" "
                                                      withString: @""
                                                         options: NSRegularExpressionSearch
                                                           range: NSMakeRange(0, vehical_name.length)];
    vehical_name=trimmed;
    
  //  NSData *dataenc = [vehical_name dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//    vehical_name = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    
    NSString *vehical_model=modelTextF;
    trimmed = [vehical_model stringByReplacingOccurrencesOfString: @" "
                                                       withString: @""
                                                          options: NSRegularExpressionSearch
                                                            range: NSMakeRange(0, vehical_model.length)];
    vehical_model=trimmed;
    
//      dataenc = [vehical_model dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//    vehical_model = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    
    
    NSString *year_of_manufacture=yearTextF;
    trimmed = [year_of_manufacture stringByReplacingOccurrencesOfString: @" "
                                                             withString: @""
                                                                options: NSRegularExpressionSearch
                                                                  range: NSMakeRange(0, year_of_manufacture.length)];
    year_of_manufacture=trimmed;
    
    NSString *engine_capacity=engineCapacityTextF;
    
    trimmed = [engine_capacity stringByReplacingOccurrencesOfString: @" "
                                                         withString: @""
                                                            options: NSRegularExpressionSearch
                                                              range: NSMakeRange(0, engine_capacity.length)];
    engine_capacity=trimmed;
    
    
    //Vehicle Body Type
    NSString *vehicle_bodyType=bodytypeValF;
    trimmed = [vehicle_bodyType stringByReplacingOccurrencesOfString: @" "
                                                          withString: @""
                                                             options: NSRegularExpressionSearch
                                                               range: NSMakeRange(0, vehicle_bodyType.length)];
    vehicle_bodyType=trimmed;
    
    // Appllicant Status
    NSString *applicant_status=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:1]];
    trimmed = [applicant_status stringByReplacingOccurrencesOfString: @" "
                                                          withString: @""
                                                             options: NSRegularExpressionSearch
                                                               range: NSMakeRange(0, applicant_status.length)];
    applicant_status=trimmed;
    
    
    //Date of Birth
    NSString *date_of_birth;
    NSString *datec=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:2]];
    
    if([datec isEqualToString:@"Select Date"])
    {
        date_of_birth = @"Select Date";
    }
    else if([datec isEqualToString:@"選擇"])
    {
      date_of_birth=@"選擇";
    }
    else
    {
        date_of_birth = datec;
    }
    
    //Job Industry
    NSString *job_industry=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:3]];
    trimmed = [job_industry stringByReplacingOccurrencesOfString: @" "
                                                      withString: @""
                                                         options: NSRegularExpressionSearch
                                                           range: NSMakeRange(0, job_industry.length)];
    job_industry=trimmed;
    
   //   dataenc = [job_industry dataUsingEncoding:NSNonLossyASCIIStringEncoding];
   // job_industry = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Job Industry :: %@ :: DAteenc ::",job_industry);
    
    //NO Claim Discount
    NSString *myString = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:4]];
    NSString *mySmallerString;
    if([myString isEqualToString:@" 0"])
    {
        mySmallerString = @"0";
        trimmed = [mySmallerString stringByReplacingOccurrencesOfString: @" "
                                                             withString: @""
                                                                options: NSRegularExpressionSearch
                                                                  range: NSMakeRange(0, mySmallerString.length)];
        mySmallerString=trimmed;
    }
    else
    {
        mySmallerString = [myString substringToIndex:2];
        trimmed = [mySmallerString stringByReplacingOccurrencesOfString: @" "
                                                             withString: @""
                                                                options: NSRegularExpressionSearch
                                                                  range: NSMakeRange(0, mySmallerString.length)];
        mySmallerString=trimmed;
    }
    
    NSString *no_claim_discount = mySmallerString;
    
    //Driving Expiry
    NSString *driving_expiry=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:5]];
    trimmed = [driving_expiry stringByReplacingOccurrencesOfString: @" "
                                                        withString: @""
                                                           options: NSRegularExpressionSearch
                                                             range: NSMakeRange(0, driving_expiry.length)];
    driving_expiry=trimmed;
    
    //Job Position
    NSString *job_position=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:6]];

    trimmed = [job_position stringByReplacingOccurrencesOfString: @" "
                                                      withString: @""
                                                         options: NSRegularExpressionSearch
                                                           range: NSMakeRange(0, job_position.length)];
   job_position = trimmed;

//  dataenc = [job_position dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//  job_position = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];

    //NSLog(@"Text Constraint :: %@ JOb Position :: %@ ",[textcontaint objectAtIndex:7],job_position);
    
    //Sum insured
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    NSString *sum_insured;
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        sum_insured=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:9]];
        trimmed = [sum_insured stringByReplacingOccurrencesOfString: @" "
                                                         withString: @""
                                                            options: NSRegularExpressionSearch
                                                              range: NSMakeRange(0, sum_insured.length)];
        sum_insured=trimmed;
    }
    else
    {
        sum_insured=@"0";
    }
    
    NSData *imageData = UIImageJPEGRepresentation(imageview.image, 90);
    
    NSString *user_id =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];
    
    NSString *policy_id;
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        policy_id=@"1";
    }
    else
    {
        policy_id=@"2";
    }
    
   BOOL Network=[self Reachability_To_Chechk_Network];
    
    
   if(Network)
    {
      if([SimageFlag isEqualToString:@"YES"])
        {
         if(applicant_status.length>0 && job_industry.length>0 && no_claim_discount.length>0 && driving_expiry.length>0&&job_position.length>0 && sum_insured.length>0)
            {
     NSString *urlString;
   
      if(![date_of_birth isEqualToString:@"Select Date"] && ![date_of_birth isEqualToString:@"選擇"])
            {
                 NSString  * urljobIndustry = job_industry ;
                
//    NSData *dataenc = [urljobIndustry dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//    urljobIndustry = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
//                
                
                                NSString * urljobposition = job_position ;
//                dataenc = [job_position dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                urljobposition = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
//                
                
                                NSString * applicant_status1 = applicant_status ;
               
//                dataenc = [applicant_status1 dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                applicant_status1 = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
//                
                               NSString  * lclass = classstr ;
                
//                dataenc = [lclass dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                lclass = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                
                                NSString * lmodel = vehical_model ;
                
                
//                dataenc = [lmodel dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                lmodel = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                
                
                 NSString * lmake = vehical_name ;
                
                
//                dataenc = [lmake dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                lmake = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                
                NSString  * lYOM = year_of_manufacture ;
                
                
//                dataenc = [lYOM dataUsingEncoding:NSNonLossyASCIIStringEncoding];
//                lYOM = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
                
                NSString * lEC = engine_capacity ;

                        urlString = [NSString stringWithFormat:@"%@create_policy_ios.php?",kAPIEndpointLatestPath];
                  
            //NSLog(@"urlString :: %@ Image length :: %d",urlString,imageData.length);
                    
                    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
                    self.indicator.center = self.view.center;
                    self.indicator.color=[UIColor whiteColor];
                    self.indicator.layer.cornerRadius=10;
                    [self.indicator setBackgroundColor:maincolor];
                    self.indicator.layer.zPosition++;
                    self.indicator.layer.zPosition++;
                    
                    [self.indicator startAnimating];
                    [self.view addSubview:indicator];
                    
                    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
                    
                    [myQueue addOperationWithBlock:^{

                        NSString *returnString;
                        NSData *returnData;
                        
                        
                        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                        [request setURL:[NSURL URLWithString:urlString]];
                        [request setHTTPMethod:@"POST"];
                        
                        NSString *boundary = @"---------------------------14737809831466499882746641449";
                        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                        
                        NSMutableData *body = [NSMutableData data];
                        
                        // NSString *user_id=@"USer";// = userID;
                        //NSLog(@"user_id :: %@",user_id);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:user_id] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  policy_id
                        //NSLog(@"policy_id :: %@",policy_id);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"policy_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:policy_id] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  applicant_status
                        //NSLog(@"applicant_status :: %@",applicant_status);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"applicant_status\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:applicant_status1] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  no_claim_discount
                        //NSLog(@"no_claim_discount :: %@",no_claim_discount);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"no_claim_discount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:no_claim_discount] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  date_of_birth
                        //NSLog(@"date_of_birth :: %@",date_of_birth);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"date_of_birth\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:date_of_birth] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  driving_expiry
                        //NSLog(@"driving_expiry :: %@",driving_expiry);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"driving_expiry\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:driving_expiry] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  job_industry
                        //NSLog(@"job_industry :: %@",urljobIndustry);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"job_industry\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:urljobIndustry] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  job_position
                        //NSLog(@"job_position :: %@",urljobposition);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"job_position\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:urljobposition] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  sum_insured
                        //NSLog(@"sum_insured :: %@",sum_insured);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sum_insured\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:sum_insured] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                              //  classstr
                        //NSLog(@"classstr :: %@",lclass);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"class\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:lclass] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  vehical_name
                        //NSLog(@"vehical_name :: %@",lmake);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehical_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:lmake] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  vehical_model
                        //NSLog(@"vehical_model :: %@",lmodel);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehical_model\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:lmodel] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  year_of_manufacture
                        //NSLog(@"year_of_manufacture :: %@",lYOM);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"year_of_manufacture\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:lYOM] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  engine_capacity
                        //NSLog(@"engine_capacity :: %@",lEC);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"engine_capacity\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:lEC] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        //  vehicle_bodyType
                        //NSLog(@"vehicle_bodyType :: %@",vehicle_bodyType);
                        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehicle_bodyType\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:vehicle_bodyType] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        ////New Fields End ------
                        
                     ///Pic para
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[NSData dataWithData:imageData]];
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        
                        [request setHTTPBody:body];
                        
                        returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                        //NSLog(@"Return Data :: %@",returnData);
                        
                        returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            // Main thread work (UI usually)
                     if(returnString.length>6)
                            {
                                
                                NSDictionary *jsonObject=[NSJSONSerialization
                                                          JSONObjectWithData:returnData
                                                          options:NSJSONReadingMutableLeaves
                                                          error:nil];
                                //NSLog(@"JS :: %@",jsonObject);
                                //NSLog(@"Return Data :: %@",returnString);
                                
                                NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
                                //      [indicator stopAnimating];
                                if([str isEqualToString:@"Success"])
                                {
                                    [self.indicator setHidden:YES];
                                    
                                    [self.indicator removeFromSuperview];
                                        [self.view setUserInteractionEnabled:YES];
                                    ImageFlag=NO;
                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Policy Creation Success Msg", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                                    [alert show];
                                    
                                    str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"quotation_id"]];
                                    
                                    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"QuotationID"];
                                    [[NSUserDefaults standardUserDefaults]synchronize];
                                    
                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                    MainVC  *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
                                    [self.navigationController pushViewController:rootController animated:YES];
                                    // [self performSegueWithIdentifier:@"CTOP" sender:self];
                                }
                                else
                                {
                                    // [self.indicator removeFromSuperview];
                                    [self.indicator setHidden:YES];
                                    [self.indicator removeFromSuperview];
                                        [self.view setUserInteractionEnabled:YES];
                                    NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                                    
                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                                    [alert show];
                                    
//                                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                                    [alert show];
                                }
                            }
                            else
                            {
                                [self.indicator setHidden:YES];
                                    [self.view setUserInteractionEnabled:YES];
                                [self.indicator removeFromSuperview];
                                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                                [alert show];
                            }
                            
                        }];
                    }];
                }
                else //DAte
                {
                        [self.view setUserInteractionEnabled:YES];
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please select Date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                    [alert show];
                }
            }
            else //Fields Check
            {
                 
                //[self.indicator removeFromSuperview];
                    [self.view setUserInteractionEnabled:YES];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Enter Car Owner & coverage type fields", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }
        }
        else  // Without Image Code Else Part
        {
            if(![date_of_birth isEqualToString:@"Select Date"]&& ![date_of_birth isEqualToString:@"選擇"])
            {
                if(classstr.length>0&&vehical_name.length>0&&vehical_model.length>0&&year_of_manufacture.length>0&&engine_capacity.length>0&&vehicle_bodyType.length>0&&applicant_status.length>0&&job_industry.length>0 && no_claim_discount.length>0&&driving_expiry.length>0&&job_position.length>0&&sum_insured.length>0)
                {
                    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    self.indicator.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2, ([[UIScreen mainScreen] bounds].size.height+210), 80.0, 80.0);
                    self.indicator.center = self.view.center;
                    self.indicator.color=[UIColor whiteColor];
                    self.indicator.layer.cornerRadius=10;
                    [self.indicator setBackgroundColor:maincolor];
                    self.indicator.layer.zPosition++;
                    [self.indicator startAnimating];
                    [self.view addSubview:indicator];
                    
                    NSString *urlString;
                    // NSString  *photo_pics=@"";
                    
                    urlString = [NSString stringWithFormat:@"%@create_policy_data_ios.php",kAPIEndpointLatestPath];
                    
                    // Code 2
                    NSDictionary *userNameDict = @{@"user_id" : user_id,
                                                   @"class" : classstr,
                                                   @"year_of_manufacture" : year_of_manufacture,
                                                   @"vehical_name" : vehical_name,
                                                   @"engine_capacity" : engine_capacity,
                                                   @"vehicle_bodyType" : vehicle_bodyType,
                                                   @"applicant_status" : applicant_status,
                                                   @"no_claim_discount" : no_claim_discount,
                                                   @"date_of_birth" : date_of_birth,
                                                   @"driving_expiry" : driving_expiry,
                                                   @"job_industry" : job_industry,
                                                   @"job_position" : job_position,
                                                   @"sum_insured" : sum_insured,
                                                   @"policy_id" : policy_id,
                                                   @"vehical_model" : vehical_model
                                                   };
                    NSError  *error;
                    //NSLog(@"userNameDict REviewcalled :: %@",userNameDict);
                    
                    NSData   *post = [NSJSONSerialization dataWithJSONObject:userNameDict options:0 error:&error];
                    NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:urlString]];
                    // set Request Type
                    [request2 setHTTPMethod:@"POST"];
                    // Set content-type
                    [request2 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
                    // Set Request Body
                    [request2 setHTTPBody:post];
                    
                    // Now send a request and get Response
                    NSData *returnData = [NSURLConnection sendSynchronousRequest: request2 returningResponse: nil error: nil];
                    // Log Response
                    NSString *response2 = [[NSString alloc]initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
                    //NSLog(@"Postdata to server :: %@",response2);
                    
                    NSDictionary *jsonObject = [NSJSONSerialization
                                                JSONObjectWithData:returnData
                                                options:NSJSONReadingMutableLeaves
                                                error:nil];
                    
                    //NSLog(@"JSF Object :: %@",jsonObject);
                    
                    NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey
                                                                    :@"result"]];
                    //  {"result":"Success","quotation_id":56}
                    
                    if([str isEqualToString:@"Success"])
                    {
                            [self.view setUserInteractionEnabled:YES];
                        ImageFlag=NO;
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Policy Creation Success Msg", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                        [alert show];
                        
                        str = [NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"quotation_id"]];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"QuotationID"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        MainVC  *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
                        [self.navigationController pushViewController:rootController animated:YES];
                        // [self performSegueWithIdentifier:@"CTOP" sender:self];
                    }
                    else  //
                    {
                            [self.view setUserInteractionEnabled:YES];
                       
                        NSString  *str11=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"response_message"]];
                        
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:str11 message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
                        [alert show];

//                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Something went wrong! please try again later.", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
//                        [alert show];
                    }
                }
                else /// DAta Param Else
                {
                        [self.view setUserInteractionEnabled:YES];
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please enter all the fields", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                    [alert show];
                }
            }
            else //DAte
            {
                    [self.view setUserInteractionEnabled:YES];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please select Date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }
        }  //ImageFlag else  closing Bracket
    }
    else  ///Network
    {
            [self.view setUserInteractionEnabled:YES];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"No Network Connection!", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
  
    nextBtn.userInteractionEnabled = YES;
}


-(void)call_profile_Detail_view_NCD_AGE_EXP
{
    
    textcontaint = [[NSMutableArray alloc]init];
    
    for(int index=0;index<11;index++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:carTableview didSelectRowAtIndexPath:path];
    }

    //Date of Birth
    NSString *date_of_birth;
    NSString *datec=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:2]];
    
    if([datec isEqualToString:@"Select Date"])
    {
        date_of_birth = @"Select Date";
    }
    else if([datec isEqualToString:@"選擇"])
    {
        date_of_birth=@"選擇";
    }
    else
    {
        date_of_birth = datec;
    }
    
    
    //NO Claim Discount
    NSString *Value_NCD = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:4]];
  
    
    UIButton *OKBtn;
    UIButton *cancelBtn;
    UILabel *drivingExp;
    UILabel *val_drivingExp;
    UILabel *age;
    UILabel *val_age;
    UILabel *dialogNo;
    UILabel *val_NCD;
    
    //    tvDrivingExp, tvAge,tvNCDTest,tvDialogNo,tvDialogYes
    [userView removeFromSuperview];
    [pView removeFromSuperview];
    
    userView=[[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 2)-120, ([UIScreen mainScreen].bounds.size.height / 2)-120 ,250,250)];
    //NSLog(@"PV::: %@",pView);
    [userView setBackgroundColor:[UIColor whiteColor]];
     userView.layer.borderWidth=2;
    userView.layer.cornerRadius = 2;
    userView.layer.masksToBounds = YES;
     [userView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    //[win addSubview:pView];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, userView.frame.size.width, 1)];
    [linelabel setBackgroundColor:[UIColor darkGrayColor]];
    //[userView addSubview:linelabel];
    
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(4,210,119,30)];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [cancelBtn setTag:101];
    cancelBtn.layer.cornerRadius = 5;
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(user_cancelcalled:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.borderWidth=2;
    [cancelBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [userView addSubview:cancelBtn];
    
    OKBtn=[[UIButton alloc]initWithFrame:CGRectMake(126, 210, 119, 30)];
    [OKBtn setBackgroundColor:[UIColor whiteColor]];
    [OKBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [OKBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
    OKBtn.layer.cornerRadius = 5;
    [OKBtn addTarget:self action:@selector(user_okcalled:) forControlEvents:UIControlEventTouchUpInside];
    [OKBtn setTag:102];
    OKBtn.layer.borderWidth=2;
    [OKBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [userView addSubview:OKBtn];
    
    
 //     maincolor = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
    //Title
    drivingExp=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 250,55)];
    [drivingExp setBackgroundColor:maincolor];
  //  drivingExp.layer.cornerRadius = 5;
    drivingExp.layer.masksToBounds = YES;
    drivingExp.textAlignment = NSTextAlignmentCenter;
    drivingExp.text=NSLocalizedString(@"YourDetails", nil);
    [drivingExp setTextColor:[UIColor whiteColor]];
    [userView addSubview:drivingExp];
//    [UIColor grayColor].CGColor
//    Kmaincolor
  
    //Driving Experience
    drivingExp=[[UILabel alloc]initWithFrame:CGRectMake(4,60, 119,40)];
    [drivingExp setBackgroundColor:[UIColor whiteColor]];
    drivingExp.layer.cornerRadius = 5;
    drivingExp.layer.masksToBounds = YES;
    drivingExp.textAlignment = NSTextAlignmentCenter;
    drivingExp.text=@"牌齡";  //Driving EXP
    [userView addSubview:drivingExp];
    
 //   Driving Exp=牌齡 8年AGE＝年齡 25歲NCD （NO NEED）NCD： 60%SHOULD HAVE ％
    
    //EXPERIENCE CAR DRIVING
    NSString *Driving_EXP = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:5]];
    
    NSInteger i = [Driving_EXP integerValue];
    
    if(i>1)
    {
       Driving_EXP = [NSString stringWithFormat:@"%@ 年",[textcontaint objectAtIndex:5]];
    }
    else{
      Driving_EXP = [NSString stringWithFormat:@"%@ 年",[textcontaint objectAtIndex:5]];
    }
    
    val_drivingExp=[[UILabel alloc]initWithFrame:CGRectMake(126,60, 119,40)];
    [val_drivingExp setBackgroundColor:[UIColor whiteColor]];
    val_drivingExp.layer.cornerRadius = 5;
    val_drivingExp.textAlignment = NSTextAlignmentLeft;
    val_drivingExp.layer.masksToBounds = YES;
    val_drivingExp.text=Driving_EXP;
    [userView addSubview:val_drivingExp];
    
    //Age Experience
    age =[[UILabel alloc]initWithFrame:CGRectMake(4,110, 119,40)];
    [age setBackgroundColor:[UIColor whiteColor]];
    age.layer.cornerRadius = 5;
    age.layer.masksToBounds = YES;
    age.textAlignment = NSTextAlignmentCenter;
    age.text=@"年齡";  //AGE
    [userView addSubview:age];
    
    
    //AGE
    NSString *cal_age;
    
    if(calculate_age>1)
    {
        cal_age =[NSString stringWithFormat:@"%ld 歲",(long)calculate_age];
    }
    else{
          cal_age=[NSString stringWithFormat:@"%ld 歲",(long)calculate_age];
    }
    
    
    val_age=[[UILabel alloc]initWithFrame:CGRectMake(126,110, 119,40)];
    [val_age setBackgroundColor:[UIColor whiteColor]];
    val_age.layer.cornerRadius = 5;
    val_age.textAlignment = NSTextAlignmentLeft;
    val_age.layer.masksToBounds = YES;
    val_age.text=cal_age;
    [userView addSubview:val_age];
    
    //NCD Value
    
    dialogNo=[[UILabel alloc]initWithFrame:CGRectMake(4,160, 119,40)];
    [dialogNo setBackgroundColor:[UIColor whiteColor]];
    dialogNo.layer.cornerRadius = 5;
    dialogNo.layer.masksToBounds = YES;
    dialogNo.textAlignment = NSTextAlignmentCenter;
    dialogNo.text=@"NCD";
    [userView addSubview:dialogNo];
    
    //NCD VALUE SELECTED
     Value_NCD = [NSString stringWithFormat:@"%@%%",[textcontaint objectAtIndex:4]];
    
    val_NCD=[[UILabel alloc]initWithFrame:CGRectMake(126,160, 119,40)];
    [val_NCD setBackgroundColor:[UIColor whiteColor]];
    val_NCD.layer.cornerRadius = 5;
    val_NCD.textAlignment = NSTextAlignmentLeft;
    val_NCD.layer.masksToBounds = YES;
    val_NCD.text = Value_NCD;
    [userView addSubview:val_NCD];
    
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 198, userView.frame.size.width, 1)];
    [linelabel1 setBackgroundColor:[UIColor darkGrayColor]];

//  [userView addSubview:linelabel1];
    
//    if(applicant_status.length>0 && job_industry.length>0 && no_claim_discount.length>0 && driving_expiry.length>0&&job_position.length>0 && sum_insured.length>0)
//    {
//        NSString *urlString;
//        
//        if(![date_of_birth isEqualToString:@"Select Date"] && ![date_of_birth isEqualToString:@"選擇"])
//        {
//          [self.view addSubview:userView];
//        }
//    }
    
    //    [pass_text becomeFirstResponder];
    
    //    [pass_text becomeFirstResponder];
    
    BOOL Checkflag = [self callToCheck_Parameter_Values];
    
    if(Checkflag)
    {
          [self.view addSubview:userView];
    }
}

//Driving Exp=牌齡 8年AGE＝年齡 25歲      NCD （NO NEED）NCD： 60%SHOULD HAVE ％

-(BOOL)callToCheck_Parameter_Values
{
    textcontaint = [[NSMutableArray alloc]init];
    
    for(int index=0;index<11;index++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:carTableview didSelectRowAtIndexPath:path];
    }
    
    
    
    NSString *trimmed;
    
    NSString *classstr=classvalF;
    trimmed = [classstr stringByReplacingOccurrencesOfString: @" "
                                                  withString: @""
                                                     options: NSRegularExpressionSearch
                                                       range: NSMakeRange(0, classstr.length)];
    classstr=trimmed;
    
    NSString *vehical_name=makeTextF;
    trimmed = [vehical_name stringByReplacingOccurrencesOfString: @" "
                                                      withString: @""
                                                         options: NSRegularExpressionSearch
                                                           range: NSMakeRange(0, vehical_name.length)];
    vehical_name=trimmed;
    
    //  NSData *dataenc = [vehical_name dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    //    vehical_name = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    
    NSString *vehical_model=modelTextF;
    trimmed = [vehical_model stringByReplacingOccurrencesOfString: @" "
                                                       withString: @""
                                                          options: NSRegularExpressionSearch
                                                            range: NSMakeRange(0, vehical_model.length)];
    vehical_model=trimmed;
    
    //      dataenc = [vehical_model dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    //    vehical_model = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    
    
    NSString *year_of_manufacture=yearTextF;
    trimmed = [year_of_manufacture stringByReplacingOccurrencesOfString: @" "
                                                             withString: @""
                                                                options: NSRegularExpressionSearch
                                                                  range: NSMakeRange(0, year_of_manufacture.length)];
    year_of_manufacture=trimmed;
    
    NSString *engine_capacity=engineCapacityTextF;
    
    trimmed = [engine_capacity stringByReplacingOccurrencesOfString: @" "
                                                         withString: @""
                                                            options: NSRegularExpressionSearch
                                                              range: NSMakeRange(0, engine_capacity.length)];
    engine_capacity=trimmed;
    
    
    //Vehicle Body Type
    NSString *vehicle_bodyType=bodytypeValF;
    trimmed = [vehicle_bodyType stringByReplacingOccurrencesOfString: @" "
                                                          withString: @""
                                                             options: NSRegularExpressionSearch
                                                               range: NSMakeRange(0, vehicle_bodyType.length)];
    vehicle_bodyType=trimmed;
    
    // Appllicant Status
    NSString *applicant_status=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:1]];
    trimmed = [applicant_status stringByReplacingOccurrencesOfString: @" "
                                                          withString: @""
                                                             options: NSRegularExpressionSearch
                                                               range: NSMakeRange(0, applicant_status.length)];
    applicant_status=trimmed;
    
    
    //Date of Birth
    NSString *date_of_birth;
    NSString *datec=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:2]];
    
    if([datec isEqualToString:@"Select Date"])
    {
        date_of_birth = @"Select Date";
    }
    else if([datec isEqualToString:@"選擇"])
    {
        date_of_birth=@"選擇";
    }
    else
    {
        date_of_birth = datec;
    }
    
    //Job Industry
    NSString *job_industry=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:3]];
    trimmed = [job_industry stringByReplacingOccurrencesOfString: @" "
                                                      withString: @""
                                                         options: NSRegularExpressionSearch
                                                           range: NSMakeRange(0, job_industry.length)];
    job_industry=trimmed;
    
    //   dataenc = [job_industry dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    // job_industry = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Job Industry :: %@ :: DAteenc ::",job_industry);
    
    //NO Claim Discount
    NSString *myString = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:4]];
    NSString *mySmallerString;
    if([myString isEqualToString:@" 0"])
    {
        mySmallerString = @"0";
        trimmed = [mySmallerString stringByReplacingOccurrencesOfString: @" "
                                                             withString: @""
                                                                options: NSRegularExpressionSearch
                                                                  range: NSMakeRange(0, mySmallerString.length)];
        mySmallerString=trimmed;
    }
    else
    {
        mySmallerString = [myString substringToIndex:2];
        trimmed = [mySmallerString stringByReplacingOccurrencesOfString: @" "
                                                             withString: @""
                                                                options: NSRegularExpressionSearch
                                                                  range: NSMakeRange(0, mySmallerString.length)];
        mySmallerString=trimmed;
    }
    
    NSString *no_claim_discount = mySmallerString;
    
    //Driving Expiry
    NSString *driving_expiry=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:5]];
    trimmed = [driving_expiry stringByReplacingOccurrencesOfString: @" "
                                                        withString: @""
                                                           options: NSRegularExpressionSearch
                                                             range: NSMakeRange(0, driving_expiry.length)];
    driving_expiry=trimmed;
    
    //Job Position
    NSString *job_position=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:6]];
    
    trimmed = [job_position stringByReplacingOccurrencesOfString: @" "
                                                      withString: @""
                                                         options: NSRegularExpressionSearch
                                                           range: NSMakeRange(0, job_position.length)];
    job_position = trimmed;
    
    //  dataenc = [job_position dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    //  job_position = [[NSString alloc]initWithData:dataenc encoding:NSUTF8StringEncoding];
    
    //NSLog(@"Text Constraint :: %@ JOb Position :: %@ ",[textcontaint objectAtIndex:7],job_position);
    
    //Sum insured
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    NSString *sum_insured;
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        sum_insured=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:9]];
        trimmed = [sum_insured stringByReplacingOccurrencesOfString: @" "
                                                         withString: @""
                                                            options: NSRegularExpressionSearch
                                                              range: NSMakeRange(0, sum_insured.length)];
        sum_insured=trimmed;
    }
    else
    {
        sum_insured=@"0";
    }
    
    NSData *imageData = UIImageJPEGRepresentation(imageview.image, 90);
    
    NSString *user_id =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];
    
    NSString *policy_id;
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        policy_id=@"1";
    }
    else
    {
        policy_id=@"2";
    }
    
    
    if([SimageFlag isEqualToString:@"YES"])
    {
        if(applicant_status.length>0 && job_industry.length>0 && no_claim_discount.length>0 && driving_expiry.length>0&&job_position.length>0 && sum_insured.length>0)
        {
            NSString *urlString;
            
            if(![date_of_birth isEqualToString:@"Select Date"] && ![date_of_birth isEqualToString:@"選擇"])
            {
                return YES;
            }
            else //DAte
            {
                [self.view setUserInteractionEnabled:YES];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please select Date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }
        }
        else //Fields Check
        {
      
            //[self.indicator removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Enter Car Owner & coverage type fields", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
                    return NO;
        }
    }
    else  // Without Image Code Else Part
    {
        if(![date_of_birth isEqualToString:@"Select Date"]&& ![date_of_birth isEqualToString:@"選擇"])
        {
            if(classstr.length>0&&vehical_name.length>0&&vehical_model.length>0&&year_of_manufacture.length>0&&engine_capacity.length>0&&vehicle_bodyType.length>0&&applicant_status.length>0&&job_industry.length>0 && no_claim_discount.length>0&&driving_expiry.length>0&&job_position.length>0&&sum_insured.length>0)
            {
                  return YES;
            }
            else /// DAta Param Else
            {
                [self.view setUserInteractionEnabled:YES];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please enter all the fields", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }
        }
        else //DAte
        {
            [self.view setUserInteractionEnabled:YES];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please select Date", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
    }  //ImageFlag else  closing Bracket
    
    return NO;
}


-(void)user_cancelcalled:(UIButton*)sender
{
    [pView removeFromSuperview];
    [userView removeFromSuperview];
}

-(IBAction)user_okcalled:(UIButton*)sender
{
    [self  Upload_car_Information];
    
    [pView removeFromSuperview];
    [userView removeFromSuperview];

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

#pragma mark  - AlertStatus
-(void) alertStatus:(NSString *)msg :(NSString *)title :(int)setTag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)                                              otherButtonTitles:nil, nil];
    alertView.tag = setTag;
    //NSLog(@"tag %d", setTag);
    [alertView show];
}

#pragma mark -- TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        if(textField.tag==119)
        {
            //NSLog(@"Called Sum insured");
         //   [self Upload_car_Information];
            [self call_profile_Detail_view_NCD_AGE_EXP];
        }
    }
    else
    {
        if(textField.tag==116)
        {
              [self call_profile_Detail_view_NCD_AGE_EXP];
        //  [self Upload_car_Information];
        }
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [pView removeFromSuperview];
    
    NSString *str=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    
    // //NSLog(@"TExtfieldLog :: %@",str);
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.carTableview];
    NSIndexPath *indexPath1 = [carTableview indexPathForRowAtPoint:point];
    
    // It works for Changing the position of the tableview for selected row
    // [self.carTableview selectRowAtIndexPath:indexPath1 animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    NSInteger inte = (NSInteger)indexPath1;
    //NSLog(@"indexPath1 :: %ld",(long)indexPath1.row);
    Movevalue = (NSInteger)indexPath1.row;
    
    //    if(Movevalue == indexPath1.row)
    //    {
    //       //Movevalue = 0;
    //    }
    
    if(Movevalue==16||Movevalue==15)
    {
        Movevalue = 1;
        //code to reset the
        CGRect rect1 = self.view.frame;
        rect1.origin.y = 0.0f;
        rect1.size.height =  [[UIScreen mainScreen] bounds].size.height
        ;//568;
        self.view.frame = rect1;
    }
    else
    {
        CGRect rect1 = self.view.frame;
        rect1.origin.y = 0.0f;
        rect1.size.height =  [[UIScreen mainScreen] bounds].size.height
        ;//568;
        self.view.frame = rect1;
        Movevalue = 0;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 
{
    if(textField.tag==115)
    {
        // Prevent crashing undo bug – see note below.
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 2;
    }
    
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    NSString *str=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    // //NSLog(@"TExtfieldLog :: %@",str);
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.carTableview];
    
    NSIndexPath * indexPath1 = [self.carTableview indexPathForRowAtPoint:point];
    
    //NSLog(@"Indexpath :: %ld ",(long)indexPath1.row);
    
    if([str isEqualToString:@"111"]||[str isEqualToString:@"112"]||[str isEqualToString:@"113"]||[str isEqualToString:@"114"]||[str isEqualToString:@"115"]||[str isEqualToString:@"116"]||[str isEqualToString:@"118"]||[str isEqualToString:@"120"]||[str isEqualToString:@"121"]||[str isEqualToString:@"122"]||[str isEqualToString:@"123"]||[str isEqualToString:@"126"]||[str isEqualToString:@"125"])
    {
        //[exercise_MArray  insertObject:textField.text  atIndex:indexPath1.row];
        [userDetails  replaceObjectAtIndex:indexPath1.row withObject:textField.text];
    }
    
    [textField resignFirstResponder];
    
    //NSLog(@"userDetails :: %@",userDetails);
    
    return YES;
}

-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- Touches & PrepareForSegue
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [pView removeFromSuperview];
    
    //NSLog(@"CAlled Touches ");
    [cell.name_textfield resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        // [sideview setFrame:CGRectMake(-133, 0, sideview.frame.size.width,sideview.frame.size.height)];
    }];
}


-(IBAction)Called_Policy_Details:(id)sender
{
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"CTOP"])
    { }
}

#pragma  mark --- Keyboard Resign

-(void)keyboardWillShow
{
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide
{
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
     int m = (int) Movevalue;
   
    int i=180;
    i=i*m;
    
    CGRect rect = self.view.frame;
    if(movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= i;
        rect.size.height += i;
        // checkMoveval = m;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y +=i ;
        rect.size.height -= i;
        // checkMoveval = m;
    }
    self.view.frame = rect;
    
    //NSLog(@"Frame Transform :: origin.y :: %f,origin.x:: %f,size.height:: %f", rect.origin.y, rect.origin.x, rect.size.height);
    
    [UIView commitAnimations];
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
