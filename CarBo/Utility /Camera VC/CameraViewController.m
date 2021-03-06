//
//  CameraViewController.m
//  Memojar
//
//  Created by Amol Bapat on 19/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraViewController.h"
//#import "PhotoViewController.h"
//#import "PhotoViewController.h"
//#import "CameraSlideView.h"

@interface CameraViewController ()

@property (strong, nonatomic) IBOutlet UIView *captureView;
@property (strong, nonatomic) IBOutlet UIImageView *topLeftView;
@property (strong, nonatomic) IBOutlet UIImageView *topRightView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomLeftView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomRightView;
@property (strong, nonatomic) IBOutlet UIView *separatorView;
@property (strong, nonatomic) IBOutlet UIButton *gridButton;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;
@property (strong, nonatomic) IBOutlet UIButton *shotButton;
@property (strong, nonatomic) IBOutlet UIButton *flashButton;
//@property (strong, nonatomic) IBOutlet CameraSlideView *slideUpView;
//@property (strong, nonatomic) IBOutlet CameraSlideView *slideDownView;

@property (strong, nonatomic) Camera *camera;
@property (nonatomic) CGFloat beginPinchGestureScale;
@property (nonatomic) CGFloat effectiveScale;
@property (nonatomic) BOOL wasLoaded;

- (IBAction)closeTapped;
- (IBAction)gridTapped;
- (IBAction)flashTapped;
- (IBAction)shotTapped;
- (IBAction)toggleTapped;
- (IBAction)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer;

- (AVCaptureVideoOrientation)videoOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (void)zoomWithRecognizer:(UIPinchGestureRecognizer *)recognizer;

@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _camera = [Camera cameraWithFlashButton:_flashButton];
    _effectiveScale = 1.;
    
    _captureView.backgroundColor = [UIColor clearColor];
    
    _topLeftView.transform = CGAffineTransformMakeRotation(0);
    _topRightView.transform = CGAffineTransformMakeRotation(M_PI_2);
    _bottomLeftView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _bottomRightView.transform = CGAffineTransformMakeRotation(M_PI_2*2);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    _separatorView.hidden = NO;
    _topLeftView.hidden =
    _topRightView.hidden =
    _bottomLeftView.hidden =
    _bottomRightView.hidden = YES;
    
    _gridButton.enabled =
    _toggleButton.enabled =
    _shotButton.enabled =
    _flashButton.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self deviceOrientationDidChangeNotification];
    
    [_camera startRunning];
    
    _separatorView.hidden = YES;
    
//    [TGCameraSlideView hideSlideUpView:_slideUpView slideDownView:_slideDownView atView:_captureView completion:^{
//        _topLeftView.hidden =
//        _topRightView.hidden =
//        _bottomLeftView.hidden =
//        _bottomRightView.hidden = NO;
//        
//        _gridButton.enabled =
//        _toggleButton.enabled =
//        _shotButton.enabled =
//        _flashButton.enabled = YES;
//    }];
    
    if (_wasLoaded == NO) {
        _wasLoaded = YES;
        [_camera insertSublayerWithCaptureView:_captureView atRootView:self.view];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_camera stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        _beginPinchGestureScale = _effectiveScale;
    }
    
    return YES;
}

#pragma mark -
#pragma mark - Actions

- (IBAction)closeTapped
{
    if ([_delegate respondsToSelector:@selector(cameraDidCancel)]) {
        [_delegate cameraDidCancel];
    }
}

- (IBAction)gridTapped
{
    [_camera disPlayGridView];
}

- (IBAction)flashTapped
{
    [_camera changeFlashModeWithButton:_flashButton];
}

- (IBAction)shotTapped
{
    _shotButton.enabled = NO;
    
//    [TGCameraSlideView showSlideUpView:_slideUpView slideDownView:_slideDownView atView:_captureView completion:^{
        UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
        AVCaptureVideoOrientation videoOrientation = [self videoOrientationForDeviceOrientation:deviceOrientation];
    
        [_camera takePhotoWithCaptureView:_captureView effectiveScale:_effectiveScale videoOrientation:videoOrientation completion:^(UIImage *photo) {
//            PhotoViewController *viewController = [PhotoViewController newWithDelegate:_delegate photo:photo];
//            [self.navigationController pushViewController:viewController animated:YES];
            
            PhotoViewController *viewcontroller = [PhotoViewController newWithDelegate:_delegate photo:photo];
            [self.navigationController pushViewController:viewcontroller animated:YES];
            
            _shotButton.enabled = YES;
        }];
//    }];
}

- (IBAction)toggleTapped
{
    [_camera toogleWithFlashButton:_flashButton];
}

- (IBAction)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    [self zoomWithRecognizer:recognizer];
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:_captureView];
    [_camera focusView:_captureView inTouchPoint:touchPoint];
}

#pragma mark -
#pragma mark - Private methods

- (void)deviceOrientationDidChangeNotification
{
    UIDeviceOrientation orientation = [UIDevice.currentDevice orientation];
    NSInteger degress;
    
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationUnknown:
            degress = 0;
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            degress = 90;
            break;
            
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationPortraitUpsideDown:
            degress = 180;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            degress = 270;
            break;
    }
    
    CGFloat radians = degress * M_PI / 180;
    CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
    
    [UIView animateWithDuration:.5f animations:^{
        _flashButton.transform =
        _toggleButton.transform = transform;
    }];
}

- (AVCaptureVideoOrientation)videoOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation) deviceOrientation;
    
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
            
        default:
            break;
    }
    
    return result;
}

- (void)zoomWithRecognizer:(UIPinchGestureRecognizer *)recognizer
{
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSInteger numberOfTouches = [recognizer numberOfTouches];
    
    AVCaptureVideoPreviewLayer *previewLayer = [_camera previewLayer];
    
    for (NSInteger i = 0; i < numberOfTouches; i++) {
        CGPoint location = [recognizer locationOfTouch:i inView:_captureView];
        CGPoint convertedLocation = [previewLayer convertPoint:location fromLayer:previewLayer.superlayer];
        
        if ([previewLayer containsPoint:convertedLocation] == NO) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if (allTouchesAreOnThePreviewLayer) {
        _effectiveScale = _beginPinchGestureScale * [recognizer scale];
        
        if (_effectiveScale < 1.) {
            _effectiveScale = 1.;
        }
        
        AVCaptureStillImageOutput *stillImageOutput = [_camera stillImageOutput];
        CGFloat maxScaleAndCropFactor = [[stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        if (_effectiveScale > maxScaleAndCropFactor) {
            _effectiveScale = maxScaleAndCropFactor;
        }
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [previewLayer setAffineTransform:CGAffineTransformMakeScale(_effectiveScale, _effectiveScale)];
        [CATransaction commit];
    }
}


@end
