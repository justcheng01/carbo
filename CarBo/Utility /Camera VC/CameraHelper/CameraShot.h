//
//  CameraShot.h
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;
@import UIKit;
@interface CameraShot : NSObject

+ (void)takePhotoCaptureView:(UIView *)captureView
            stillImageOutput:(AVCaptureStillImageOutput *)stillImageOutput
              effectiveScale:(NSInteger)effectiveScale
            videoOrientation:(AVCaptureVideoOrientation)videoOrientation
                  completion:(void (^)(UIImage *photo))completion;

@end
