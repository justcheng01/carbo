//
//  AssetobjectFile.h
//  Memojar
//
//  Created by Amol Bapat on 01/12/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//


@import Foundation;
@import UIKit;

@interface AssetImageFile : NSObject
{
    NSString *string;
}

@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *title;

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image;


@end
