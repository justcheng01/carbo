//
//  maincell.m
//  CarBo
//
//  Created by Shirish Vispute on 27/09/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "maincell.h"

@implementation maincell

@synthesize name_Label,name_textfield,iconimageview;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        name_Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 160,20)];
        [[self name_Label] setTextColor:[UIColor whiteColor]];
        [[self name_Label] setFont:[UIFont boldSystemFontOfSize:12]];
        name_Label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:name_Label];
        
        iconimageview = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 45, 45)];
        [self addSubview:iconimageview];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
