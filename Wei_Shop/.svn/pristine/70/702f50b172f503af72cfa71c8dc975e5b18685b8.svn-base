//
//  Utils.h
//  UPayProject
//
//  Created by ding wei on 13-8-14.
//  Copyright (c) 2013年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SecKeyWrapper.h"
#import <Security/Security.h>
#import "Base64Data.h"

//#import <UIKit/UIKit.h>
#define kAudioType_AMR @"amr"
#define kAudioType_WAV @"wav"


@interface Utils : NSObject
//+(UIBarButtonItem*)createRightbarbutton:(NSString*)title  target:(id)target sel:(SEL)sel;

+ (NSString *)RSAencryptWithString:(NSString *)content;

+(NSString*)getSignString:(NSDictionary*)parms;

+(NSString *) md5: (NSString *) inPutText;

+(NSString*)getCurrentTimeMillSeconds;


//+(UIImage *)getImage:(UIImage *)source fitView:(UIView*)view;

+(NSString*)keyForURL:(NSString*) url;

//+(void)getWebImage:(NSString*)urlstr
//             begin:(void(^)(void))begin
//           success:(void(^)(UIImage* img))success
//              fail:(void(^)(NSString* msg))fail;

+(NSDate *)getDateFromServerByMSecond:(long long)time;
+(NSDate*)getDateFromString:(NSString*)ds;
+(NSDate*)getDateFromNumber:(NSNumber*)ds;

//+(UIImage *)rnImage:(UIImage*)sourceImg boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
//+(void)setImageView:(UIImageView*)view from:(NSString*)urlstr;
//+(void)addBack2Navigationitem:(UINavigationItem*)item sel:(SEL)sel  res:(id)res andimage:(NSString*)imageStr;
+(BOOL)is4Screen;

+(NSString*)generateFilenameByType:(NSString*)type;

+(NSInteger)durationOfAduio:(NSString *)path;

+(id)ifNullToNil:(id)objc;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isValidEmail:(NSString*)email;

+(void)alertView:(NSString *)title;

+(UIView *)getScoreView:(float)score hight:(CGRect)frame havelable:(BOOL)have;

//验证手机号
+(BOOL)validateMobile:(NSString *)mobileNum;

//+(void)addBack2Navigationitem:(UINavigationItem*)item sel:(SEL)sel  res:(id)res;

@end
