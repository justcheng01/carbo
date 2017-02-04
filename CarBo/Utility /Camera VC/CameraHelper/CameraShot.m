//
//  CameraShot.m
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//
@import AssetsLibrary;
#import "CameraShot.h"

@implementation CameraShot

+ (void)takePhotoCaptureView:(UIView *)captureView stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput effectiveScale:(NSInteger)effectiveScale videoOrientation:(AVCaptureVideoOrientation)videoOrientation completion:(void (^)(UIImage *))completion
{
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in [stillImageOutput connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    [videoConnection setVideoOrientation:videoOrientation];
    [videoConnection setVideoScaleAndCropFactor:effectiveScale];
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                  completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                      if (imageDataSampleBuffer != NULL) {
                                                          NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                          UIImage *image = [UIImage imageWithData:imageData];
                                                          completion(image);
                                                      }
                                                  }];
}


@end
