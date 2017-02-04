//
//  CameraFocus.h
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import AVFoundation;

#import "CameraFocusView.h"

@interface CameraFocus : NSObject

+ (void)focusWithCaptureSession:(AVCaptureSession *)session touchPoint:(CGPoint)touchPoint inFocusView:(UIView *)focusView;

@end
