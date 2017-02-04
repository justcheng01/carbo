//
//  CameraFlash.h
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;
@import UIKit;

@interface CameraFlash : NSObject

+ (void)changeModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button;
+ (void)flashModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button;

@end
