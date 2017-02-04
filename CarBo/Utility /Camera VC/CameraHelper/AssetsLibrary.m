//
//  AssetLibrary.m
//  Memojar
//
//  Created by Amol Bapat on 02/12/14.
//  Copyright (c) 2014 Olive. All rights reserved.
//

#import "AssetsLibrary.h"
@interface AssetsLibrary ()

- (void)addAssetURL:(NSURL *)assetURL toAlbum:(NSString *)albumName withCompletion:(TGAssetsSaveImageCompletion)completion;
- (NSString *)directory;

@end

@implementation AssetsLibrary

#pragma mark - Public methods

+ (AssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static AssetsLibrary *library = nil;
    
    dispatch_once(&pred, ^{
        library = [[self alloc] init];
    });
    
    return library;
}

- (void)deleteFile:(AssetImageFile *)file
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager isDeletableFileAtPath:file.path]) {
        [fileManager removeItemAtPath:file.path error:nil];
    }
}

- (NSArray *)loadImagesFromDocumentDirectory
{
    NSString *directory = [self directory];
    
    if (directory == nil) {
        return nil;
    }
    
    NSError *error;
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:&error];
    
    if (error) {
        return nil;
    }
    
    NSMutableArray *items = [NSMutableArray new];
    
    for (NSString *name in contents) {
        NSString *path = [directory stringByAppendingPathComponent:name];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data == nil) {
            continue;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        AssetImageFile *file = [[AssetImageFile alloc] initWithPath:path image:image];
        [items addObject:file];
    }
    
    return items;
}

- (void)loadImagesFromAlbum:(NSString *)albumName withCallback:(TGAssetsLoadImagesCompletion)callback
{
    __block NSMutableArray *items = [NSMutableArray new];
    
    [self enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([albumName compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    AssetImageFile *file = [AssetImageFile new];
                    ALAssetRepresentation *representation = [result defaultRepresentation];
                    file.image = [UIImage imageWithCGImage:[representation fullScreenImage] scale:[representation scale] orientation:0];
                    file.path = [[result.defaultRepresentation url] absoluteString];
                    [items addObject:file];
                }
                
                callback(items, nil);
            }];
        }
    } failureBlock:^(NSError *error) {
        callback(items, nil);
    }];
    
}

- (void)saveImage:(UIImage *)image completion:(TGAssetsSaveImageCompletion)completion
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    [self saveImage:image withAlbumName:appName completion:completion];
}

- (void)saveImage:(UIImage *)image withAlbumName:(NSString *)albumName completion:(TGAssetsSaveImageCompletion)completion
{
    [self writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)image.imageOrientation
                       completionBlock:^(NSURL *assetURL, NSError *error) {
                           if (error && completion) {
                               completion(error);
                               return;
                           }
                           
                           [self addAssetURL:assetURL toAlbum:albumName withCompletion:completion];
                       }];
}

- (void)saveJPGImageAtDocumentDirectory:(UIImage *)image
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh_mm_SSSSZ"];
    
    NSString *directory = [self directory];
    
    if (!directory) {
        return;
    }
    
    NSString *fileName = [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingPathExtension:@"jpg"];
    NSString *filePath = [directory stringByAppendingString:fileName];
    
    if (filePath == nil) {
        return;
    }
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    [data writeToFile:filePath atomically:YES];
}

#pragma mark -
#pragma mark - Private methods

- (void)addAssetURL:(NSURL *)assetURL toAlbum:(NSString *)albumName withCompletion:(TGAssetsSaveImageCompletion)completion
{
    __block BOOL albumWasFound = NO;
    
    [self enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if ([albumName compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame) {
            albumWasFound = YES;
            
            [self assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                [group addAsset:asset];
                
                if (completion) {
                    completion(nil);
                }
            } failureBlock:completion];
            
            return;
        }
        
        if (group == nil && albumWasFound == NO) {
            __weak ALAssetsLibrary *weakSelf = self;
            
            [self addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group) {
                [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    [group addAsset:asset];
                    
                    if (completion) {
                        completion(nil);
                    }
                } failureBlock:completion];
            } failureBlock:completion];
        }
    } failureBlock:completion];
}

- (NSString *)directory
{
    NSMutableString *path = [NSMutableString new];
    [path appendString:[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject]];
    [path appendString:@"/Images/"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        
        if (error) {
            return nil;
        }
    }
    
    return path;
}

@end
