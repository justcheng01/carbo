//
//  CameraColor.m
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraColor.h"

@interface CameraColor()

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end



@implementation CameraColor

+ (UIColor *)grayColor
{
    return [self colorWithRed:200 green:200 blue:200];
}

+ (UIColor *)orangeColor
{
    return [self colorWithRed:51 green:25 blue:183];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    CGFloat divisor = 255.f;
    return [self colorWithRed:red/divisor green:green/divisor blue:blue/divisor alpha:1];
}

@end
