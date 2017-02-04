//
//  CameraViewController.h
//  Memojar
//
//  Created by Amol Bapat on 19/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Camera.h"
@interface CameraViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak) id<CameraDelegate> delegate;
@end
