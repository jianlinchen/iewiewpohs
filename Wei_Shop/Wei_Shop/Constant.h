//
//  Constant.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


#endif /* Constant_h */

//#define OurWebUrl       @"https://wmw.wmwbeautysalon.com/agreement.html"
#define OurWebUrl       @"http://wap.wmwbeautysalon.com/agreement.html"

#define OurTelNumber    @"4008096866"

//UserDefaults
#define Account     @"account"
#define Password    @"password"
#define PublicKey   @"publicKey"
#define ResigteDevice @"ResigteDevice"

#define FrontStr    @"1329393747619"
#define BackStr    @"4c9154e23eff9ca8d2bf658cbcb37547"


#define AuthTimespan    [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000]

/**
 *  使用16位表达
 */
#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕宽高
#define APP_W   [UIScreen mainScreen].applicationFrame.size.width
#define APP_H   [UIScreen mainScreen].applicationFrame.size.height

//iOS系统版本
#define iOS_V   [[[UIDevice currentDevice] systemVersion] floatValue]

#define iOSv8   (iOS_V >= 8.0)
#define iOSv7   (iOS_V >= 7.0 && iOS_V < 8.0)
#define iOSo7   iOS_V >= 7.0

#define UUID    [[UIDevice currentDevice].identifierForVendor UUIDString]

#define Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define IMReceive @"Received"
#define IMSend @"Sended"

#define StrFromObj(objValue)     [NSString stringWithFormat: @"%@", objValue]

/**
 *  单例宏方法
 *
 *  @param block
 *
 *  @return 返回单例
 */
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \