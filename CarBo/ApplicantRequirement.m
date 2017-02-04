//
//  ApplicantRequirement.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "ApplicantRequirement.h"
#import "car_registration.h"
#import "Constant.h"
#import "CarPolicy.h"
@interface ApplicantRequirement ()
 {
  
}
@end

@implementation ApplicantRequirement
@synthesize tfAttributedString1,tfAttributedString2;
- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"Agreement";
    
    UIColor *colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0];
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *sublang=[language substringToIndex:2];
    
    //NSLog(@"sub_language :: %@",sublang);
    
    NSString *NSLQF = [NSString stringWithFormat:NSLocalizedString(@"Applicant Status", nil)];
    
//    if([sublang isEqualToString:@"en"])
//    {
//        
//       // NSString *NSLQF = [NSString stringWithFormat:NSLocalizedString(@"Applicant Requirement", nil)];
//        
//        scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1950)];
//        
//        if(IS_IPHONE_6P)
//        {
//            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+100)];
//        }
//        else if(IS_IPHONE_6)
//        {
//            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+200)];
//        }
//        else if(IS_IPHONE_5)
//        {
//            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1650)];
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1950)];
//        }
//        else
//        {
//            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1450)];
//        }
//  
//        scrollview.showsVerticalScrollIndicator=YES;
//        scrollview.alwaysBounceHorizontal=NO;
//        scrollview.alwaysBounceVertical=YES;
//        scrollview.scrollEnabled=YES;
//        scrollview.userInteractionEnabled=YES;
//        scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+3600);
//        
//        if(IS_IPHONE_6P)
//        {
//            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+800);
//        }
//        else if(IS_IPHONE_6)
//        {
//            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1200);
//        }
//        else if(IS_IPHONE_5)
//        {
//            
//            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+2800);
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            
//            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+3000);
//        }
//        else
//        {
//            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1600);
//        }
//        
//        [self.view addSubview:scrollview];
//        
//        //    NSInteger viewcount= 4;
//        //    for (int i = 0; i <viewcount; i++)
//        //    {
//        //        CGFloat y = i * self.view.frame.size.height;
//        //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y,                                                      self.view.frame.size.width, self .view.frame.size.height)];
//        //        view.backgroundColor = [UIColor greenColor];
//        //       // [scrollview addSubview:view];
//        //   }
//        //   scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *viewcount);
//        
//        // //create a UIImage,set the imageName to your image name
//        ///Users/shirishvispute/Documents/IOS_Project/CarBo/CArbo TEST/CarBo/CarBo/Images/New/ic_agreement.png
//        UIImage *image = [UIImage imageNamed:@"ic_agreement.png"];
//        //create UIImageView and set imageView size to you image height
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-90)/2,10,70,70)];
//        [imageView setImage:image];
//        [scrollview addSubview:imageView];
//        
//        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//        style.alignment = NSTextAlignmentJustified;
//        style.firstLineHeadIndent = 10.0f;
//        style.headIndent = 10.0f;
//        style.tailIndent = -10.0f;
//        
//        titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-200)/2,70,200,50)];
//        titlelabel.numberOfLines=1;
//        titlelabel.text=NSLQF;
//        
//        [titlelabel setTextColor:colour];
//        [titlelabel setTextColor:[UIColor blackColor]];
//
//        [titlelabel setTextAlignment:NSTextAlignmentCenter];
//        //  [titlelabel setBackgroundColor:[UIColor redColor]];
//        [scrollview addSubview:titlelabel];
//        
//        if(IS_IPHONE_6P)
//        {
//            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,60,[[UIScreen mainScreen] bounds].size.width-20,1100)];
//            label1.numberOfLines=700;
//        }
//        else if(IS_IPHONE_6)
//        {
//            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,120,[[UIScreen mainScreen] bounds].size.width-20,1170)];
//            label1.numberOfLines=700;
//        }
//        else if(IS_IPHONE_5)
//        {
//            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,120,[[UIScreen mainScreen] bounds].size.width-20,1240)];
//            label1.numberOfLines=900;
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,110,[[UIScreen mainScreen] bounds].size.width-20,1770)];
//            label1.numberOfLines=700;
//        }
//        else
//        {
//            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,60,[[UIScreen mainScreen] bounds].size.width-20,1500)];
//            label1.numberOfLines=700;
//            
//        }
//        
//        //    label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,50,[[UIScreen mainScreen] bounds].size.width-20,1770)];
//        //    label1.numberOfLines=900;
//        //  [label1 setBackgroundColor:[UIColor lightGrayColor]];
//        
//        [scrollview addSubview:label1];
//        
//        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"For any person who apply for the motor insurance from this App, the applicant must agree and confirm the terms and conditions below, in order to make the policy effective: \n \n 1. The Applicant must be the car owner and 1st named driver. \n \n 2. All named driver(s) are aged 25 to 69, and the driving experience is 2 years or above, holding with valid driving license and incurred not more than 9 points in Driving-offence Points System. \n \n 3. All named driver(s) incurred not more than 2 times of claims in latest 3 years, and all claims are not involved body injury and total claims amount not more than HK$60,000. \n \n 4. The Applicant and all named driver(s) did not involve any dangerous driving, drunk driving, drug driving or penalized with driving license suspension in latest 3 years. \n \n 5. The Applicant and all named driver(s) have never been refuse renewal by any insurers, cancel or additional terms in latest 3 years. \n \n 6. Insured vehicle cannot used for commercial purpose or rental use; Insurance of the insured vehicle will be expired within 3 months time. \n \n 7. The insured person agree not to lend the insured vehicle to a person to drive who is under 25 years of age or a person who has not held for a period of 2 years a driving licence. \n \n 8. This insurance is only suitable for motor vehicles within Geographical area, and cover motor (Vehicle Registered Class shown in Private Car only, others are not acceptable) accident caused within Geographical area. 'Geographical Area' means the territories of the Hong Kong Special Administrative Region and includes its territorial waters for the purpose of the transit of the Motor Car by sea (including incidental loading or unloading) by a craft designed for the carriage of motor cars. \n \n 9. Please fill out the information carefully, failure to provide adequate proof of the No Claims Discount you have declared may result in your premium being increased or your policy being cancelled. \n \n 10. This quotation is not valid for the applicant who applied his/her motor insurance with China Ping An through agency or broker in last year 'Agency Client'. *Our company reserved the right to cancel the online policy of 'Agency Client'. \n \n 11. Our company does not accept a copy NCD (If NCD is not successfully verified, Additional Premium will be charged for the discrepancy. \n        The quotation and the terms above may varies from time to time, our Company reserved the right to change without prior notice." attributes:@{ NSParagraphStyleAttributeName : style}];
//        
//        
//       
//        str = [[NSMutableAttributedString alloc]initWithString:NSLocalizedString(@"Agreement Text", nil) attributes:@{ NSParagraphStyleAttributeName : style}];
//        //  [str addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0,100)];
//         [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,171)];
//        //  [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0] range:NSMakeRange(0, 270)];
//        label1.attributedText = str;
//        
//        
//        //Agree Label
//        UILabel *agree = [[UILabel alloc]initWithFrame:CGRectMake(40,label1.frame.size.height,180,40)];
//        
//        
//        
//        if(IS_IPHONE_6P)
//        {
//            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+10,[[UIScreen mainScreen] bounds].size.width-20,40)];
//        }
//        else if(IS_IPHONE_6)
//        {
//            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+100,[[UIScreen mainScreen] bounds].size.width-20,40)];
//        }
//        else if(IS_IPHONE_5)
//        {
//            agree = [[UILabel alloc]initWithFrame:CGRectMake(40,label1.frame.size.height+120,[[UIScreen mainScreen] bounds].size.width-20,40)];
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+160,[[UIScreen mainScreen] bounds].size.width-20,40)];
//        }
//        else
//        {
//            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+10,[[UIScreen mainScreen] bounds].size.width-20,40)];
//        }
//        //從圖庫選取
//        
//        NSString *COI = [NSString stringWithFormat:NSLocalizedString(@"Agree the terms", nil)];
//        NSString *COIF = [NSString stringWithFormat:@"%@  ::",COI];
//        
//        agree.text=COIF;
//        [agree setTextColor:colour];
//        [agree setFont:[UIFont boldSystemFontOfSize:17]];
//        [scrollview addSubview:agree];
//        
//        //  UILabel *disagree = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width+70)/2,1700,100,40)];
//        //  disagree.text=@"Agree";
//        //  [scrollview addSubview:disagree];
//        
//        //Switch Button
//        switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,1820,50,40)];
//        
//        if(IS_IPHONE_6P)
//        {
//            switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+15,50,40)];
//        }
//        else if(IS_IPHONE_6)
//        {
//            switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+105,50,40)];
//        }
//        else if(IS_IPHONE_5)
//        {
//            switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+125,50,40)];
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            // switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+115,50,40)];
//            switchbtn = [[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+165,50,40)];
//        }
//        else
//        {
//            switchbtn=[[UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+165,50,40)];
//        }
//        
//        [switchbtn setOn:NO];
//        //[switchbtn setThumbTintColor:[UIColor whiteColor]];
//        [switchbtn setOnTintColor:colour];
//        [scrollview addSubview:switchbtn];
//        
//        
//        //Second Label ::
//        LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,1850,[[UIScreen mainScreen] bounds].size.width-10,190)];
//        
//        if(IS_IPHONE_6P)
//        {
//            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+40,[[UIScreen mainScreen] bounds].size.width-10,190)];
//        }
//        else if(IS_IPHONE_6)
//        {
//            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+160,[[UIScreen mainScreen] bounds].size.width-10,190)];
//        }
//        else if(IS_IPHONE_5)
//        {
//            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+160,[[UIScreen mainScreen] bounds].size.width-10,190)];
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+160,[[UIScreen mainScreen] bounds].size.width-10,190)];
//        }
//        else
//        {
//            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+40,[[UIScreen mainScreen] bounds].size.width-10,190)];
//        }
// 
//        LastLabel.numberOfLines=15;
//        
//        
//        NSMutableAttributedString *str2;
//        
//        //  str2 = [[NSMutableAttributedString alloc] initWithString:@"    本人/本公司同意及確認符合以上投保資格及條款，並清楚明白此聲明將構成所投保保單的重要部份。" attributes:@{ NSParagraphStyleAttributeName : style}];
//        str2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Agreement Text2", nil) attributes:@{ NSParagraphStyleAttributeName : style}];
//        
//        [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0,271)];
//        LastLabel.attributedText=str2;
//        [scrollview addSubview:LastLabel];
//        
//        // Continue Button
//        
//        continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,2050,[[UIScreen mainScreen] bounds].size.width-20,50)];
//        
//        [continueBtn setTitle:NSLocalizedString(@"CONTINUE", nil) forState:UIControlStateNormal];
//        
//        if(IS_IPHONE_6P)
//        {
//            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+210,[[UIScreen mainScreen] bounds].size.width-20,50)];
//        }
//        else if(IS_IPHONE_6)
//        {
//            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+340,[[UIScreen mainScreen] bounds].size.width-20,50)];
//        }
//        else if(IS_IPHONE_5)
//        {
//            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+350,[[UIScreen mainScreen] bounds].size.width-20,50)];
//        }
//        else if(IS_IPHONE_4_OR_LESS)
//        {
//            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+310,[[UIScreen mainScreen] bounds].size.width-20,50)];
//        }
//        else
//        {
//            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+210,[[UIScreen mainScreen] bounds].size.width-20,50)];
//        }
//        
//        //  UIImage *img=[UIImage imageNamed:@"btn-next.png"];
//        //[continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
//         [continueBtn setTitle:NSLocalizedString(@"CONTINUE", nil) forState:UIControlStateNormal];
//        [continueBtn setTitleColor:colour forState:UIControlStateNormal];
//        
//        //[continueBtn setBackgroundImage:img forState:UIControlStateNormal];
//        [continueBtn addTarget:self
//                        action:@selector(continuebuttonclicked:)
//              forControlEvents:UIControlEventTouchUpInside];
//        continueBtn.layer.cornerRadius=5;
//        continueBtn.layer.borderWidth=1;
//        continueBtn.layer.borderColor=[colour CGColor];
//        [scrollview addSubview:continueBtn];
//        
//        //Left side back Btn
//        UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
//        [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
//        [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    }
//    else
    {
        scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1950)];
        
        if(IS_IPHONE_6P)
        {
            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+300)];
        }
        else if(IS_IPHONE_6)
        {
            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+300)];
        }
        else if(IS_IPHONE_5)
        {
            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1250)];
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1450)];
        }
        else
        {
            scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+1250)];
        }
        
        scrollview.showsVerticalScrollIndicator=YES;
        scrollview.alwaysBounceHorizontal=NO;
        scrollview.alwaysBounceVertical=YES;
        scrollview.scrollEnabled=YES;
        scrollview.userInteractionEnabled=YES;
        // [scrollview setBackgroundColor:[UIColor redColor]];
        scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+3600);
        
        if(IS_IPHONE_6P)
        {
            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+800);
        }
        else if(IS_IPHONE_6)
        {
            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+800);
        }
        else if(IS_IPHONE_5)
        {
            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+2000);
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+2200);
        }
        else
        {
            scrollview.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height+900);
        }
        [self.view addSubview:scrollview];

        UIImage *image = [UIImage imageNamed:@"ic_agreement.png"];
        //create UIImageView and set imageView size to you image height
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-70)/2,10,70,70)];
        
        [imageView setImage:image];
        [scrollview addSubview:imageView];
        
        NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.alignment = NSTextAlignmentJustified;
        style.firstLineHeadIndent = 10.0f;
        style.headIndent = 10.0f;
        style.tailIndent = -10.0f;
        
        titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-200)/2,70,200,50)];
        titlelabel.numberOfLines=1;
        
       // NSString *NSLQF = [NSString stringWithFormat:NSLocalizedString(@"Application Requirement", nil)];
        titlelabel.text=NSLQF;
       // [titlelabel setTextColor:colour];
        [titlelabel setTextColor:[UIColor blackColor]];
        [titlelabel setTextAlignment:NSTextAlignmentCenter];
        //  [titlelabel setBackgroundColor:[UIColor redColor]];
        [scrollview addSubview:titlelabel];
        
        if(IS_IPHONE_6P)
        {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,120,[[UIScreen mainScreen] bounds].size.width-20,670)];
            label1.numberOfLines=700;
        }
        else if(IS_IPHONE_6)
        {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,120,[[UIScreen mainScreen] bounds].size.width-20,740)];
            label1.numberOfLines=700;
        }
        else if(IS_IPHONE_5)
        {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,120,[[UIScreen mainScreen] bounds].size.width-20,820)];
            label1.numberOfLines=900;
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,110,[[UIScreen mainScreen] bounds].size.width-20,800)];
            label1.numberOfLines=900;
        }
        else
        {
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,120,[[UIScreen mainScreen] bounds].size.width-20,570)];
            label1.numberOfLines=700;
        }
        
        //    label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,50,[[UIScreen mainScreen] bounds].size.width-20,1770)];
        //    label1.numberOfLines=900;
        //  [label1 setBackgroundColor:[UIColor lightGrayColor]];
        
        [scrollview addSubview:label1];
        
        NSMutableAttributedString *str;
        
        str = [[NSMutableAttributedString alloc]initWithString:NSLocalizedString(@"Agreement Text", nil) attributes:@{ NSParagraphStyleAttributeName : style}];
        
        //    CGSize maximumLabelSize = CGSizeMake(296,9999);
        //
        //    CGSize expectedLabelSize = [yourString sizeWithFont:yourLabel.font
        //                                      constrainedToSize:maximumLabelSize
        //                                          lineBreakMode:yourLabel.lineBreakMode];
        //
        //    //adjust the label the the new height.
        //    CGRect newFrame = yourLabel.frame;
        //    newFrame.size.height = expectedLabelSize.height;
        //    yourLabel.frame = newFrame;
        
        //  [str addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0,100)];
        // ****** Color Code for text *******
        //    [str addAttribute:NSForegroundColorAttributeName value:colour range:NSMakeRange(2,5)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(161,7)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(193,2)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(211,2)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(218,2)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(244,7)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(272,5)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(321,5)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(378,14)];
        //[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(462,5)];
        //  [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0] range:NSMakeRange(0, 270)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,39)];
        label1.attributedText = str;
        
        //Agree Label
        UILabel *agree = [[UILabel alloc]initWithFrame:CGRectMake(40,label1.frame.size.height,180,40)];
        
        
        
        if(IS_IPHONE_6P)
        {
            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+100,[[UIScreen mainScreen] bounds].size.width-20,40)];
        }
        else if(IS_IPHONE_6)
        {
            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+100,[[UIScreen mainScreen] bounds].size.width-20,40)];
        }
        else if(IS_IPHONE_5)
        {
            agree = [[UILabel alloc]initWithFrame:CGRectMake(40,label1.frame.size.height+110,[[UIScreen mainScreen] bounds].size.width-20,40)];
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+110,[[UIScreen mainScreen] bounds].size.width-20,40)];
        }
        else
        {
            agree = [[UILabel alloc]initWithFrame:CGRectMake(30,label1.frame.size.height+110,[[UIScreen mainScreen] bounds].size.width-20,40)];
        }
        
        NSString *COI = [NSString stringWithFormat:NSLocalizedString(@"Agree the terms", nil)];
        NSString *COIF = [NSString stringWithFormat:@"%@  ::",COI];
        
        agree.text=COIF;
        [agree setTextColor:colour];
        [agree setFont:[UIFont boldSystemFontOfSize:17]];
        [scrollview addSubview:agree];
        
        //  UILabel *disagree = [[UILabel alloc]initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width+70)/2,1700,100,40)];
        //  disagree.text=@"Agree";
        //  [scrollview addSubview:disagree];
        
        //Switch Button
        switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,1820,50,40)];
        
        if(IS_IPHONE_6P)
        {
            switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+105,50,40)];
        }
        else if(IS_IPHONE_6)
        {
            switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+105,50,40)];
        }
        else if(IS_IPHONE_5)
        {
            switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+115,50,40)];
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            // switchbtn=[[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+115,50,40)];
            switchbtn = [[ UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+115,50,40)];
        }
        else
        {
            switchbtn=[[UISwitch alloc]initWithFrame:CGRectMake(210,label1.frame.size.height+115,50,40)];
        }
        
        [switchbtn setOn:NO];
        //[switchbtn setThumbTintColor:[UIColor whiteColor]];
        [switchbtn setOnTintColor:colour];
        [scrollview addSubview:switchbtn];
        
        
        //Second Label ::
        LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,1850,[[UIScreen mainScreen] bounds].size.width-10,190)];
        
        if(IS_IPHONE_6P)
        {
            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+110,[[UIScreen mainScreen] bounds].size.width-10,190)];
        }
        else if(IS_IPHONE_6)
        {
            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+110,[[UIScreen mainScreen] bounds].size.width-10,190)];
        }
        else if(IS_IPHONE_5)
        {
            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+140,[[UIScreen mainScreen] bounds].size.width-10,190)];
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+140,[[UIScreen mainScreen] bounds].size.width-10,190)];
        }
        else
        {
            LastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+160,[[UIScreen mainScreen] bounds].size.width-10,190)];
        }
     
        LastLabel.numberOfLines=15;

        
        NSMutableAttributedString *str2;
        
      //  str2 = [[NSMutableAttributedString alloc] initWithString:@"    本人/本公司同意及確認符合以上投保資格及條款，並清楚明白此聲明將構成所投保保單的重要部份。" attributes:@{ NSParagraphStyleAttributeName : style}];
        str2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Agreement Text2", nil) attributes:@{ NSParagraphStyleAttributeName : style}];
        [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,71)];
        LastLabel.attributedText=str2;
        [scrollview addSubview:LastLabel];
        
        // Continue Button
        
        continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,2050,[[UIScreen mainScreen] bounds].size.width-20,50)];
        
     if(IS_IPHONE_6P)
        {
            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+270,[[UIScreen mainScreen] bounds].size.width-20,50)];
        }
        else if(IS_IPHONE_6)
        {
            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+260,[[UIScreen mainScreen] bounds].size.width-20,50)];
        }
        else if(IS_IPHONE_5)
        {
            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+310,[[UIScreen mainScreen] bounds].size.width-20,50)];
        }
        else if(IS_IPHONE_4_OR_LESS)
        {
            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+310,[[UIScreen mainScreen] bounds].size.width-20,50)];
        }
        else
        {
            continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,label1.frame.size.height+310,[[UIScreen mainScreen] bounds].size.width-20,50)];
        }
        
        //  UIImage *img=[UIImage imageNamed:@"btn-next.png"];
       // [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
        [continueBtn setTitleColor:colour forState:UIControlStateNormal];
        [continueBtn setTitle:NSLocalizedString(@"CONTINUE", nil) forState:UIControlStateNormal];
        
        //[continueBtn setBackgroundImage:img forState:UIControlStateNormal];
        [continueBtn addTarget:self 
                        action:@selector(continuebuttonclicked:)
              forControlEvents:UIControlEventTouchUpInside];
        continueBtn.layer.cornerRadius=5;
        continueBtn.layer.borderWidth=1;
        continueBtn.layer.borderColor=[colour CGColor];
        [scrollview addSubview:continueBtn];
        
        //Left side back Btn
        UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
        [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    } //Chinese
  
}


-(IBAction)continuebuttonclicked:(id)sender
{
    if([switchbtn isOn])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CarPolicy *carpolicyobj =(CarPolicy*)[storyboard instantiateViewControllerWithIdentifier:@"CarPolicy"];
        [self.navigationController pushViewController:carpolicyobj animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Please accept terms and conditions", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
}

-(void)backJump1
{
  [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - colour Objects from hex Strings

-(UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
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


-(void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)formatTextInTextView:(UITextView *)textView
{
    textView.scrollEnabled = NO;
    NSRange selectedRange = textView.selectedRange;
    NSString *text = textView.text;
    
    // This will give me an attributedString with the base text-style
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:&error];
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, text.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match rangeAtIndex:0];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor redColor]
                                 range:matchRange];
    }
    textView.attributedText = attributedString;
    textView.selectedRange = selectedRange;
    textView.scrollEnabled = YES;
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
