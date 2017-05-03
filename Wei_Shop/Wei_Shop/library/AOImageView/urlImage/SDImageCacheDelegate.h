//
//  SDImageCacheDelegate.h
//  Dailymotion
//
//  Created by Olivier Poitrey on 16/09/10.
//  Copyright 2010 Dailymotion. All rights reserved.
//

#import "SDWebImageCompat.h"

@class SDImageCache1;

@protocol SDImageCacheDelegate <NSObject>

@optional
- (void)imageCache:(SDImageCache1 *)imageCache didFindImage:(UIImage *)image forKey:(NSString *)key userInfo:(NSDictionary *)info;
- (void)imageCache:(SDImageCache1 *)imageCache didNotFindImageForKey:(NSString *)key userInfo:(NSDictionary *)info;

@end
