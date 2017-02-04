//
//  AlbumClass.h
//  Memojar
//
//  Created by Amol Bapat on 20/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlbumClass : NSObject

+ (BOOL)isAvailable;

+ (UIImage *)imageWithMediaInfo:(NSDictionary *)info;
+ (UIImagePickerController *)imagePickerControllerWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate;

@end
