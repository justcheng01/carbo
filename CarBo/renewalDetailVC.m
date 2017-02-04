//
//  renewalDetailVC.m
//  CarBo
//
//  Created by Shirish Vispute on 03/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "renewalDetailVC.h"
#import "PremiumDetails_FVC.h"
#import "Constant.h"
#import "Reachability.h"

@interface renewalDetailVC ()
{
    UIView *backview;
    UIButton *closebtn ;
    UIWebView *myWebView ;
}
@end

@implementation renewalDetailVC
@synthesize expiryDateValue,PolicyNoValue,FeesValue,  policy_name,documentInteractionController,renewalBtn,
      expiry_label,policy_label,premium_label;


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    self.navigationItem.title =NSLocalizedString(@"Policy Details", nil);
    //Left side back Btn
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44.0f, 30.0f)];
    [backButton setImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backJump1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [policy_name setText:NSLocalizedString(@"", nil)];


    [expiry_label setText:NSLocalizedString(@"Expiry Date", nil)];
    [policy_label setText:NSLocalizedString(@"Policy no", nil)];
    [premium_label setText:NSLocalizedString(@"Premium Amount", nil)];
    [_pdfbtn setTitle:NSLocalizedString(@"Policy PDF", nil) forState:UIControlStateNormal];
    [renewalBtn setTitle:NSLocalizedString(@"Renew Policy", nil) forState:UIControlStateNormal];
    
    
  NSString  *str=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_id"]];PolicyNoValue.text=str;
    
  str=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_Name"]];
   policy_name.text = str;
    
  str=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_expiry_date"]];
   expiryDateValue.text = str;
    
  str=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_pdf_url"]];

  str=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Previous_amount"]];
    FeesValue.text  = str;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSString *Home=[NSString stringWithFormat:NSLocalizedString(@"Policy Details", nil)];
    self.navigationItem.title = Home;
}

-(IBAction)Call_To_PDF_Viewer:(id)sender;
{
    id senderr;
   [self loadRemotePdf];
}

- (IBAction)previewDocument:(id)sender {
    
NSURL *URL = [[NSBundle mainBundle] URLForResource:@"http://www.axmag.com/download/pdfurl-guide" withExtension:@"pdf"];
if (URL)
    {
        // Initialize Document Interaction Controller
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        // Configure Document Interaction Controller
        [self.documentInteractionController setDelegate:self];
        
        // Preview PDF
        [self.documentInteractionController presentPreviewAnimated:YES];
    }
}

- (void)loadRemotePdf
{
    NSString *str=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Policy_pdf_url"]];
   
    NSString *code = [str substringFromIndex: [str length] - 4];
 
    if(![code isEqualToString:@"null"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
   else
   {
     UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"PDFFileNotAvailable", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)  otherButtonTitles: nil];
     [alertview show];
   } 
}


-(void)removeView
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

    [backview removeFromSuperview];
    [myWebView removeFromSuperview];
}


- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

-(IBAction)openDocument:(id)sender 
{
    UIButton *button = (UIButton *)sender;
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"http://www.axmag.com/download/pdfurl-guide" withExtension:@"pdf"];

    if(URL)
    {
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [self.documentInteractionController setDelegate:self];
     
        [self.documentInteractionController presentOpenInMenuFromRect:[button frame] inView:self.view animated:YES];
    }
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

-(IBAction)CAll_To_PremiumDetails:(id)sender;
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PremiumDetails_FVC *rootController =(PremiumDetails_FVC*)[storyboard instantiateViewControllerWithIdentifier:@"PremiumDetails_FVC"];
  
    NSString *str=@"YES";
    
    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"RD"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.navigationController pushViewController:rootController animated:YES];
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


-(void)backJump1
{
 [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
 [super didReceiveMemoryWarning];
}


@end
