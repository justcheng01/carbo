//
//  CameraFilters.h
//  Memojar
//
//  Created by Amol Bapat on 02/12/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CameraFilters)

- (UIImage *)curveFilter;
- (UIImage *)saturateImage:(CGFloat)saturation withContrast:(CGFloat)contrast;
- (UIImage *)vignetteWithRadius:(CGFloat)radius intensity:(CGFloat)intensity;

@end
