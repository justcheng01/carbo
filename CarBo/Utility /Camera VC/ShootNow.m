//
//  ShootNow.m
//  Memojar
//
//  Created by Amol Bapat on 09/10/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "ShootNow.h"

static void * CapturingStillImageContext = &CapturingStillImageContext;
static void * RecordingContext = &RecordingContext;
static void * SessionRunningAndDeviceAuthorizedContext = &SessionRunningAndDeviceAuthorizedContext;

@interface ShootNow () <AVCaptureFileOutputRecordingDelegate>

// Session management.
@property (nonatomic) dispatch_queue_t sessionQueue; // Communicate with the session and other session objects on this queue.
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic) AVCaptureMovieFileOutput *movieFileOutput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;

// Utilities.
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, getter = isDeviceAuthorized) BOOL deviceAuthorized;
@property (nonatomic, readonly, getter = isSessionRunningAndDeviceAuthorized) BOOL sessionRunningAndDeviceAuthorized;
@property (nonatomic) BOOL lockInterfaceRotation;
@property (nonatomic) id runtimeErrorHandlingObserver;

@end

@implementation ShootNow

//- (BOOL)isSessionRunningAndDeviceAuthorized
//{
//    return [[self session] isRunning] && [self isDeviceAuthorized];
//}
//
//+ (NSSet *)keyPathsForValuesAffectingSessionRunningAndDeviceAuthorized
//{
//    return [NSSet setWithObjects:@"session.running", @"deviceAuthorized", nil];
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"In ShootNow");
//    // Create the AVCaptureSession
//    AVCaptureSession *session = [[AVCaptureSession alloc] init];
//    [self setSession:session];
//    
//    // Setup the preview view
//    [[self previewView] setSession:session];
//    
//    // Check for device authorization
//    [self checkDeviceAuthorizationStatus];
//    
//    // In general it is not safe to mutate an AVCaptureSession or any of its inputs, outputs, or connections from multiple threads at the same time.
//    // Why not do all of this on the main queue?
//    // -[AVCaptureSession startRunning] is a blocking call which can take a long time. We dispatch session setup to the sessionQueue so that the main queue isn't blocked (which keeps the UI responsive).
//    
//    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
//    [self setSessionQueue:sessionQueue];
//    
//    dispatch_async(sessionQueue, ^{
//        [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
//        
//        NSError *error = nil;
//        
//        AVCaptureDevice *videoDevice = [ShootNow deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
//        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
//        
//        if (error)
//        {
//            NSLog(@"%@", error);
//        }
//        
//        if ([session canAddInput:videoDeviceInput])
//        {
//            [session addInput:videoDeviceInput];
//            [self setVideoDeviceInput:videoDeviceInput];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // Why are we dispatching this to the main queue?
//                // Because AVCaptureVideoPreviewLayer is the backing layer for AVCamPreviewView and UIView can only be manipulated on main thread.
//                // Note: As an exception to the above rule, it is not necessary to serialize video orientation changes on the AVCaptureVideoPreviewLayer’s connection with other session manipulation.
//                
//                [[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)[self interfaceOrientation]];
//            });
//        }
//        
//        AVCaptureDevice *audioDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
//        AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
//        
//        if (error)
//        {
//            NSLog(@"%@", error);
//        }
//        
//        if ([session canAddInput:audioDeviceInput])
//        {
//            [session addInput:audioDeviceInput];
//        }
//        
//        AVCaptureMovieFileOutput *movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
//        if ([session canAddOutput:movieFileOutput])
//        {
//            [session addOutput:movieFileOutput];
//            AVCaptureConnection *connection = [movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
//            if ([connection isVideoStabilizationSupported])
//                [connection setEnablesVideoStabilizationWhenAvailable:YES];
//            [self setMovieFileOutput:movieFileOutput];
//        }
//        
//        AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
//        if ([session canAddOutput:stillImageOutput])
//        {
//            [stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
//            [session addOutput:stillImageOutput];
//            [self setStillImageOutput:stillImageOutput];
//        }
//    });
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    dispatch_async([self sessionQueue], ^{
//        [self addObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:SessionRunningAndDeviceAuthorizedContext];
//        [self addObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:CapturingStillImageContext];
//        [self addObserver:self forKeyPath:@"movieFileOutput.recording" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:RecordingContext];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectAreaDidChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self videoDeviceInput] device]];
//        
//        __weak ShootNow *weakSelf = self;
//        [self setRuntimeErrorHandlingObserver:[[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureSessionRuntimeErrorNotification object:[self session] queue:nil usingBlock:^(NSNotification *note) {
//            ShootNow *strongSelf = weakSelf;
//            dispatch_async([strongSelf sessionQueue], ^{
//                // Manually restarting the session since it must have been stopped due to an error.
//                [[strongSelf session] startRunning];
//                [[strongSelf recordButton] setTitle:NSLocalizedString(@"Record", @"Recording button record title") forState:UIControlStateNormal];
//            });
//        }]];
//        [[self session] startRunning];
//    });
//}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    dispatch_async([self sessionQueue], ^{
//        [[self session] stopRunning];
//        
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:[[self videoDeviceInput] device]];
//        [[NSNotificationCenter defaultCenter] removeObserver:[self runtimeErrorHandlingObserver]];
//        
//        [self removeObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" context:SessionRunningAndDeviceAuthorizedContext];
//        [self removeObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" context:CapturingStillImageContext];
//        [self removeObserver:self forKeyPath:@"movieFileOutput.recording" context:RecordingContext];
//    });
//}

//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
//
//- (BOOL)shouldAutorotate
//{
//    // Disable autorotation of the interface when recording is in progress.
//    return ![self lockInterfaceRotation];
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
////    [[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] setVideoOrientation:(AVCaptureVideoOrientation)toInterfaceOrientation];
//}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if (context == CapturingStillImageContext)
//    {
//        BOOL isCapturingStillImage = [change[NSKeyValueChangeNewKey] boolValue];
//        
//        if (isCapturingStillImage)
//        {
//            [self runStillImageCaptureAnimation];
//        }
//    }
//    else if (context == RecordingContext)
//    {
//        BOOL isRecording = [change[NSKeyValueChangeNewKey] boolValue];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (isRecording)
//            {
//                [[self cameraButton] setEnabled:NO];
//                [[self recordButton] setTitle:NSLocalizedString(@"Stop", @"Recording button stop title") forState:UIControlStateNormal];
//                [[self recordButton] setEnabled:YES];
//            }
//            else
//            {
//                [[self cameraButton] setEnabled:YES];
//                [[self recordButton] setTitle:NSLocalizedString(@"Record", @"Recording button record title") forState:UIControlStateNormal];
//                [[self recordButton] setEnabled:YES];
//            }
//        });
//    }
//    else if (context == SessionRunningAndDeviceAuthorizedContext)
//    {
//        BOOL isRunning = [change[NSKeyValueChangeNewKey] boolValue];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (isRunning)
//            {
//                [[self cameraButton] setEnabled:YES];
//                [[self recordButton] setEnabled:YES];
//                [[self stillButton] setEnabled:YES];
//            }
//            else
//            {
//                [[self cameraButton] setEnabled:NO];
//                [[self recordButton] setEnabled:NO];
//                [[self stillButton] setEnabled:NO];
//            }
//        });
//    }
//    else
//    {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

//#pragma mark Actions
//
//- (IBAction)toggleMovieRecording:(id)sender
//{
//    [[self recordButton] setEnabled:NO];
//    
//    dispatch_async([self sessionQueue], ^{
//        if (![[self movieFileOutput] isRecording])
//        {
//            [self setLockInterfaceRotation:YES];
//            
//            if ([[UIDevice currentDevice] isMultitaskingSupported])
//            {
//                // Setup background task. This is needed because the captureOutput:didFinishRecordingToOutputFileAtURL: callback is not received until AVCam returns to the foreground unless you request background execution time. This also ensures that there will be time to write the file to the assets library when AVCam is backgrounded. To conclude this background execution, -endBackgroundTask is called in -recorder:recordingDidFinishToOutputFileURL:error: after the recorded file has been saved.
//                [self setBackgroundRecordingID:[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil]];
//            }
//            
//            // Update the orientation on the movie file output video connection before starting recording.
//            [[[self movieFileOutput] connectionWithMediaType:AVMediaTypeVideo] setVideoOrientation:[[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] videoOrientation]];
//            
//            // Turning OFF flash for video recording
//            [ShootNow setFlashMode:AVCaptureFlashModeOff forDevice:[[self videoDeviceInput] device]];
//            
//            // Start recording to a temporary file.
//            NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[@"movie" stringByAppendingPathExtension:@"mov"]];
//            [[self movieFileOutput] startRecordingToOutputFileURL:[NSURL fileURLWithPath:outputFilePath] recordingDelegate:self];
//        }
//        else
//        {
//            [[self movieFileOutput] stopRecording];
//        }
//    });
//}
//
//- (IBAction)changeCamera:(id)sender
//{
//    [[self cameraButton] setEnabled:NO];
//    [[self recordButton] setEnabled:NO];
//    [[self stillButton] setEnabled:NO];
//    
//    dispatch_async([self sessionQueue], ^{
//        AVCaptureDevice *currentVideoDevice = [[self videoDeviceInput] device];
//        AVCaptureDevicePosition preferredPosition = AVCaptureDevicePositionUnspecified;
//        AVCaptureDevicePosition currentPosition = [currentVideoDevice position];
//        
//        switch (currentPosition)
//        {
//            case AVCaptureDevicePositionUnspecified:
//                preferredPosition = AVCaptureDevicePositionBack;
//                break;
//            case AVCaptureDevicePositionBack:
//                preferredPosition = AVCaptureDevicePositionFront;
//                break;
//            case AVCaptureDevicePositionFront:
//                preferredPosition = AVCaptureDevicePositionBack;
//                break;
//        }
//        
//        AVCaptureDevice *videoDevice = [ShootNow deviceWithMediaType:AVMediaTypeVideo preferringPosition:preferredPosition];
//        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
//        
//        [[self session] beginConfiguration];
//        
//        [[self session] removeInput:[self videoDeviceInput]];
//        if ([[self session] canAddInput:videoDeviceInput])
//        {
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:currentVideoDevice];
//            
//            [ShootNow setFlashMode:AVCaptureFlashModeAuto forDevice:videoDevice];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectAreaDidChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:videoDevice];
//            
//            [[self session] addInput:videoDeviceInput];
//            [self setVideoDeviceInput:videoDeviceInput];
//        }
//        else
//        {
//            [[self session] addInput:[self videoDeviceInput]];
//        }
//        
//        [[self session] commitConfiguration];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[self cameraButton] setEnabled:YES];
//            [[self recordButton] setEnabled:YES];
//            [[self stillButton] setEnabled:YES];
//        });
//    });
//}

//- (IBAction)snapStillImage:(id)sender
//{
//    dispatch_async([self sessionQueue], ^{
//        // Update the orientation on the still image output video connection before capturing.
//        [[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] setVideoOrientation:[[(AVCaptureVideoPreviewLayer *)[[self previewView] layer] connection] videoOrientation]];
//        
//        // Flash set to Auto for Still Capture
//        [ShootNow setFlashMode:AVCaptureFlashModeAuto forDevice:[[self videoDeviceInput] device]];
//        
//        // Capture a still image.
//        [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:[[self stillImageOutput] connectionWithMediaType:AVMediaTypeVideo] completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
//            
//            if (imageDataSampleBuffer)
//            {
//                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
//                UIImage *image = [[UIImage alloc] initWithData:imageData];
//                [[[ALAssetsLibrary alloc] init] writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:nil];
//            }
//        }];
//    });
//}

//- (IBAction)focusAndExposeTap:(UIGestureRecognizer *)gestureRecognizer
//{
////    CGPoint devicePoint = [(AVCaptureVideoPreviewLayer *)[[self previewView] layer] captureDevicePointOfInterestForPoint:[gestureRecognizer locationInView:[gestureRecognizer view]]];
////    [self focusWithMode:AVCaptureFocusModeAutoFocus exposeWithMode:AVCaptureExposureModeAutoExpose atDevicePoint:devicePoint monitorSubjectAreaChange:YES];
//}
//
//- (void)subjectAreaDidChange:(NSNotification *)notification
//{
//    CGPoint devicePoint = CGPointMake(.5, .5);
//    [self focusWithMode:AVCaptureFocusModeContinuousAutoFocus exposeWithMode:AVCaptureExposureModeContinuousAutoExposure atDevicePoint:devicePoint monitorSubjectAreaChange:NO];
//}
//
//#pragma mark File Output Delegate
//
//- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
//{
//    if (error)
//        NSLog(@"%@", error);
//    
//    [self setLockInterfaceRotation:NO];
//    
//    // Note the backgroundRecordingID for use in the ALAssetsLibrary completion handler to end the background task associated with this recording. This allows a new recording to be started, associated with a new UIBackgroundTaskIdentifier, once the movie file output's -isRecording is back to NO — which happens sometime after this method returns.
//    UIBackgroundTaskIdentifier backgroundRecordingID = [self backgroundRecordingID];
//    [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
//    
//    [[[ALAssetsLibrary alloc] init] writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (error)
//            NSLog(@"%@", error);
//        
//        [[NSFileManager defaultManager] removeItemAtURL:outputFileURL error:nil];
//        
//        if (backgroundRecordingID != UIBackgroundTaskInvalid)
//            [[UIApplication sharedApplication] endBackgroundTask:backgroundRecordingID];
//    }];
//}
//
//#pragma mark Device Configuration
//
//- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange
//{
//    dispatch_async([self sessionQueue], ^{
//        AVCaptureDevice *device = [[self videoDeviceInput] device];
//        NSError *error = nil;
//        if ([device lockForConfiguration:&error])
//        {
//            if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:focusMode])
//            {
//                [device setFocusMode:focusMode];
//                [device setFocusPointOfInterest:point];
//            }
//            if ([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:exposureMode])
//            {
//                [device setExposureMode:exposureMode];
//                [device setExposurePointOfInterest:point];
//            }
//            [device setSubjectAreaChangeMonitoringEnabled:monitorSubjectAreaChange];
//            [device unlockForConfiguration];
//        }
//        else
//        {
//            NSLog(@"%@", error);
//        }
//    });
//}
//
//+ (void)setFlashMode:(AVCaptureFlashMode)flashMode forDevice:(AVCaptureDevice *)device
//{
//    if ([device hasFlash] && [device isFlashModeSupported:flashMode])
//    {
//        NSError *error = nil;
//        if ([device lockForConfiguration:&error])
//        {
//            [device setFlashMode:flashMode];
//            [device unlockForConfiguration];
//        }
//        else
//        {
//            NSLog(@"%@", error);
//        }
//    }
//}
//
//+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
//{
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
//    AVCaptureDevice *captureDevice = [devices firstObject];
//    
//    for (AVCaptureDevice *device in devices)
//    {
//        if ([device position] == position)
//        {
//            captureDevice = device;
//            break;
//        }
//    }
//    
//    return captureDevice;
//}
//
//#pragma mark UI
//
//- (void)runStillImageCaptureAnimation
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[[self previewView] layer] setOpacity:0.0];
//        [UIView animateWithDuration:.25 animations:^{
//            [[[self previewView] layer] setOpacity:1.0];
//        }];
//    });
//}

//- (void)checkDeviceAuthorizationStatus
//{
//    NSString *mediaType = AVMediaTypeVideo;
//    
//    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
//        if (granted)
//        {
//            //Granted access to mediaType
//            [self setDeviceAuthorized:YES];
//        }
//        else
//        {
//            //Not granted access to mediaType
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[[UIAlertView alloc] initWithTitle:@"AVCam!"
//                                            message:@"AVCam doesn't have permission to use Camera, please change privacy settings"
//                                           delegate:self
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil] show];
//                [self setDeviceAuthorized:NO];
//            });
//        }
//    }];
//}



//#pragma mark UIActions
//-(IBAction)textButton:(id)sender
//{
//    
//    
//}
//-(IBAction)brightnessButton:(id)sender
//{
//    // CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    
//    PopupView *popView = [[PopupView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 90, [UIScreen mainScreen].bounds.size.width,40)];   //create an instance of your custom view
//    [self.view addSubview:popView]; // add to your main view
//}
//-(IBAction)cropButton:(id)sender
//{
//    
//}
//-(IBAction)frameButton:(id)sender
//{
//    
//}
//-(IBAction)colourButton:(id)sender
//{
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark Previous Work

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//
////    imagePickerController.delegate = self;
////    imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//
//    UIView *controllerView = imagePickerController.view;
//
//    controllerView.alpha = 0.0;
//    controllerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:controllerView];
//
//    [UIView animateWithDuration:0.3
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         controllerView.alpha = 1.0;
//                     }
//                     completion:nil
//     ];
//
//
//
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//
//    if (self.flag == 0) {
//         [self actionLaunchAppCamera];
//    }
//    else
//    {
//        [self selectPhoto];
//    }
//    // Create the AVCaptureSession
//
//
//}
//


//-(void)actionLaunchAppCamera
//{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        imagePicker.allowsEditing = YES;
//        
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//    else{
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"
//                                                       message:@"Unable to find a camera on your device."
//                                                      delegate:nil
//                                             cancelButtonTitle:@"OK"
//                                             otherButtonTitles:nil, nil];
//        [alert show];
//        alert = nil;
//    }
//    
//}
//
//
//- (void)selectPhoto {
//    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
//    
//    
//}
//#pragma mark UIImagePickerControllerDelegate
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    
//    // Save image
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    self.imageView.image = chosenImage;
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [self dismissViewControllerAnimated:YES completion:nil];

    //This creates a filepath with the current date/time as the name to save the image
    //    NSString *presentTimeStamp = [self getPresentDateTime];
    //    NSLog(@"present timestamp: %@", presentTimeStamp);
    //    NSString *fileSavePath = [self documentsPath:presentTimeStamp];
    //    NSLog(@"filesavepath: %@", fileSavePath);
    //    fileSavePath = [fileSavePath stringByAppendingString:@".png"];
    //
    //    //This checks to see if the image was edited, if it was it saves the edited version as a .png
    //    if ([info objectForKey:UIImagePickerControllerEditedImage])
    //    {
    //        //save the edited image
    //        NSData *imgPngData = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerEditedImage]);
    //        [imgPngData writeToFile:fileSavePath atomically:YES];
    //
    //
    //    }else
    //    {
    //        //save the original image
    //        NSData *imgPngData = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage]);
    //        [imgPngData writeToFile:fileSavePath atomically:YES];
    //        NSLog(@"File saved successfully");
    //
    //    }
//}

//-(void) selectImage
//{
//
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
//    
//}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    UIAlertView *alert;
//    
//    // Unable to save the image
//    if (error)
//        alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                           message:@"Unable to save image to Photo Album."
//                                          delegate:self cancelButtonTitle:@"Ok"
//                                 otherButtonTitles:nil];
//    else // All is well
//        alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                           message:@"Image saved to Photo Album."
//                                          delegate:self cancelButtonTitle:@"Ok"
//                                 otherButtonTitles:nil];
////    [alert show];
//   
//
//}


//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
//}


//-(NSString *)documentsPath:(NSString *)fileName {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    return [documentsDirectory stringByAppendingPathComponent:fileName];
//    
//}

//-(NSString *)getPresentDateTime{
//    
//    NSDateFormatter *dateTimeFormat = [[NSDateFormatter alloc] init];
//    [dateTimeFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
//    
//    NSDate *now = [[NSDate alloc] init];
//    
//    NSString *theDateTime = [dateTimeFormat stringFromDate:now];
//    
//    dateTimeFormat = nil;
//    now = nil;
//    
//    return theDateTime;
//    
//}


#pragma mark - Overriding Delegates

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
