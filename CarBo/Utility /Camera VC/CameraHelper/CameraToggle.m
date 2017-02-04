//
//  CameraToggle.m
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraToggle.h"
@interface CameraToggle ()

+ (AVCaptureDeviceInput *)reverseDeviceInput:(AVCaptureDeviceInput *)deviceInput;

@end

@implementation CameraToggle
#pragma mark -
#pragma mark - Public methods

+ (void)toogleWithCaptureSession:(AVCaptureSession *)session
{
    AVCaptureDeviceInput *deviceInput = [session.inputs lastObject];
    AVCaptureDeviceInput *reverseDeviceInput = [self reverseDeviceInput:deviceInput];
    
    [session beginConfiguration];
    [session removeInput:deviceInput];
    [session addInput:reverseDeviceInput];
    [session commitConfiguration];
}

#pragma mark -
#pragma mark - Private methods

+ (AVCaptureDeviceInput *)reverseDeviceInput:(AVCaptureDeviceInput *)deviceInput
{
    //
    // reverse device position
    //
    
    AVCaptureDevicePosition reversePosition;
    
    if ([deviceInput.device position] == AVCaptureDevicePositionFront) {
        reversePosition = AVCaptureDevicePositionBack;
    } else {
        reversePosition = AVCaptureDevicePositionFront;
    }
    
    //
    // find device with reverse position
    //
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *reverseDevice = nil;
    
    for (AVCaptureDevice *device in devices) {
        if ([device position] == reversePosition) {
            reverseDevice = device;
            break;
        }
    }
    
    //
    // reverse device input
    //
    
    return  [AVCaptureDeviceInput deviceInputWithDevice:reverseDevice error:nil];
}

@end
