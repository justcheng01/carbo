//
//  CameraToggle.h
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AVFoundation;

@interface CameraToggle : NSObject

+ (void)toogleWithCaptureSession:(AVCaptureSession *)session;

@end
