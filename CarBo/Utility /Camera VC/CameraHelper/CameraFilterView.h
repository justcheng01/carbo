//
//  CameraFilterView.h
//  Memojar
//
//  Created by Amol Bapat on 01/12/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraFilterView : UIView

- (void)addToView:(UIView *)view aboveView:(UIView *)aboveView;
- (void)removeFromSuperviewAnimated;

@end
