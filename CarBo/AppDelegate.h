//
//  AppDelegate.h
//  CarBo
//
//  Created by Shirish Vispute on 22/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Stripe/Stripe.h>
//#import <UserNotifications/UserNotifications.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
///UNUserNotificationCenterDelegate

@interface AppDelegate : UIResponder <UIApplicationDelegate,FBSDKLoginButtonDelegate>

@property (strong, nonatomic) UIWindow *window;
@end

///Users/shirishvispute/Library/Developer/Xcode/D
