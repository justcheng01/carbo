//
//  Camera.h
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;
@import UIKit;

#define kTGCameraOptionSaveImageToDevice @"TGCameraOptionSaveImageToDevice"


@protocol CameraDelegate;


@interface Camera : NSObject

+ (instancetype)new __attribute__
((unavailable("[+new] is not allowed, use [+cameraWithRootView:andCaptureView:]")));

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+cameraWithRootView:andCaptureView:]")));

+ (instancetype)cameraWithFlashButton:(UIButton *)flashButton;
+ (void)setOption:(NSString*)option value:(id)value;
+ (id)getOption:(NSString*)option;

- (void)startRunning;
- (void)stopRunning;

- (AVCaptureVideoPreviewLayer *)previewLayer;
- (AVCaptureStillImageOutput *)stillImageOutput;

- (void)insertSublayerWithCaptureView:(UIView *)captureView atRootView:(UIView *)rootView;

- (void)disPlayGridView;

- (void)changeFlashModeWithButton:(UIButton *)button;

- (void)focusView:(UIView *)focusView inTouchPoint:(CGPoint)touchPoint;

- (void)takePhotoWithCaptureView:(UIView *)captureView
                  effectiveScale:(NSInteger)effectiveScale
                videoOrientation:(AVCaptureVideoOrientation)videoOrientation
                      completion:(void (^)(UIImage *))completion;

- (void)toogleWithFlashButton:(UIButton *)flashButton;

@end

@protocol CameraDelegate <NSObject>

- (void)cameraDidTakePhoto:(UIImage *)image;
- (void)cameraDidCancel;

@optional

- (void)cameraWillTakePhoto;

@end
