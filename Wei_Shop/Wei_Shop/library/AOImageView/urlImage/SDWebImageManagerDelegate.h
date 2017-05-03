/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

@class SDWebImageManager1;

@protocol SDWebImageManagerDelegate <NSObject>

@optional

- (void)webImageManager:(SDWebImageManager1 *)imageManager didFinishWithImage:(UIImage *)image;
- (void)webImageManager:(SDWebImageManager1 *)imageManager didFailWithError:(NSError *)error;

@end
