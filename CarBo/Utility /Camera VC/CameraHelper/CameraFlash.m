//
//  CameraFlash.m
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraFlash.h"

@implementation CameraFlash

#pragma mark -
#pragma mark - Public methods

+ (void)changeModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button
{
    AVCaptureDevice *device = [session.inputs.lastObject device];
    AVCaptureFlashMode mode = [device flashMode];
    
    [device lockForConfiguration:nil];
    
    switch ([device flashMode]) {
        case AVCaptureFlashModeAuto:
            mode = AVCaptureFlashModeOn;
            break;
            
        case AVCaptureFlashModeOn:
            mode = AVCaptureFlashModeOff;
            break;
            
        case AVCaptureFlashModeOff:
            mode = AVCaptureFlashModeAuto;
            break;
    }
    
    if ([device isFlashModeSupported:mode]) {
        device.flashMode = mode;
    }
    
    [device unlockForConfiguration];
    
    [self flashModeWithCaptureSession:session andButton:button];
}

+ (void)flashModeWithCaptureSession:(AVCaptureSession *)session andButton:(UIButton *)button
{
    AVCaptureDevice *device = [session.inputs.lastObject device];
    AVCaptureFlashMode mode = [device flashMode];
    UIImage *image = UIImageFromAVCaptureFlashMode(mode);
    
    button.enabled = [device isFlashModeSupported:mode];
    [button setImage:image forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - Private methods

UIImage *UIImageFromAVCaptureFlashMode(AVCaptureFlashMode mode)
{
    NSArray *array = @[@"CameraFlashOff", @"CameraFlashOn", @"CameraFlashAuto"];
    NSString *imageName = [array objectAtIndex:mode];
    return [UIImage imageNamed:imageName];
}

@end
