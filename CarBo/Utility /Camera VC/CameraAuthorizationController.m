//
//  CameraAuthorizationViewController.m
//  Memojar
//
//  Created by Amol Bapat on 19/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "CameraAuthorizationController.h"

@interface CameraAuthorizationController ()

@end

@implementation CameraAuthorizationController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -
#pragma mark - Actions

- (IBAction)closeButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
