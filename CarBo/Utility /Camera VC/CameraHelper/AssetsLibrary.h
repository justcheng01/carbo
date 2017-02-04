//
//  AssetLibrary.h
//  Memojar
//
//  Created by Amol Bapat on 02/12/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
@import AssetsLibrary;
#import "AssetImageFile.h"

typedef void(^TGAssetsSaveImageCompletion)(NSError* error);
typedef void(^TGAssetsLoadImagesCompletion)(NSArray *items, NSError *error);


@interface AssetsLibrary : ALAssetsLibrary

+ (instancetype) new __attribute__
((unavailable("[+new] is not allowed, use [+defaultAssetsLibrary]")));

- (instancetype) init __attribute__
((unavailable("[-init] is not allowed, use [+defaultAssetsLibrary]")));

+ (AssetsLibrary *)defaultAssetsLibrary;

- (void)deleteFile:(AssetImageFile *)file;

- (NSArray *)loadImagesFromDocumentDirectory;
- (void)loadImagesFromAlbum:(NSString *)albumName withCallback:(TGAssetsLoadImagesCompletion)callback;

- (void)saveImage:(UIImage *)image completion:(TGAssetsSaveImageCompletion)completion;
- (void)saveImage:(UIImage *)image withAlbumName:(NSString *)albumName completion:(TGAssetsSaveImageCompletion)completion;
- (void)saveJPGImageAtDocumentDirectory:(UIImage *)image;

@end
