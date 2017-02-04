//
//  Camera.m
//  Memojar
//
//  Created by Amol Bapat on 24/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//



#import "CameraGridView.h"
#import "CameraGrid.h"
#import "CameraFlash.h"
#import "CameraFocus.h"
#import "CameraShot.h"
#import "CameraToggle.h"
#import "Camera.h"

NSMutableDictionary *optionDictionary;

@interface Camera ()

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) CameraGridView *gridView;

+ (instancetype)newCamera;
+ (void)initOptions;

- (void)setupWithFlashButton:(UIButton *)flashButton;

@end

@implementation Camera

+ (instancetype)cameraWithFlashButton:(UIButton *)flashButton
{
    Camera *camera = [Camera newCamera];
    [camera setupWithFlashButton:flashButton];
    
    return camera;
}

+ (void)setOption:(NSString *)option value:(id)value
{
    if (optionDictionary == nil) {
        [Camera initOptions];
    }
    
    if (option != nil && value != nil) {
        optionDictionary[option] = value;
    }
}

+ (id)getOption:(NSString *)option
{
    if (optionDictionary == nil) {
        [Camera initOptions];
    }
    
    if (option != nil) {
        return optionDictionary[option];
    }
    
    return nil;
}

#pragma mark -
#pragma mark - Public methods

- (void)startRunning
{
    [_session startRunning];
}

- (void)stopRunning
{
    [_session stopRunning];
}

- (void)insertSublayerWithCaptureView:(UIView *)captureView atRootView:(UIView *)rootView
{
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    CALayer *rootLayer = [rootView layer];
    rootLayer.masksToBounds = YES;
    
    CGRect frame = captureView.frame;
    _previewLayer.frame = frame;
    
    [rootLayer insertSublayer:_previewLayer atIndex:0];
    
    NSInteger index = [captureView.subviews count]-1;
    [captureView insertSubview:self.gridView atIndex:index];
}

- (void)disPlayGridView
{
    [CameraGrid disPlayGridView:self.gridView];
}

- (void)changeFlashModeWithButton:(UIButton *)button
{
    [CameraFlash changeModeWithCaptureSession:_session andButton:button];
}

- (void)focusView:(UIView *)focusView inTouchPoint:(CGPoint)touchPoint
{
    [CameraFocus focusWithCaptureSession:_session touchPoint:touchPoint inFocusView:focusView];
}

- (void)takePhotoWithCaptureView:(UIView *)captureView effectiveScale:(NSInteger)effectiveScale videoOrientation:(AVCaptureVideoOrientation)videoOrientation completion:(void (^)(UIImage *))completion
{
    [CameraShot takePhotoCaptureView:captureView stillImageOutput:_stillImageOutput effectiveScale:effectiveScale videoOrientation:videoOrientation
                            completion:^(UIImage *photo) {
                                completion(photo);
                            }];
}

- (void)toogleWithFlashButton:(UIButton *)flashButton
{
    [CameraToggle toogleWithCaptureSession:_session];
    [CameraFlash flashModeWithCaptureSession:_session andButton:flashButton];
}

#pragma mark -
#pragma mark - Private methods

+ (instancetype)newCamera
{
    return [super new];
}

- (CameraGridView *)gridView
{
    if (_gridView == nil) {
        CGRect frame = _previewLayer.frame;
        frame.origin.x = frame.origin.y = 0;
        
        _gridView = [[CameraGridView alloc] initWithFrame:frame];
        _gridView.numberOfColumns = 2;
        _gridView.numberOfRows = 2;
        _gridView.alpha = 0;
    }
    
    return _gridView;
}

- (void)setupWithFlashButton:(UIButton *)flashButton
{
    //
    // create session
    //
    
    _session = [AVCaptureSession new];
    _session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //
    // setup device
    //
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device lockForConfiguration:nil]) {
        if (device.autoFocusRangeRestrictionSupported) {
            device.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
        }
        
        if (device.smoothAutoFocusSupported) {
            device.smoothAutoFocusEnabled = YES;
        }
        
        if([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        }
        
        device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        
        [device unlockForConfiguration];
    }
    
    //
    // add device input to session
    //
    
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [_session addInput:deviceInput];
    
    //
    // add output to session
    //
    
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    
    _stillImageOutput = [AVCaptureStillImageOutput new];
    _stillImageOutput.outputSettings = outputSettings;
    
    [_session addOutput:_stillImageOutput];
    
    //
    // setup flash button
    //
    
    [CameraFlash flashModeWithCaptureSession:_session andButton:flashButton];
}

+ (void)initOptions
{
    optionDictionary = [NSMutableDictionary dictionary];
    optionDictionary[kTGCameraOptionSaveImageToDevice] = [NSNumber numberWithBool:YES];
}


@end
