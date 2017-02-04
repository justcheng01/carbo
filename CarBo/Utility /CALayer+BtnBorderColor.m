//
//  CALayer+BtnBorderColor.m
//  FuelPadi
//
//  Created by Shirish Vispute on 02/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "CALayer+BtnBorderColor.h"

@implementation CALayer (BtnBorderColor)


-(void)setBorderIBColor:(UIColor*)color 
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderIBColor 
{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
