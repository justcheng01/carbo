//
//  carRegistrationCellTableViewCell.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "carRegistrationCell.h"
#import "Constant.h"
@implementation carRegistrationCell

@synthesize name_Label,name_textfield,logoImageView,backgroundlabel,logoDownArrow;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        backgroundlabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 300, 50)];
//        [[self backgroundlabel] setBackgroundColor:[UIColor lightGrayColor]];
//        [[self backgroundlabel] setFont:[UIFont boldSystemFontOfSize:12]];
       // [self addSubview:backgroundlabel];
        
        logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5,0, 32, 32)];
        // [logoImageView setBackgroundColor:[UIColor greenColor]];
     ///  [logoImageView setImage: [UIImage imageNamed:@"upload-icon.png"]];
      //  [logoImageView setImage:[UIImage imageNamed:@"icon7-48.png"]];

       // logoImageView.alpha = 0.5;
      //  logoImageView.layer.cornerRadius = 50;
       [self addSubview:logoImageView];
        
       UIColor *  maincolor = [self getUIColorObjectFromHexString:Kmaincolor alpha:1.0];
        
UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        
//        lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 5, 620, 1)];
//        [lineView setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0]];
//        [self addSubview:lineView];
     
        name_Label=[[UILabel alloc]initWithFrame:CGRectMake(45, 10,140,20)];
        [[self name_Label] setTextColor:[UIColor blackColor]];
        [[self name_Label] setFont:[UIFont boldSystemFontOfSize:12]];
        name_Label.textAlignment = NSTextAlignmentLeft;
        // [name_Label setText:@"Exercise"];
        // [exercise_Lable setFont:boldFont];
        [name_Label setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:name_Label];
     
        name_textfield=[[UITextField alloc]initWithFrame:CGRectMake(175,5, [[UIScreen mainScreen]bounds].size.width-215, 35)];
        name_textfield.borderStyle = UITextBorderStyleRoundedRect;
        
// [name_textfield setBackground:[UIImage imageNamed:@"btn-new-1.png"]];
//        name_textfield.layer.borderWidth = 2;
//        name_textfield.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
   
        [name_textfield setTextColor:[UIColor darkGrayColor]];
        [name_textfield setTextColor:maincolor];
        name_textfield.textAlignment = NSTextAlignmentLeft;
        name_textfield.delegate = self;
        name_textfield.autocorrectionType = UITextAutocorrectionTypeNo;
        // name_textfield.keyboardType = UIKeyboardTypeNumberPad;
                //name_textfield.tag=103;
        [self addSubview:name_textfield];
        
//        logoDownArrow=[[UIImageView alloc]initWithFrame:CGRectMake(245,15,15,15)];
//        [logoDownArrow setImage:[UIImage imageNamed:@"arrow1.png"]];
//        [self addSubview:logoDownArrow];

        
        

//        reps_Lable=[[UILabel alloc]initWithFrame:CGRectMake(350, 10, 100, 20)];
//        [[self reps_Lable] setTextColor:[UIColor lightGrayColor]];
//        [[self reps_Lable] setFont:[UIFont boldSystemFontOfSize:12]];
//        [reps_Lable setText:@"Reps"];
//        [reps_Lable setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:reps_Lable];
//        
//        reset_Lable=[[UILabel alloc]initWithFrame:CGRectMake(450, 10, 80, 20)];
//        [[self reset_Lable] setTextColor:[UIColor lightGrayColor]];
//        [[self reset_Lable] setFont:[UIFont boldSystemFontOfSize:12]];
//        [reset_Lable setText:@" Rest"];
//        //[reset_Lable setFont:boldFont];
//        [reset_Lable setTextAlignment:NSTextAlignmentCenter];
//        [self addSubview:reset_Lable];
//        
//        add_BTN=[[UIButton alloc]initWithFrame:CGRectMake(550, 37, 90, 30)];
//        [add_BTN setTitle:@"+ Add Set" forState:UIControlStateNormal];
//        //[add_BTN setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//        //[[self add_BTN] setFont:[UIFont systemFontOfSize:13]];
//        [add_BTN addTarget:self action:@selector(called:) forControlEvents:UIControlEventTouchUpInside];
//        //add_BTN.titleLabel.font = [UIFont fontWithName:@"Arial-MT" size:8.0];   //Font Code
//        // add_BTN.titleLabel.font = [UIFont systemFontOfSize:16];
//        [add_BTN setTitleColor:[UIColor colorWithRed:0/255.0 green:153/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
//        add_BTN.titleLabel.font = [UIFont boldSystemFontOfSize:12];
//        add_BTN.layer.borderWidth = 2;
//        add_BTN.layer.borderColor =  [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
//        //[add_BTN setTintColor:[UIColor greenColor]];
//        
//        //[add_BTN setBackgroundColor:[UIColor redColor]];
//        
//        [self addSubview:add_BTN];
//        
//        exercise_name=[[UITextField alloc]initWithFrame:CGRectMake(20, 35, 200, 35)];
//        // [exercise_name setBackground:[UIImage imageNamed:@"btn-new-1.png"]];
//        exercise_name.layer.borderWidth = 2;
//        exercise_name.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
//        [exercise_name setTextColor:[UIColor lightGrayColor]];
//        [exercise_name setTextAlignment:NSTextAlignmentCenter];
//        // exercise_name.tag=100;
//        exercise_name.delegate=self;
//        
//        [self addSubview:exercise_name];
//        
//        weight_text=[[UITextField alloc]initWithFrame:CGRectMake(260, 35, 80, 35)];
//        // [weight_text setBackground:[UIImage imageNamed:@"btn-new-1.png"]];
//        weight_text.layer.borderWidth = 2;
//        weight_text.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
//        [weight_text setTextColor:[UIColor lightGrayColor]];
//        [weight_text setTextAlignment:NSTextAlignmentCenter];
//        weight_text.delegate=self;
//        weight_text.keyboardType = UIKeyboardTypeNumberPad;
//        // exercise_name.tag=101;
//        [self addSubview:weight_text];
//        
//        reps_text=[[UITextField alloc]initWithFrame:CGRectMake(360, 35, 80, 35)];
//        // [reps_text setBackground:[UIImage imageNamed:@"btn-new-1.png"]];
//        reps_text.layer.borderWidth = 2;
//        reps_text.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
//        [reps_text setTextColor:[UIColor lightGrayColor]];
//        [reps_text setTextAlignment:NSTextAlignmentCenter];
//        reps_text.delegate=self;
//        reps_text.keyboardType = UIKeyboardTypeNumberPad;
//        //reps_text.tag=102;
//        [self addSubview:reps_text];
//        
//        name_textfield=[[UITextField alloc]initWithFrame:CGRectMake(460, 35, 80, 35)];
//        //[name_textfield setBackground:[UIImage imageNamed:@"btn-new-1.png"]];
//        name_textfield.layer.borderWidth = 2;
//        name_textfield.layer.borderColor = [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]CGColor];
//        [name_textfield setTextColor:[UIColor lightGrayColor]];
//        [name_textfield setTextAlignment:NSTextAlignmentCenter];
//        name_textfield.delegate=self;
//        name_textfield.keyboardType = UIKeyboardTypeNumberPad;
//        //name_textfield.tag=103;
//        [self addSubview:name_textfield];
//        
        //                
        //                time=[[UILabel alloc]initWithFrame:CGRectMake(80,55,70,15)];
        //                // [time setFont:[UIFont smallSystemFontSize]];
        //                //  [[self time] setBackgroundColor:[ui]];
        //                [[self time] setTextColor:[UIColor lightGrayColor]];
        //                [[self time] setFont:[UIFont systemFontOfSize:10]];
        //                [self addSubview:time];
        //                
        //                gender=[[UILabel alloc]initWithFrame:CGRectMake(150, 47,70,20)];
        //                [[self gender] setFont:[UIFont systemFontOfSize:10]];
        //                [self addSubview:gender];
        //                
        //        
        //                namelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 250, 30)];
        //                [self addSubview:self.namelabel];d//
        //        
        //                checkbtn=[[UIButton alloc]initWithFrame:CGRectMake(280, 3, 40, 40)];
        //                [checkbtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //                [checkbtn setImage:[UIImage imageNamed:@"checkbox_untick.png"] forState:UIControlStateNormal];
        //                [self addSubview:checkbtn];
        //        
        //                flag=[[UILabel alloc]init];
        //                flag.text=@"NO";
        //                [self addSubview:flag];
        //        
        
        // configure control(s)
  }
    return self;
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



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
