//
//  notificationCell.m
//  CarBo
//
//  Created by Shirish Vispute on 05/08/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "notificationCell.h"
#import "Constant.h"
@interface notificationCell ()

@end

@implementation notificationCell
@synthesize reviewlabel,name_textfield,review_Date,heading_Label,backgroundlabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        
          UIColor *colour = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
        
        UIColor *colourother = [self getUIColorObjectFromHexString:Klightcolor alpha:1.0];
         backgroundlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,[UIScreen mainScreen].bounds.size.width-20,90)];
        backgroundlabel.layer.cornerRadius=10;
        [backgroundlabel setClipsToBounds:YES];
        [backgroundlabel setBackgroundColor:colourother];
        [self addSubview:backgroundlabel];
        
        
        // Review Label
        reviewlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 27,[UIScreen mainScreen].bounds.size.width-40,60)];
        [[self reviewlabel] setTextColor:[UIColor blackColor]];
        [[self reviewlabel] setFont:[UIFont boldSystemFontOfSize:14]];
        [reviewlabel setNumberOfLines:4];
        reviewlabel.textAlignment = NSTextAlignmentLeft;
        [reviewlabel setTextColor:colour];
        // [reviewlabel setText:@"Exercise"];
        // [exercise_Lable setFont:boldFont];
        [reviewlabel setTextAlignment:NSTextAlignmentCenter];
        reviewlabel.layer.cornerRadius=10;
        [reviewlabel setClipsToBounds:YES];
        [reviewlabel setBackgroundColor:colourother];
        [self addSubview:reviewlabel];
        
        //review_Date
        review_Date=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-180,5,160,20)];
        [[self review_Date] setTextColor:[UIColor blackColor]];
        [[self review_Date] setFont:[UIFont boldSystemFontOfSize:12]];
        [review_Date setTextColor:[UIColor darkGrayColor]];
        review_Date.textAlignment = NSTextAlignmentCenter;
       [self addSubview:review_Date];
        
    }
    return self;
}


#pragma mark - color 


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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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
