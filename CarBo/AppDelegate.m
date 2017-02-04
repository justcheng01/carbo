//
//  AppDelegate.m
//  CarBo
//
//  Created by Shirish Vispute on 22/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MainVC.h"
#import "LoginVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "PremiumDetails_SVC.h"
#import "PremiumDetails_FVC.h"
#import "ApplicantRequirement.h"
#import "car_registration.h"

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
 // Override point for customization after application launch.
  [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];

  NSString *authenticatedUser = [[NSUserDefaults standardUserDefaults]objectForKey:@"Log"];
 
    
  if(authenticatedUser)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainVC *rootController =(MainVC*)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navigation;

       // //NSLog(@"Logged");
    }
else
    {
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      LoginVC *rootController=(LoginVC*)[storyboard instantiateViewControllerWithIdentifier:@"Login"];
     UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
     self.window.rootViewController = navigation;
    }
    
 if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
       [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
       [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
  
    NSDictionary *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if(notification)
    {
        //NSLog(@"app recieved notification from remote%@",notification);
        [self application:application didReceiveRemoteNotification:notification];
    }
    else
    {
    }
    
  return YES;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
 if (buttonIndex == 1)
    {
        NSString *iTunesLink = @"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=<1180974630>&mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
}


-(void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSDKAppEvents activateApp];
}


-(BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application: application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark: For Registeration of Device
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:
(NSData *)deviceToken
{
  NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]]; token = [token stringByReplacingOccurrencesOfString:@" " withString:@""]; //NSLog(@"content---%@", token);
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //NSLog(@"My token is: %@", token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:
(NSError *)error
{
       //NSLog(@"Failed to register for remote notifications: %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo
{
    //NSLog(@"User Notification :: %@", userInfo);
    
    NSDictionary *dict = [[NSDictionary alloc]initWithDictionary:[userInfo objectForKey:@"aps"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Notification", nil) message:
                          [dict objectForKey:@"alert"] delegate:nil cancelButtonTitle:
                          NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
    [alert show];
}

- (void)clearNotifications
{ }

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
