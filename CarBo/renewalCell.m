//
//  renewalCell.m
//  CarBo
//
//  Created by Shirish Vispute on 04/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "renewalCell.h"

@implementation renewalCell
@synthesize heading_Label,policy_id,created_Date,status,policy_id_value,created_Date_value,policy_type,policy_type_val,vehical_name,regMark_val,
regMark_Name,UploadBtn,rendelegate,manufactureLabel,heading_Label1,supplementaryDoc;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
         UIColor *colour = [self getUIColorObjectFromHexString:@"#16BC7B" alpha:1.0]; 
        
        //Heading_Label
        heading_Label=[[UILabel alloc]initWithFrame:CGRectMake(120,130,100,20)];
        [heading_Label setTextColor:[UIColor darkGrayColor]];
        [heading_Label setFont:[UIFont boldSystemFontOfSize:12]];
        heading_Label.textAlignment = NSTextAlignmentLeft;
        [heading_Label setText:@"34"];
        [heading_Label setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:heading_Label];
        
        NSString *PolicyId=[NSString stringWithFormat:NSLocalizedString(@"Policy id", nil)];

        heading_Label1=[[UILabel alloc]initWithFrame:CGRectMake(20,130,100,20)];
        [heading_Label1 setTextColor:colour];
        [heading_Label1 setFont:[UIFont boldSystemFontOfSize:12]];
        heading_Label1.textAlignment = NSTextAlignmentLeft;
        [heading_Label1 setText:PolicyId];
        // [exercise_Lable setFont:boldFont];
        [heading_Label1 setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:heading_Label1];
        
       
     NSString *Policytype=[NSString stringWithFormat:NSLocalizedString(@"Type", nil)];
        policy_type = [[UILabel alloc]initWithFrame:CGRectMake(20,10, 100,20)];
        [policy_type setTextColor:colour];
        [policy_type setFont:[UIFont boldSystemFontOfSize:12]];
        policy_type.textAlignment = NSTextAlignmentLeft;
        [policy_type setText:Policytype];
         [self addSubview:policy_type];

        policy_type_val = [[UILabel alloc]initWithFrame:CGRectMake(120,10,170,20)];
        [policy_type_val setTextColor:[UIColor darkGrayColor]];
        [policy_type_val setFont:[UIFont boldSystemFontOfSize:12]];
        policy_type_val.textAlignment = NSTextAlignmentLeft;
       [self addSubview:policy_type_val];
      
        
        // created_Date
        NSString *Date=[NSString stringWithFormat:NSLocalizedString(@"Date", nil)];

         created_Date=[[UILabel alloc]initWithFrame:CGRectMake(20,40,100,20)];
        [created_Date setTextColor:colour];
        [created_Date setFont:[UIFont boldSystemFontOfSize:12]];
        created_Date.textAlignment = NSTextAlignmentLeft;
        [created_Date setText:Date];
        // [exercise_Lable setFont:boldFont];
        [created_Date setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:created_Date];
        
        // created_Date_value
        created_Date_value = [[UILabel alloc]initWithFrame:CGRectMake(120,40,220,20)];
        [created_Date_value setTextColor:[UIColor darkGrayColor]];
        [created_Date_value setFont:[UIFont boldSystemFontOfSize:12]];
        created_Date_value.textAlignment = NSTextAlignmentLeft;
       [self addSubview:created_Date_value];
        
        //Regmark Label  // 20,10, 100,20
        NSString *RegMark=[NSString stringWithFormat:NSLocalizedString(@"Reg.Mark", nil)];

        regMark_Name = [[UILabel alloc]initWithFrame:CGRectMake(20,70, 100,20)];
        [regMark_Name setTextColor:colour];
        [regMark_Name setFont:[UIFont boldSystemFontOfSize:12]];
        regMark_Name.textAlignment = NSTextAlignmentLeft;
        [regMark_Name setText:RegMark];
       [self addSubview:regMark_Name];
        
        // Regmark_value  // 120,10,100,20
        regMark_val=[[UILabel alloc]initWithFrame:CGRectMake(120,70,220,20)];
        [regMark_val setTextColor:colour];
        [regMark_val setTextColor:[UIColor darkGrayColor]];
        [regMark_val setFont:[UIFont boldSystemFontOfSize:12]];
        regMark_val.textAlignment = NSTextAlignmentLeft;
       [self addSubview:regMark_val];
        
        NSString *Manufacture=[NSString stringWithFormat:NSLocalizedString(@"Manufacture", nil)];
        manufactureLabel=[[UILabel alloc]initWithFrame:CGRectMake(20,95,160,30)];
        [manufactureLabel setTextColor:colour];
       [manufactureLabel setFont:[UIFont boldSystemFontOfSize:12]];
       manufactureLabel.textAlignment = NSTextAlignmentLeft;
        [manufactureLabel setText:Manufacture];
        [manufactureLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:manufactureLabel];

        //Vehical_Name
        vehical_name=[[UILabel alloc]initWithFrame:CGRectMake(120,95,160,30)];
        [vehical_name setTextColor:[UIColor darkGrayColor]];
        [vehical_name setFont:[UIFont boldSystemFontOfSize:12]];
        [vehical_name setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:vehical_name];
        
        ///policy Status Pending Completed Processing
        status=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120,10,100,20)];
        [status setTextColor:colour];
        [status setFont:[UIFont boldSystemFontOfSize:12]];
        status.textAlignment = NSTextAlignmentCenter;
        [self addSubview:status];
        
      //  [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-120,130,100,20)]
        
        supplementaryDoc=[[UILabel alloc]initWithFrame:CGRectMake(20,160,100,20)];
        [supplementaryDoc setText:NSLocalizedString(@"Supplementary Doc", nil)];
        [supplementaryDoc setTextColor:colour];
        [supplementaryDoc setFont:[UIFont boldSystemFontOfSize:12]];
        supplementaryDoc.textAlignment = NSTextAlignmentLeft;
        [self addSubview:supplementaryDoc];
        
        UploadBtn=[[UIButton alloc]initWithFrame:CGRectMake(115,150,42,42)];
        [UploadBtn setTitle:@"Resubmit" forState:UIControlStateNormal];
        [UploadBtn addTarget:self action:@selector(calledResubmitmthd:) forControlEvents:UIControlEventTouchUpInside];
        [UploadBtn setImage:[UIImage imageNamed:@"resubmit.png"] forState:UIControlStateNormal];
        [self addSubview:UploadBtn];
    }
    return self;
}

-(void)calledResubmitmthd:(UIButton*)button;
{
    [rendelegate didselectImage:self];
}

#pragma mark - color
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

-(void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
