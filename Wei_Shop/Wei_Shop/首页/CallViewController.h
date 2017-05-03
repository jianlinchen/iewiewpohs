//
//  CallViewController.h
//  Weimei
//
//  Created by xujt@iwellfie.net on 15/5/20.
//  Copyright (c) 2015年 xujt@iwellfie.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CallViewController : BaseViewController

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong) NSString *userImg;

@property (nonatomic, strong) NSDictionary *userDic;

@end
