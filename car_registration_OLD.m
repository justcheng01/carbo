//
//  car_registration.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Shirish Vispute. All rights reserved.
//

#import "car_registration.h"
#import "carRegistrationCell.h"
#import "AlbumClass.h"
#import "Select Policy.h"
#import "Reachability.h"

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
    
    UILabel *bodytype;
    UILabel *bodytype_val;
    BOOL imageflag;
    carRegistrationCell *cell;
}
@end

@implementation car_registration
@synthesize carTableview,imageview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageflag=NO;
    self.navigationItem.title = @"Quotation Form";
 
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    NSLog(@"Select_Policy :: %@",strc);
 
    
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1500)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.alwaysBounceHorizontal=NO;
    scrollview.alwaysBounceVertical=NO;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    // [scrollview setBackgroundColor:[UIColor redColor]];
    scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+2600);
    //[self.view addSubview:scrollview];
    
    carTableview=[[UITableView alloc]init];
    self.carTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.carTableview.frame = CGRectMake(0,-30,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen]bounds].size.height+30);
    [carTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    carTableview.scrollEnabled = YES;
    [carTableview setBackgroundColor:[UIColor whiteColor]];
    carTableview.tag=101;
    //[carTableview setAlpha:1];
    carTableview.dataSource = self;
    carTableview.delegate=self;
    [self.view addSubview:carTableview];

    userDetails=[[NSMutableArray alloc]init];
   
    for(int i=0;i<19;i++)
    {
        [userDetails addObject:@""];
    }
    
   carinfoImage=[[UIImageView alloc]init];
   colour = [self getUIColorObjectFromHexString:@"#2879bc" alpha:1.0]; 
   
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(-10, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
//    UploadImageBtn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-60/2,[[UIScreen mainScreen] bounds].size.height-60/2 ,120,120)];
////    [UploadImageBtn setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
//    [UploadImageBtn setTitle:@"Upload Photo" forState:UIControlStateNormal];
//    [UploadImageBtn addTarget:self action:@selector(selectImageFromGallary:) forControlEvents:UIControlEventTouchUpInside];
   
//    select_Date_Btn = [[UIButton alloc] initWithFrame: CGRectMake(170,10 , 150.0f, 35.0f)];
//    //    [UploadImageBtn setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
//    [select_Date_Btn setTitle:@"Select Date" forState:UIControlStateNormal];
//    [select_Date_Btn addTarget:self action:@selector(DAteSelection) forControlEvents:UIControlEventTouchUpInside];
    
    nextBtn=[[UIButton alloc]initWithFrame: CGRectMake(10,2,[[UIScreen mainScreen]bounds].size.width-20,35)];
    //[UploadImageBtn setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [nextBtn setTitle:@"Next" forState:UIControlStateNormal];
  
   // [nextBtn setTintColor:[UIColor blackColor]];
    [nextBtn addTarget:self action:@selector(Upload_car_Information) forControlEvents:UIControlEventTouchUpInside];
  //  [nextBtn setBackgroundImage:[UIImage imageNamed:@"uploadimage.png"] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:colour];
    
    //Heading 1
    heading1=[[UILabel alloc]initWithFrame:CGRectMake(0,5,[[UIScreen mainScreen] bounds].size.width,40)];
    [heading1 setTextColor:colour];
    [heading1 setFont:[UIFont boldSystemFontOfSize:14]];
    [heading1 setText:@"Upload Vehical Sheet"];
    [heading1 setTextAlignment:NSTextAlignmentCenter];
    //[exercise_Lable setFont:boldFont];
    
    //OR Heading
    or = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-40)/2,160,30,30)];
    [or setTextColor:[UIColor whiteColor]];
    [or setBackgroundColor:colour];
    [or setFont:[UIFont boldSystemFontOfSize:14]];
    [or setText:@"OR"];
    [or setTextAlignment:NSTextAlignmentCenter];
     or.layer.masksToBounds = YES;
     or.layer.cornerRadius = 14.0;
    
    line = [[UILabel alloc]initWithFrame:CGRectMake(10,175,[[UIScreen mainScreen] bounds].size.width-20,2)];
    [line setTextColor:[UIColor whiteColor]];
    [line setBackgroundColor:[UIColor lightGrayColor]];

   //Heading 2
    [heading2 setTextAlignment:NSTextAlignmentCenter];
    heading2=[[UILabel alloc]initWithFrame:CGRectMake(0,195,[[UIScreen mainScreen] bounds].size.width,30)];
    [heading2 setTextColor:colour];
    [heading2 setFont:[UIFont boldSystemFontOfSize:14]];
    [heading2 setText:@"Fill Quotation Form"];
    //[exercise_Lable setFont:boldFont];
    [heading2 setTextAlignment:NSTextAlignmentCenter];
    
    [heading3 setTextAlignment:NSTextAlignmentCenter];
    heading3=[[UILabel alloc]initWithFrame:CGRectMake(0,220,[[UIScreen mainScreen] bounds].size.width,40)];
    [heading3 setTextColor:colour];
    [heading3 setFont:[UIFont boldSystemFontOfSize:14]];
    [heading3 setText:@"  Insured Vehicle Information"];
    //[exercise_Lable setFont:boldFont];
    [heading3 setTextAlignment:NSTextAlignmentLeft];
    
    //Date Label
    datelabel=[[UILabel alloc]initWithFrame:CGRectMake(20,15,150,20)];
    [datelabel setTextColor:[UIColor blackColor]];
    [datelabel setFont:[UIFont boldSystemFontOfSize:12]];
    [datelabel setText:@"Date of Birth"];
    //[exercise_Lable setFont:boldFont];
    [datelabel setTextAlignment:NSTextAlignmentLeft];
   
    //Select Date Label to Select date
    select_Date_label = [[UILabel alloc]initWithFrame:CGRectMake(180,9,120,35)];
    select_Date_label.userInteractionEnabled=YES;
    [select_Date_label setTextColor:[UIColor whiteColor]];
    [select_Date_label setBackgroundColor:colour];
    select_Date_label.layer.cornerRadius=10;
//  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    select_Date_label.text=@"Select Date";
    select_Date_label.textAlignment=NSTextAlignmentCenter;
    [select_Date_label setClipsToBounds:YES];

//For Photo Upload Image
    //imageLabel=[[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-60)/2, ([[UIScreen mainScreen] bounds].size.height-60)/2, 120,120)];
    imageview=[[UIImageView alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-110)/2,40,120,120)];
    imageview.userInteractionEnabled=YES;
    UIImage *image1=[[UIImage alloc]init];
    image1 = [UIImage imageNamed:@"uploadimage.png"];
 
    NoClaimsDiscount=[[UILabel alloc]initWithFrame:CGRectMake(20,5,150,40)];
    [NoClaimsDiscount setTextColor:[UIColor blackColor]];
    [NoClaimsDiscount setFont:[UIFont boldSystemFontOfSize:12]];
    [NoClaimsDiscount setText:@"No Claims Discount (NCD)"];
      NoClaimsDiscount.numberOfLines=2;
    //[exercise_Lable setFont:boldFont];
    [NoClaimsDiscount setTextAlignment:NSTextAlignmentLeft];
    
    NoClaimsDiscount_val = [[UILabel alloc]initWithFrame:CGRectMake(180,5,120,35)];
    NoClaimsDiscount_val.userInteractionEnabled=YES;
    [NoClaimsDiscount_val setTextColor:[UIColor whiteColor]];
    [NoClaimsDiscount_val setBackgroundColor:colour];
    NoClaimsDiscount_val.textAlignment=NSTextAlignmentCenter;
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
    NoClaimsDiscount_val.text=@"0%";
    NoClaimsDiscount_val.layer.cornerRadius=10;
    [NoClaimsDiscount_val setClipsToBounds:YES];
    
    NCD_Actual_Val=[[UILabel alloc]init];
    
   // bodytype
    //bodytype_val
    
    bodytype=[[UILabel alloc]initWithFrame:CGRectMake(20,5,150,40)];
    [bodytype setTextColor:[UIColor blackColor]];
    [bodytype setFont:[UIFont boldSystemFontOfSize:12]];
    [bodytype setText:@"Body Type"];
    bodytype.numberOfLines=2;
    //[exercise_Lable setFont:boldFont];
    [bodytype setTextAlignment:NSTextAlignmentLeft];
    
    bodytype_val = [[UILabel alloc]initWithFrame:CGRectMake(180,5,120,35)];
    bodytype_val.userInteractionEnabled=YES;
    [bodytype_val setTextColor:[UIColor whiteColor]];
    [bodytype_val setBackgroundColor:colour];
    bodytype_val.textAlignment=NSTextAlignmentCenter;
    //  select_Date_label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];;
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
    
//    CGRect rect;
//            rect.origin.x=0;
//            rect.origin.y=0;
//            rect.size.width=120;
//            rect.size.height=120;
//    CGSize Size;
//    Size.width=120;
//    Size.height=120;
//    
//   UIImage  *image=[self resizeImage:image1 newSize:Size];
//    
    CGSize is;
    is.height=120;
    is.width=130;
    
    UIImage *imagp =[self imageResize:image1 andResizeTo:is];
    
//    NSData *image = UIImageJPEGRepresentation(imagp, 90);
//  imageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"uploadimage.png"]];
   imageview.backgroundColor = [UIColor colorWithPatternImage:imagp];
   
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    tapGesture.delegate=self;
    tapGesture.numberOfTapsRequired=1;
    [imageview addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DAteSelection)];
    tapGesture2.delegate=self;
    tapGesture2.numberOfTapsRequired=1;
    [select_Date_label addGestureRecognizer:tapGesture2];

    
    
    //Notification Table
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
//    menuimage=[[UIImageView alloc]initWithFrame:CGRectMake(260,20, 40, 40)];
//    [menuimage setUserInteractionEnabled:YES];
//    UIImage *image=[UIImage imageNamed:@"menu.png"];
//    menuimage.image=image;
//    
//    personimage=[[UIImageView alloc]initWithFrame:CGRectMake(20,0, 70, 70)];
//    [personimage setUserInteractionEnabled:YES];
//    UIImage *image2=[UIImage imageNamed:@"photo.png"];
//    personimage.image=image2;
//    
//    nickName=[[UILabel alloc]initWithFrame:CGRectMake(120, 10, 200,25 )];
//    [nickName setTextColor:[UIColor lightGrayColor]];
//    [nickName setFont:[UIFont systemFontOfSize:18]];
//    nickName.text=@"Thomas Lawrence";
//    
//    personName = [[UILabel alloc]initWithFrame:CGRectMake(120, 40, 180,25 )];
//    [personName setTextColor:[UIColor lightGrayColor]];
//    [personName setFont:[UIFont systemFontOfSize:18]];
//    personName.text=@"Profile";
//    
//    Logout=[[UILabel alloc]initWithFrame:CGRectMake(120, 0, 150, 25)];
//    [Logout setTextColor:[UIColor lightGrayColor]];
//    [Logout setFont:[UIFont systemFontOfSize:16]];
//    Logout.text=@"Log Out";

// Do any additional setup after loading the view.
//    
//    CTOP
    
//    UIAlertView & Activity indicator
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Loading data" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
//    
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [indicator startAnimating];
//    
//    [alertView setValue:indicator forKey:@"accessoryView"];
//    [alertView show];
}

-(void)backJump
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

#pragma mark DateSelection
-(void)DAteSelection
{
    [self.view endEditing:YES];
    [pView removeFromSuperview];
    //  self.view.frame.size.width/2 - yourButton.frame.size.width/2, self.view.frame.size.height/2 - yourButton.frame.size.height/2, yourButton.frame.size.width, yourButton.frame.size.height)
    
    //OLD  pView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-320/2,self.view.frame.size.height/2-240/2,320,240)];
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
    
    [cancel_Btn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancel_Btn.tag=101;
    
    //DAteLabel
    dateLabel=[[UILabel alloc]initWithFrame:CGRectMake((pView.frame.size.width-100)/2,0,100, 30)];
    [dateLabel setText:@"Select DOB"];
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
    [Done_Btn setTitle:@"Done" forState:UIControlStateNormal];
    
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
{
    
}
-(IBAction)selectedOption_date:(UIButton*)sender
{
    if(sender.tag==101)
    {
        select_Date_label.text=@"Select Date";
       // [select_Date_Btn setTitle:@"DOB" forState:UIControlStateNormal];
        [pView removeFromSuperview];
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    
        select_Date_label.text=strDate;
        // NSString *dateStr = [inFormat dateFromString:dateSelected];
       // [select_Date_Btn setTitle:strDate forState:UIControlStateNormal];
        [pView removeFromSuperview];
    }

    
}

#pragma mark -- Image selection code :: - 

-(void)selectBodyType:(id)sender
{
     [self.view endEditing:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Convertible",
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
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:   @"0%",
                            @"10%",
                            @"20%",
                            @"30%",
                            @"40%",
                            @"50%",
                            @"60%",
                            nil];
    popup.tag = 2;
    [popup showInView:self.view];
}

-(IBAction)selectImage:(id)sender
{
 [self.view endEditing:YES];
  UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Select Gallary Image",
                            @"Take Photo",
                            nil];
    popup.tag = 1;
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
                    NoClaimsDiscount_val.text=@"0%";
                    NCD_Actual_Val.text=@"0";
                    break;
                case 1:
                    NoClaimsDiscount_val.text=@"10%";
                    NCD_Actual_Val.text=@"10";
                    break;
                case 2:
                    NoClaimsDiscount_val.text=@"20%";
                    NCD_Actual_Val.text=@"20";
                    break;
                case 3:
                    NoClaimsDiscount_val.text=@"30%";
                    NCD_Actual_Val.text=@"30";
                    break;
                case 4:
                    NoClaimsDiscount_val.text=@"40%";
                    NCD_Actual_Val.text=@"40";
                    break;
                case 5:
                    NoClaimsDiscount_val.text=@"50%";
                    NCD_Actual_Val.text=@"50";
                    break;
                case 6:
                    NoClaimsDiscount_val.text=@"60%";
                    NCD_Actual_Val.text=@"60";
                    break;
                default:
                    break;
      }
    [userDetails replaceObjectAtIndex:9 withObject:NoClaimsDiscount_val.text];
    NSLog(@"userDetails :: %@",userDetails);
   // [userDetails insertObject:NoClaimsDiscount_val.text atIndex:11];
     [self.carTableview reloadData];
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
    
    
    [userDetails replaceObjectAtIndex:6 withObject:bodytype_val.text];
    NSLog(@"userDetails :: %@",userDetails);
    // [userDetails insertObject:NoClaimsDiscount_val.text atIndex:11];
    [self.carTableview reloadData];
}
    
//    switch (popup.tag) {
//        case 1: {
//            switch (buttonIndex) {
//                case 0:
//                    [self selectImageFromGallary:sender];
//                    break;
//                case 1:
//                    [self shootNow:sender];
//                    break;
//                default:
//                    break;
//            }
//            break;
//        }
//        default:
//            break;
//    }
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
    
    
   // carinfoImage.image = photo;
    //    _photoView.image = [AlbumClass imageWithMediaInfo:info];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //Do not delete this block
    [UIView animateWithDuration:50.0
                     animations:^{
                         //                         pickerView.frame = //move it out of screen
                         
                         //
                         //                         UIButton *tickButton = [[UIButton alloc]initWithFrame:CGRectMake(143, 6, 35, 35)];
                         //                         UIImage *customImage = [UIImage imageNamed:@"tick.png"];
                         //                         [tickButton setBackgroundImage:customImage forState:UIControlStateNormal];
                         //                         [tickButton addTarget:self action:@selector(tickButtonAction) forControlEvents:UIControlEventTouchUpInside];
                         //                         [bottomView addSubview:tickButton];
                         
                         //                         if (_photo != nil) {
                         //                             doneButton.hidden = NO;
                         //                         }
                         imageflag=YES;
                        self.navigationController.navigationBarHidden = NO;
                        self.imageview.image = photo;
                         
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
    
//    NSLog(@"CapturedImage data in addjar: %@", self.photo);
//    [UIView animateWithDuration:5.0
//                     animations:^{
//                        
//                         
//                         _photoView.image = image;
//                         
//                         if (_photo != nil) {
//                             doneButton.hidden = NO;
//                         }
//                         
//                     } completion:^(BOOL finished) {
//                         
//                         if ([UIScreen mainScreen].bounds.size.height == 480)
//                         {
//                             
//                             
//                         }
//                         
//                         //                         [pickerView removeFromSuperView];
//                     }];
//    
//    
     imageflag=YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraWillTakePhoto
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark ----- UITableView Delegate & Datasource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    
    if([strc isEqualToString:@"Comprehensive"])
    {
          return 18;
    }
    else
    {
        return 17;
    }

    return 17;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cell Identifier
    static NSString *cellIdentifier = @"simpleIdentifier";
    UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cells = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];

    static NSString *cellIdentifier1 = @"cellIdentifier";
    cell = (carRegistrationCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];  
    
    cell = [[carRegistrationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier1];
    
     UIColor *colour1 = [self getUIColorObjectFromHexString:@"#2879bc" alpha:1.0]; 
  
   cell.name_textfield.delegate=self;
   cells.selectionStyle = UITableViewCellSelectionStyleNone;
   

  NSString *str=[NSString stringWithFormat:@"%@",[userDetails objectAtIndex:indexPath.row]];

    if(indexPath.row==0)
    {
        [cells.contentView addSubview:imageview];
        [cells.contentView addSubview:heading1];
        [cells.contentView addSubview:line]; 
        [cells.contentView addSubview:or];
        [cells.contentView addSubview:heading2];
        [cells.contentView addSubview:heading3];
// [cells.contentView addSubview:];
        return cells;
//      cell.selectionStyle = UITableViewCellSelectionStyleNone;
//      UIImage *pimage = [UIImage imageNamed:@"photo.png"];       
//        [cell.contentView addSubview:personimage];
//        [cell.contentView addSubview:personName];
//        [cell.contentView addSubview:nickName];
    }
    else if(indexPath.row==1)
    {    
       cell.name_Label.text = @"Class";
       [cell.name_textfield setPlaceholder: @"Private Car"];
   
        if([str isEqualToString:@""])
        {
        }
        else
        {
         cell.name_textfield.text = str;
        }
     cell.name_textfield.tag=111;
        
    }
    else if(indexPath.row==2)
    {  
        cell.name_Label.text = @"Make";
        [cell.name_textfield setPlaceholder: @"honda"];
        //cell.name_textfield.text = @"Honda";
        cell.name_textfield.tag=112;
        if([str isEqualToString:@""])
        {
        }
        else
        {
            cell.name_textfield.text = str;
        }
    }
   else if(indexPath.row==3)
    {  
        cell.name_Label.text = @"Model";
        //cell.name_textfield.text = @"Beat";
        [cell.name_textfield setPlaceholder: @"Beat"];
        cell.name_textfield.tag=113;
        if([str isEqualToString:@""])
        {
            
        }
        else
        {
            cell.name_textfield.text = str;
        }
    }
   else if(indexPath.row==4)
    {  
        cell.name_Label.text = @"Year of Manufacture";
        [cell.name_textfield setPlaceholder: @"2013"];
        cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
        //cell.name_textfield.text = @"2013";
        cell.name_textfield.tag=114;
        if([str isEqualToString:@""])
        {
            
        }
        else
        {
            cell.name_textfield.text = str;
        }
    }
   else if(indexPath.row==5)
    {  
        cell.name_Label.text = @"Engine Capacity (C.C)";
        [cell.name_textfield setPlaceholder: @"3000"];
        cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
        //cell.name_textfield.text = @"3000";
        cell.name_textfield.tag=115;
        if([str isEqualToString:@""])
        {
      
        }
        else
        {
            cell.name_textfield.text = str;
        }
    }
   else if(indexPath.row==6)
    { 
        cell.name_Label.text = @"Body Type";
        [cell.name_textfield setPlaceholder: @"HatchBack"];
       // cell.name_textfield.tag=116;
        
        bodytype_val.tag=116;
        [cells.contentView addSubview:bodytype];
        [cells.contentView addSubview:bodytype_val];
        return cells;

        if([str isEqualToString:@""])
        {
            
        }
        else
        {
            cell.name_textfield.text = str;
        }
    }
   else if(indexPath.row==7)
    {    
        cells.textLabel.text=@"Car Owner Information";
        cells.textLabel.textColor= colour1;
        return cells;
    }
   else if(indexPath.row==8)
    { 
        cell.name_Label.text = @"Application Status";
        [cell.name_textfield setPlaceholder:@"Individual"];
        cell.name_textfield.text = @"Individual";
        cell.name_textfield.tag = 118;
       
        if([str isEqualToString:@""])
        {
             cell.name_textfield.text = @"Individual";
        }
        else
        {
            cell.name_textfield.text = str;
        }
    }
  else if(indexPath.row==9)
    { 
        [cells.contentView addSubview:select_Date_label];
        [cells.contentView addSubview:datelabel];
        cell.name_textfield.tag=119;
        return cells;
    }
  else if(indexPath.row==10)
  { 
      cell.name_Label.text = @"Job Industry";
      [cell.name_textfield setPlaceholder: @"Banking"];
      cell.name_textfield.tag=120;
      if([str isEqualToString:@""])
      {
          
      }
      else
      {
          cell.name_textfield.text = str;
      }
  }
  else if(indexPath.row==11)
  { 
      cell.name_Label.text = @"No Claims Discount (NCD)";
      [cell.name_textfield setPlaceholder: @"10%"];
      cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
      //cell.name_textfield.tag=121;
      //NoClaimsDiscount_val.text=@"10%";
      
      NoClaimsDiscount_val.tag=121;
      [cells.contentView addSubview:NoClaimsDiscount];
      [cells.contentView addSubview:NoClaimsDiscount_val];
      return cells;
      
//   NoClaimsDiscount
//   NoClaimsDiscount_val
      if([str isEqualToString:@""])
      {
         
      }
      else
      {
          cell.name_textfield.text = str;
      }
  }
  else if(indexPath.row==12)
  { 
      cell.name_Label.text = @"Driving Exp. (Years)";
      [cell.name_textfield setPlaceholder:@""];
      cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
      cell.name_textfield.tag=122;
      if([str isEqualToString:@""])
      {
          
      }
      else
      {
          cell.name_textfield.text = str;
      }
  }
  else if(indexPath.row==13)
  { 
      cell.name_Label.text = @"Job Position";
      [cell.name_textfield setPlaceholder: @"Trailer"];
      cell.name_textfield.tag=123;
      if([str isEqualToString:@""])
      {
    
      }
      else
      {
          cell.name_textfield.text = str;
      }
   }
  else if(indexPath.row==14)
  { 
      cells.textLabel.text=@"Coverage Type";
      cells.textLabel.textColor=colour1;
      return cells;
 }
  else if(indexPath.row==15)
  { 
      cell.name_Label.text = @"Insurance Type";
      [cell.name_textfield setFont:[UIFont boldSystemFontOfSize:10]];
     
    //[cell.name_textfield setPlaceholder: @"Comprehensive"];
      
      
     // cell.name_textfield.text = @"Comprehensive";
     // cell.name_textfield.tag=125;
      if([str isEqualToString:@""])
      {
          NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
          cell.name_textfield.text = strc;
      }
      else
      {
              NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
          cell.name_textfield.text = strc;
      }
       cell.name_textfield.enabled = NO;
  }
  else if(indexPath.row==16)
  { 
      cell.name_Label.text = @"Sum Insured (HK$)";
      [cell.name_textfield setPlaceholder: @"300000"];
      cell.name_textfield.keyboardType=UIKeyboardTypeNumberPad;
      cell.name_textfield.tag=126;
      
      NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
      
//      if([str isEqualToString:@""])
//      {
//          
//      }
//      else
//      {
//          cell.name_textfield.text = str;
//      }
      NSLog(@"Insurance Type SUM_Insured");
      
   if([strc isEqualToString:@"Comprehensive"])
       {
             if([str isEqualToString:@""])
             {
                  
             }
             else
             {
                 cell.name_textfield.text = str;
             }
         }
         else
         {
             [cells.contentView addSubview:nextBtn];
             return cells;
         }
 }
  else if(indexPath.row==17)
  { 
      NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
      
     [cells.contentView addSubview:nextBtn];
     return cells;
      
//      if([strc isEqualToString:@"Comprehensive"])
//      {
//          [cells.contentView addSubview:nextBtn];
//          return cells;
//      }
//      else
//      {
//         //   [cells.contentView addSubview:nextBtn];
//          return cells;
//      }
  }

 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 return cell;
}
 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       if(indexPath.row ==8 ||indexPath.row==8||indexPath.row==14)
       {
          return 40;
       }
       else if(indexPath.row==0)
       {
          return 250;
       }
       // your dynamic height...
       return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        
//        NSLog(@"%ld",(long)indexPath.row);
        
        int m =indexPath.row;
        
        //    alertTone  = cell.textLabel.text;
        //    UIImage *image1=[UIImage imageNamed:@"radio_on.png"];
        //    cell.imageView.image= image1;
        //    
        //    [[NSUserDefaults standardUserDefaults]setObject:cellText forKey:@"alertsound"];
        //    [[NSUserDefaults standardUserDefaults]setObject:cell.textLabel.text forKey:@"alerttext"];
        //    [[NSUserDefaults standardUserDefaults]synchronize];
        
        //   NSString  *Str=[NSString stringWithFormat:@"%@",[dict1 valueForKey:@"sound"]];
        //    
        //    NSString *playSoundOnAlert = [NSString stringWithFormat:@"%@", [[userInfo objectForKey:@"aps"] objectForKey:@"sound"]];
        
        //   NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],cell.textLabel.text]];
        //    
        //    NSLog(@"URL :: %@",url);
        //    incE=0;

       carRegistrationCell *cell = [[carRegistrationCell alloc]init];
        
        if(indexPath.row==0||indexPath.row==8||indexPath.row==15||indexPath.row==18||indexPath.row==7)
        {
          // [textcontaint addObject:@"a"];
        }
        else if(indexPath.row==16)
        {
           UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
          // NSLog(@"TExtfield :: %@",textField.text);
          
           NSString *strr  = [NSString stringWithFormat:@"%@",textField.text]; 
//           NSString *cellText = [NSString stringWithFormat:@"%@",cell.name_textfield.text];
//           NSLog(@"Strr :: %@, CElltext :: %@",cellText);
          [textcontaint addObject:strr];
//          [textcontaint addObject:strr];
       }
        else if(indexPath.row==6)
        {
            UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
            // NSLog(@"TExtfield :: %@",textField.text);
            
            NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
            //           NSString *cellText = [NSString stringWithFormat:@"%@",cell.name_textfield.text];
            //           NSLog(@"Strr :: %@, CElltext :: %@",cellText);
            [textcontaint addObject:strr];
            //          [textcontaint addObject:strr];
        }
        else if(indexPath.row==11)
        {
            UITextField * textField = (UITextField *)[self.carTableview viewWithTag:110+indexPath.row];
            // NSLog(@"TExtfield :: %@",textField.text);
            
            NSString *strr  = [NSString stringWithFormat:@"%@",textField.text];
            //           NSString *cellText = [NSString stringWithFormat:@"%@",cell.name_textfield.text];
            //           NSLog(@"Strr :: %@, CElltext :: %@",cellText);
            [textcontaint addObject:strr];
            //          [textcontaint addObject:strr];
        }
}

#pragma mark -- Web SErvice To upload Car Registration information

-(void)Upload_car_Information
{
    NSLog(@"USerDeatails ::%@",userDetails);
    textcontaint = [[NSMutableArray alloc]init];
  
for(int i=0;i<userDetails.count;i++)
{
      NSString *Str=[NSString stringWithFormat:@"%@",[userDetails objectAtIndex:i]];
        [userDetails objectAtIndex:i];
        
        if([Str isEqualToString:@""]||[Str isEqualToString:@"null"])
        {
           
        }
        else
        {
           [textcontaint addObject:Str];
        }
}

    NSString *Str=[NSString stringWithFormat:@"%@",[userDetails objectAtIndex:6]];
    
    NSString *class=@"";
    NSString *vehical_name=@"";
    NSString *vehical_model=@"";
    NSString *year_of_manufacture=@"";
    NSString *engine_capacity=@"";
    NSString *vehicle_bodyType=@"";
    NSString *applicant_status=@"";
    NSString *date_of_birth=@"";
    NSString *job_industry=@"";
    NSString *no_claim_discount=@"";
    NSString *driving_expiry=@"";
    NSString *job_position=@"";
    NSString *sum_insured=@""; 
    
if([Str isEqualToString:@""])
{  
}
else
{
    NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    
    if([strc isEqualToString:@"Comprehensive"])
    {
        for(int index=16;index<19;index++)
        { 
            NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
            [self tableView:carTableview didSelectRowAtIndexPath:path];
        }
    }
    else
    {
        
        
        
    }

    

    
    for(int index=6;index<7;index++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:carTableview didSelectRowAtIndexPath:path];
    }
    for(int index=11;index<12;index++)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [self tableView:carTableview didSelectRowAtIndexPath:path];
    }
    
    [textcontaint insertObject:Str atIndex:7];
    
//   device_os
  NSLog(@"textcontaint All Data :: %@",textcontaint);

// {
//        "user_id": "1",
//        "class": "private",
//        "year_of_manufacture": "2015",
//        "vehical_name": "audi",
//        "engine_capacity": "670",
//        "vehical_model": "class c",
//        "vehicle_bodyType": "coco",
//        "applicant_status": "individual existing",
//        "no_claim_discount": "30%",
//        "date_of_birth": "1993-MM-DD",
//        "driving_expiry": "4",
//        "job_industry": "it",
//        "job_position": "Developer",
//        "sum_insured": "798777",
//        
//        "payment_pics": "no",
//    }
//
//    [28/07/16, 6:38:45 PM] Dnyaneshwar Jadhav: quotation_id
//    [28/07/16, 6:39:31 PM] Dnyaneshwar Jadhav: create_policy_ios.php

    class = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:0]];
    
    vehical_name = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:1]];
    
    
    vehical_model = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:2]];;
    
    year_of_manufacture=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:3]];
    
    engine_capacity=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:4]];
   
    vehicle_bodyType=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:5]];
    
    applicant_status=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:6]];
    
    date_of_birth=[NSString stringWithFormat:@"%@",select_Date_label.text];

    NSString *myString =[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:8]];
    
    NSString *mySmallerString = [myString substringToIndex:2];
    NSLog(@"Mysmall string :: %@",mySmallerString);
    
    no_claim_discount=mySmallerString;  //[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:9]];
   
    NSLog(@"no_claim_discount :: %@",no_claim_discount);
    
    
    job_industry=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:9]];
    
    
    driving_expiry=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:10]];

    
    job_position=[NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:11]];
    
    if([strc isEqualToString:@"Comprehensive"])
    {
       sum_insured = [NSString stringWithFormat:@"%@",[textcontaint objectAtIndex:12]];
    }
    else
    {
        sum_insured=@"0";
    }
}   
    

NSData *imageData = UIImageJPEGRepresentation(imageview.image, 90);

NSString *user_id =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"USERID"]];


NSString *strc=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];

NSString *policy_id;
   
if([strc isEqualToString:@"Comprehensive"])
{
    NSString *strc = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey: @"Policyselected"]];
    policy_id = @"1";
 }
else
{
    policy_id = @"2";
}

if((class.length>0&&vehical_name.length>0&&vehical_model.length>0&&year_of_manufacture.length>0&&engine_capacity.length>0&&vehicle_bodyType.length>0&&applicant_status.length>0&&job_industry.length>0 && no_claim_discount.length>0&&driving_expiry.length>0&&job_position.length>0&&sum_insured.length>0)||imageData.length>10)
  {

    
//NSString stringWithFormat:@"%@",[userDetails objectAtIndex:1]];
    
//     NSString *class=@"private";
//     NSString *year_of_manufacture=@"2013";
//     NSString *vehical_name=@"Audi";
//     NSString *engine_capacity=@"4300";
//     NSString *vehical_model=@"calss c";
//     NSString *vehicle_bodyType=@"coco";
//     NSString *applicant_status=@"individual existing";
//     NSString *no_claim_discount=@"30";
//     NSString *date_of_birth=@"2013-7-21";
//     NSString *driving_expiry=@"4";
//     NSString *job_industry=@"it";
//     NSString *job_position=@"Developer";
//     NSString *sum_insured=@"800000";
//     NSString *policy_id=@"1";
 
// NSLog(@"Image DAta %@",imageData);
    
// setting up the URL to post to
//    http://74.208.12.101/Carboservices/create_policy_ios.php?user_id=68&class=Odjdk&year_of_manufacture=4649&vehical_name=Didjjd&engine_capacity=4345&vehical_model=Idhdj&vehicle_bodyType=Saloon&pplicant_status=Individual&no_claim_discount=40&date_of_birth=2013-08-08&driving_expiry=4&job_industry=Disjjd&job_position=Trailer&sum_insured=2100&policy_id=1
    
    BOOL Network=[self Reachability_To_Chechk_Network];
    
    if(Network){
  NSString *urlString;
    urlString=[NSString stringWithFormat:@"http://74.208.12.101/Carboservices/create_policy_ios.php?user_id=%@&class=%@&year_of_manufacture=%@&vehical_name=%@&engine_capacity=%@&vehical_model=%@&vehicle_bodyType=%@&pplicant_status=%@&no_claim_discount=%@&date_of_birth=%@&driving_expiry=%@&job_industry=%@&job_position=%@&sum_insured=%@&policy_id=%@",user_id,class,year_of_manufacture,vehical_name,engine_capacity,vehical_model,vehicle_bodyType,applicant_status,no_claim_discount,date_of_birth,driving_expiry,job_industry,job_position,sum_insured,policy_id];
    
 urlString=[NSString stringWithFormat:@"http://74.208.12.101/Carboservices/create_policy_ios.php?user_id=%@&policy_id=%@",user_id,policy_id];
        
        NSLog(@"urlString :: %@",urlString);
        // setting up the request object now
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
    /*
         add some header info now
         we always need a boundary when we post a file
         also we need to set the content type
         
         You might want to generate a random boundary.. this is just the same
         as my output from wireshark on a valid html post
    */
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 
    NSMutableData *body = [NSMutableData data];
        
// NSString *user_id=@"USer";// = userID;
        NSLog(@"user_id :: %@",user_id);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
    NSLog(@"class :: %@",class);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"class\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:class] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"year_of_manufacture :: %@",year_of_manufacture);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"year_of_manufacture\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:year_of_manufacture] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"vehical_name :: %@",vehical_name);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehical_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:vehical_name] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"engine_capacity :: %@",engine_capacity);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"engine_capacity\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:engine_capacity] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"vehical_model :: %@",vehical_model);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehical_model\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:vehical_model] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"vehicle_bodyType :: %@",vehicle_bodyType);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vehicle_bodyType\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:vehicle_bodyType] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"applicant_status :: %@",applicant_status);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"applicant_status\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:applicant_status] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
     NSLog(@"no_claim_discount :: %@",no_claim_discount);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"no_claim_discount\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:no_claim_discount] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"date_of_birth :: %@",date_of_birth);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"date_of_birth\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:date_of_birth] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"driving_expiry :: %@",driving_expiry);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"driving_expiry\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:driving_expiry] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"job_industry :: %@",job_industry);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"job_industry\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:job_industry] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"job_position :: %@",job_position);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"job_position\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:job_position] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"sum_insured :: %@",sum_insured);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sum_insured\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:sum_insured] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
//    policy_id
    NSLog(@"policy_id :: %@",policy_id);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"policy_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:policy_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
//
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo_pics\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
        
        
        // NSLog(@"Body :: %@",body);
        // now lets make the connection to the web
     NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     NSLog(@"Return Data :: %@",returnData);
    
     NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
     NSDictionary *jsonObject=[NSJSONSerialization
                              JSONObjectWithData:returnData
                              options:NSJSONReadingMutableLeaves
                              error:nil];
//  NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:(NSString*)returnData];
//  {"response_code":"Success","response_message":"User logged in successfully!","name":"dinesh","username":"dineshd","email":"dinesh1@gmail.com","phone":"283872891"}
     NSLog(@"JS :: %@",jsonObject); 
//    
//   "quotation_id" = 148;
//   result = Success;
     NSLog(@"Return Data :: %@",returnString);
//    
//    NSString *haystack = @"value:hello World:value";
//    NSString *haystackPrefix = @"";
//    NSString *haystackSuffix = @":value";
//    NSRange needleRange = NSMakeRange(haystackPrefix.length,
//                                      haystack.length - haystackPrefix.length - haystackSuffix.length);
//    NSString *needle = [returnString substringWithRange:needleRange];
//    NSLog(@"needle: %@", needle); // -> "hello World"
    

//    NSString *myString = @"abcdefg";
//    NSString *mySmallerString = [returnString substringToIndex:7];
//    NSLog(@"Mysmall string :: %@",mySmallerString);
//    
      NSString *str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"result"]];
    
if([str isEqualToString:@"Success"])
    {
      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Registration of Car Successfully!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [alert show];
        
      str=[NSString stringWithFormat:@"%@",[jsonObject valueForKey:@"quotation_id"]];
   
      [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"QuotationID"];
      [[NSUserDefaults standardUserDefaults]synchronize];
      [self performSegueWithIdentifier:@"CTOP" sender:self]; 
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Registration Issue check network & fields entered" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please check Network connnection" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
 }
else
  {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please Enter all Fields properly" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
  }
}

#pragma mark -- Reachability
-(BOOL)Reachability_To_Chechk_Network
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        NSLog(@"Not REachable");
        return NO;
        //No internet
    }
    else if (status == ReachableViaWiFi)
    {
        NSLog(@"REachable via WIFI");
        //WiFi
        return YES;
    }
    else if (status == ReachableViaWWAN)
    {
        NSLog(@"REachable Mobile network 3G");
        //3G
        return YES;
    }
    else
    {
        NSLog(@"Not Reachable");
        return NO;
    }
}

#pragma mark  - AlertStatus
-(void) alertStatus:(NSString *)msg :(NSString *)title :(int)setTag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"                                              otherButtonTitles:nil, nil];
    alertView.tag = setTag;
    NSLog(@"tag %d", setTag);
    [alertView show];
}

#pragma mark -- TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField;  
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField 
{
      [pView removeFromSuperview];
    
    NSString *str=[NSString stringWithFormat:@"%ld",(long)textField.tag];

    // NSLog(@"TExtfieldLog :: %@",str);
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.carTableview];
    NSIndexPath *indexPath1 = [carTableview indexPathForRowAtPoint:point];
    
 // It works for Changing the position of the tableview for selected row  
 // [self.carTableview selectRowAtIndexPath:indexPath1 animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    NSInteger inte = (NSInteger)indexPath1;
    NSLog(@"indexPath1 :: %ld",(long)indexPath1.row);
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

    


//    Code working of Drag on keyboard
//    CGRect rect1 = self.view.frame;
//    rect1.origin.y = 0.0f;
//    rect1.size.height = 768.0f;
//    self.view.frame = rect1;
    
    // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:inte inSection:0];
    
    //   [self.exercise_Tableview scrollRectToVisible:aRect animated:YES];
    // [self.exercise_Tableview scrollToRowAtIndexPath:indexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    // [self.exercise_Tableview scrollToRowAtIndexPath:[self.exercise_Tableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //// UITableViewCell *cell;
    //    
    //    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
    //        // Load resources for iOS 6.1 or earlier
    //        cell = (UITableViewCell *) textField.superview.superview;
    //        
    //    } else {
    //        // Load resources for iOS 7 or later
    //        cell = (UITableViewCell *) textField.superview.superview.superview; 
    //        // TextField -> UITableVieCellContentView -> (in iOS 7!)ScrollView -> Cell!
    //    }
    //   
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField; 
{      
   NSString *str=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    // NSLog(@"TExtfieldLog :: %@",str);
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.carTableview];
    
    NSIndexPath * indexPath1 = [self.carTableview indexPathForRowAtPoint:point];
    
     NSLog(@"Indexpath :: %ld ",(long)indexPath1.row);    
        
        if([str isEqualToString:@"111"]||[str isEqualToString:@"112"]||[str isEqualToString:@"113"]||[str isEqualToString:@"114"]||[str isEqualToString:@"115"]||[str isEqualToString:@"116"]||[str isEqualToString:@"118"]||[str isEqualToString:@"120"]||[str isEqualToString:@"121"]||[str isEqualToString:@"122"]||[str isEqualToString:@"123"]||[str isEqualToString:@"126"]||[str isEqualToString:@"125"])
        {
            //[exercise_MArray  insertObject:textField.text  atIndex:indexPath1.row];
            [userDetails  replaceObjectAtIndex:indexPath1.row withObject:textField.text];
        }
    
  [textField resignFirstResponder];
    
   NSLog(@"userDetails :: %@",userDetails);

//        else if([str isEqualToString:@"1002"]||[str isEqualToString:@"2002"]||[str isEqualToString:@"3002"])
//        {
//            [weightofExercise  insertObject:textField.text atIndex:indexPath1.row];
//        }
//        else if ([str isEqualToString:@"1004"]||[str isEqualToString:@"2004"]||[str isEqualToString:@"3004"])
//        {
//            [restofExercise  insertObject:textField.text  atIndex:indexPath1.row];
//        }
//        else if ([str isEqualToString:@"1006"]||[str isEqualToString:@"2006"]||[str isEqualToString:@"3006"])
//        {
//            [repsofExercise  insertObject:textField.text  atIndex:indexPath1.row];
//        }
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

//- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize
// {
//    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width*0.2, newSize.height*0.2));
//    CGImageRef imageRef = image.CGImage;
//    
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    // Set the quality level to use when rescaling
//    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
//    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
//    
//    CGContextConcatCTM(context, flipVertical);
//    // Draw into the context; this scales the image
//    CGContextDrawImage(context, newRect, imageRef);
//    
//    // Get the resized image from the context and a UIImage
//    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    
//    CGImageRelease(newImageRef);
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}

#pragma mark -- Touches & PrepareForSegue
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [pView removeFromSuperview];

//        [menuView removeFromSuperview];
//        [carTableview removeFromSuperview];
//        [sublayer removeFromSuperlayer];
//        TableFlag= NO;  
    
NSLog(@"CAlled Touches ");
[cell.name_textfield resignFirstResponder];
[UIView animateWithDuration:0.3 animations:^{
// [sideview setFrame:CGRectMake(-133, 0, sideview.frame.size.width,sideview.frame.size.height)];
        }];
}

//
//CTOP
-(IBAction)Called_Policy_Details:(id)sender
{

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{ 
  if([[segue identifier] isEqualToString:@"CTOP"]) 
    {
        
    }
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
//  [UIView beginAnimations:nil context:NULL];
// [UIView setAnimationDuration:0.3]; // if you want to slide up the view
     int m = (int) Movevalue;
//        
//        NSLog(@"checkMoveval :: %d m :: %d",checkMoveval,m);  
//        
//        int i=100;
//        i=i*m;
//        CGRect rect = self.view.frame;
//        if(movedUp)
//        {
//            // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
//            // 2. increase the size of the view so that the area behind the keyboard is covered up.
//            rect.origin.y -= i;
//            rect.size.height += i;
//            checkMoveval = m;
//        }
//        else
//        {
//            // revert back to the normal state.
//            rect.origin.y +=i ;
//            rect.size.height -= i;
//            checkMoveval = m;
//        }
//        self.view.frame = rect;
//        NSLog(@"origin.y :: %f,origin.x:: %f,size.height:: %f", rect.origin.y, rect.origin.x, rect.size.height);
        
       // [UIView commitAnimations];
        
        //if(checkMoveval == m)
        //{
        ////    CGRect rect1 = self.view.frame;
        ////    rect1.origin.y = 0.0f;
        ////    rect1.size.height = 768.0f;
        ////    self.view.frame = rect1;
        //}
        //else
        //{
        //        CGRect rect1 = self.view.frame;
        //        rect1.origin.y = 0.0f;
        //        rect1.size.height = 768.0f;
        //        self.view.frame = rect1;
        //    
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
 
   NSLog(@"Frame Transform :: origin.y :: %f,origin.x:: %f,size.height:: %f", rect.origin.y, rect.origin.x, rect.size.height);

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
