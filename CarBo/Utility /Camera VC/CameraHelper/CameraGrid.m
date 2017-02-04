//
//  CameraGrid.m
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraGrid.h"

@implementation CameraGrid

+ (void)disPlayGridView:(CameraGridView *)gridView
{
    NSInteger newAlpha = ([gridView alpha] == 0.) ? 1. : 0.;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        gridView.alpha = newAlpha;
    } completion:NULL];
}

@end
