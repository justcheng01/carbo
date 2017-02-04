//
//  AlbumClass.m
//  Memojar
//
//  Created by Amol Bapat on 20/11/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "AlbumClass.h"
@import MobileCoreServices;

@implementation AlbumClass



+ (UIImage *)imageWithMediaInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage]) {
        return info[UIImagePickerControllerOriginalImage];
    }
    return nil;
}

+ (BOOL)isAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}


+ (UIImagePickerController *)imagePickerControllerWithDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
{
    UIImagePickerController *pickerController = [UIImagePickerController new];

    pickerController = [UIImagePickerController new];
    pickerController.delegate = delegate;
    pickerController.mediaTypes = @[(NSString *) kUTTypeImage];
    pickerController.allowsEditing = NO;
    
    return pickerController;
}


@end
