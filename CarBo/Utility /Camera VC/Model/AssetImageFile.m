//
//  AssetobjectFile.m
//  Memojar
//
//  Created by Amol Bapat on 01/12/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "AssetImageFile.h"

@implementation AssetImageFile

- (instancetype)initWithPath:(NSString *)path image:(UIImage *)image
{
    self = [self init];
    
    if (self) {
        self.path = path;
        self.image = image;
    }
    
    return self;
}

@end
