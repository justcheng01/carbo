//
//  CameraNavigationController.m
//  Memojar
//
//  Created by Amol Bapat on 19/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraNavigationController.h"
#import "CameraAuthorizationController.h"
#import "CameraViewController.h"

@interface CameraNavigationController ()

- (void)setupAuthorizedWithDelegate:(id<CameraDelegate>)delegate;
- (void)setupDenied;
- (void)setupNotDeterminedWithDelegate:(id<CameraDelegate>)delegate;

@end

@implementation CameraNavigationController

+ (instancetype)newWithCameraDelegate:(id<CameraDelegate>)delegate
{
    CameraNavigationController *navigationController = [super new];
    navigationController.navigationBarHidden = YES;
    
    if (navigationController) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (status) {
            case AVAuthorizationStatusAuthorized:
                [navigationController setupAuthorizedWithDelegate:delegate];
                break;
                
            case AVAuthorizationStatusRestricted:
            case AVAuthorizationStatusDenied:
                [navigationController setupDenied];
                break;
                
            case AVAuthorizationStatusNotDetermined:
                [navigationController setupNotDeterminedWithDelegate:delegate];
                break;
        }
    }
    
    return navigationController;
}

#pragma mark -
#pragma mark - Private methods

- (void)setupAuthorizedWithDelegate:(id<CameraDelegate>)delegate
{
    CameraViewController *viewController = [CameraViewController new];
    viewController.delegate = delegate;
    
    self.viewControllers = @[viewController];
}

- (void)setupDenied
{
    UIViewController *viewController = [CameraAuthorizationController new];
    self.viewControllers = @[viewController];
}

- (void)setupNotDeterminedWithDelegate:(id<CameraDelegate>)delegate
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            [self setupAuthorizedWithDelegate:delegate];
        } else {
            [self setupDenied];
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
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
