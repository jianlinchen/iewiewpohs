//
//  BaseViewController.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "API.h"
#import "Constant.h"
#import "SVProgressHUD.h"
#import "GlobarManager.h"
#import "DataBaseManager.h"
#import "MJRefresh.h"
#import "Utils.h"
#import "define.h"
#import "HttpRequest.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BaseViewController : UIViewController


@property (nonatomic, strong) MJRefreshGifHeader *header;
//@property (nonatomic, strong) MJRefreshBackStateFooter *footer;
- (BOOL)internetEnable;
- (void)showNoDataViewWithString2:(NSString *)str andImage:(UIImage *)image;
- (void)showNoDataViewWithString:(NSString *)str andImage:(UIImage *)image;
- (void)removeNoDataView;
- (void)loadNewData;
-(void)removeNoDataView2;


@end
