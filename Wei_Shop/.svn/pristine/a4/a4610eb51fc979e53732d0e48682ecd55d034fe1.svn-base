//
//  GlobarManager.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/3.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "GlobarManager.h"
#import "MessageBox.h"
#import "API.h"
#import "HttpRequest.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>  //为判断网络制式的主要文件
#import <CoreTelephony/CTCarrier.h> //添加获取客户端运营商 支持
#import "RSA.h"
#import "RYRsaSign.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Reachability.h"
@implementation GlobarManager

static GlobarManager  *sharesingleton=nil;//必须声明为一个静态方法

+ (GlobarManager *)shareInstance {
    
    if (sharesingleton == nil){
        
        sharesingleton = [[self alloc]init];
    }
    
    return sharesingleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.userConfig = [UserConstant new];
        self.deviceResigted = NO;
        self.publicKey = @"";
        self.unreadMessageList = [[NSMutableArray alloc]init];
        self.unReadCount = 0;
        self.beforeUnread = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(RequestMessageList) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dealloc{
    
    [timer invalidate];
    [DATAMANAGER close];
}

+ (void)OpenFMDataBase{
    
    [DataBaseManager openDataBase];
    [DataBaseManager createTables];
}

- (void)requestPublicKeyCallback:(pKeyGettedBlock)callBack{
    
    self.pKeyblock = callBack;
    NSString *public = [[NSUserDefaults standardUserDefaults] objectForKey:PublicKey];
    if(public && ![public isEqualToString:@""]){
        if(self.pKeyblock){
            self.pKeyblock(public);
        }
        return;
    }
    
    if(self.publicKey != nil && ![self.publicKey isEqualToString:@""]){
        [[NSUserDefaults standardUserDefaults]setObject:self.publicKey forKey:PublicKey];
        
        if(self.pKeyblock){
            self.pKeyblock(self.publicKey);
        }
        return;
    }
    
    [HttpRequest getData:[NSDictionary dictionary] path:GetPublicKey method:@"GET" success:^(id object) {
        
        if (object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                self.publicKey = [object objectForKey:@"result"];
                [[NSUserDefaults standardUserDefaults]setObject:[object objectForKey:@"result"]forKey:PublicKey];
                if(self.pKeyblock){
                    self.pKeyblock([object objectForKey:@"result"]);
                }
            }
        }
    } fail:^(NSString *msg) {
        if(self.pKeyblock){
            self.pKeyblock(@"");
        }
    }];
    
}

//注册设备
-(void)ResigterDevice{

    NSString *currentStatus  = @"CTRadioAccessTechnologyCDMAEVDORevA";
    
    NSString *authTimespan = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    
    NSString *paraStr1 =[NSString stringWithFormat:@"1329393747619authTimespan=%@imsi=%@model=%@netType=%@4c9154e23eff9ca8d2bf658cbcb37547",authTimespan,UUID, [UIDevice currentDevice].model,currentStatus];
    //    NSLog(@"%@",paraStr1);
    NSString *paraStr = [paraStr1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         authTimespan,@"authTimespan",
                         UUID,@"imsi",
                         [UIDevice currentDevice].model,@"model",
                         currentStatus,@"netType",
                         @"1329393747619",@"authAppkey",
                         [Utils md5:paraStr],@"authSign",
                         nil];
    [HttpRequest getData:dic path:DeviceRegister method:@"GET" success:^(id object) {
        NSLog(@"%@",object);
        
        if (object) {
            if ([[object objectForKey:@"success"]intValue] == 1) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ResigteDevice];
               
                self.deviceResigted = YES;
            }
        }
    } fail:^(NSString *msg) {
        
    }];
    
}


- (BOOL)isPhoneNumber:(NSString*)text
{
    NSString * regex = @"^([1])([0-9]{10})$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:text]) {
        return YES;
    }
    return NO;
}

#pragma mark 文字高度
- (CGSize)sizeText:(NSString*)text
              font:(UIFont*)font
        limitWidth:(float)width
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin//|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    rect.size.width=width;
    rect.size.height=ceil(rect.size.height);
    return rect.size;
}

- (CGSize)sizeText:(NSString*)text
              font:(UIFont*)font
       limitHeight:(float)height
{
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin//|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    rect.size.height=height;
    rect.size.width=ceil(rect.size.width);
    return rect.size;
}

- (CGSize)sizeText:(NSString*)text font:(UIFont*)font{
    return [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}

- (CGSize)sizeText:(NSString*)text font:(UIFont*)font constrainedToSize:(CGSize)size{
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    //    return [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}
#pragma mark - 时间戳获取函数
- (NSString *)dateString{
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000;//*1000 是精确到毫秒，不乘就是精确到秒
    a *= 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a]; //转为字符型
    NSLog(@"%ld", time(NULL));
    
    return timeString;
}

#pragma mark - 将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
+ (NSString *)NSdateToString{
    
    NSDate *fromdate=[NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* string=[dateFormat stringFromDate:fromdate];
    return string;
}

#pragma mark - 请求需字典构造函数
- (NSMutableDictionary *)getRequestDictionary:(NSMutableDictionary *)dic{
    
    NSMutableArray *stringArray = [NSMutableArray new];
    
    //遍历Dic字段
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj,   BOOL *stop) {
        NSLog(@"key = %@ and obj = %@", key, obj);
        if(![key isEqualToString:@"authAppkey"]){
            [stringArray addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }
    }];
    [stringArray sortUsingSelector:@selector(compare:)];
    
    NSMutableString *araStr = [NSMutableString new];
    
    [araStr appendString:FrontStr];
    
    for(NSString *str in stringArray){
        [araStr appendString:str];
    }
    [araStr appendString:BackStr];
    
    [dic setObject:[Utils md5:araStr] forKey:@"authSign"];

    return dic;
}

#pragma mark - AppKey鉴权字段构造
- (NSMutableDictionary *)AppKeyDic:(NSDictionary *)dic{
    
    //封装authAppkey和时间戳authTimespan
    NSMutableDictionary *ADic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [ADic setObject:FrontStr forKey:@"authAppkey"];
    [ADic setObject:[self dateString] forKey:@"authTimespan"];
    
    return [self getRequestDictionary:ADic];
}

#pragma mark - AppKey+AccessToken鉴权字段构造
- (NSMutableDictionary *)AppKeyTokenDic:(NSDictionary *)dic{

    NSMutableDictionary *ADic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [ADic setObject:FrontStr forKey:@"authAppkey"];
    [ADic setObject:[self dateString] forKey:@"authTimespan"];
    [ADic setObject:self.userConfig.accessToken forKey:@"accessToken"];
    [ADic setObject:self.userConfig.merchantId forKey:@"merchantId"];
 
    return [self getRequestDictionary:ADic];
}

#pragma mark - 拉取未读消息
- (void)RequestMessageList{
    
    [MessageBox getUnReadListSuccess:^(id obj) {
        
    } failure:^(NSString *msg) {
        
    }];
}

#pragma mark - 登录接口
- (void)loginHTTPAccount:(NSString *)account password:(NSString *)password Success:(void (^)(id))success
                 failure:(void (^)(NSString *))failure{
    
    
        Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        if (![reach isReachable]) {
            if(failure){
                failure(@"网络连接异常");
            }
            return;
        }

    
    
    self.publicKey = [[NSUserDefaults standardUserDefaults] objectForKey:PublicKey];
    if(!self.publicKey || [self.publicKey isEqualToString:@""]){
        if(failure){
//            failure(@"没有publicKey");
        }
        return;
    }
    if(!account || [account isEqualToString:@""]){
        if(failure){
            failure(@"账号不能为空");
        }
        return;
    }
    if(!password || [password isEqualToString:@""]){
        if(failure){
            failure(@"密码不能为空");
        }
        return;
    }
    NSString *authTimespan = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    
    NSString *tt = [RYRsaSign RSAEncrypt:password key:self.publicKey];
    NSString *paraStr= [NSString stringWithFormat:@"1329393747619account=%@authTimespan=%@password=%@4c9154e23eff9ca8d2bf658cbcb37547",account,authTimespan,tt];
    
    [RSA md5:paraStr];
    
    NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:
                        tt,@"password",
                        account,@"account",
                        @"1329393747619",@"authAppkey",
                        authTimespan,@"authTimespan",
                        [Utils md5:paraStr],@"authSign",nil];
    
    [HttpRequest getData:dic path:MbrLogin method:@"GET" success:^(id object) {
        NSLog(@"%@",object);
        if (object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                [[NSUserDefaults standardUserDefaults]setObject:account forKey:Account];
                [[NSUserDefaults standardUserDefaults]setObject:password forKey:Password];
                
                
                NSDictionary *useDic = [object objectForKey:@"result"];
                
                [GlobarManager shareInstance].userConfig.merchantId     = [useDic objectForKey:@"merchantId"];
                [GlobarManager shareInstance].userConfig.accessToken    = [useDic objectForKey:@"accessToken"];
                [GlobarManager shareInstance].userConfig.account        = [useDic objectForKey:@"account"];
                [GlobarManager shareInstance].userConfig.mobile         = [useDic objectForKey:@"mobile"];
                [GlobarManager shareInstance].userConfig.nickName       = [useDic objectForKey:@"nickName"];
                [GlobarManager shareInstance].userConfig.icon           = [useDic objectForKey:@"icon"];
                [GlobarManager shareInstance].userConfig.shopId         = [useDic objectForKey:@"shopId"];
                [GlobarManager shareInstance].userConfig.shopName       = [useDic objectForKey:@"shopName"];
                [GlobarManager shareInstance].userConfig.shopImg        = [useDic objectForKey:@"shopImg"];
                [GlobarManager shareInstance].userConfig.cityId        = [useDic objectForKey:@"cityId"];
                
                [GLOBARMANAGER RequestMessageList];
                
                if(success){
                    success(GLOBARMANAGER.userConfig);
                }
            }else{
                UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:object[@"error"][@"extDesc"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alert1 show];
    
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginFail" object:nil];
                if (failure) {
//                    failure([object objectForKey:@"errorCode"]);
                }
            }
        }
        
    } fail:^(NSString *msg) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginFail" object:nil];
        if (failure) {
            failure(msg);
        }
    }];
}


- (void)getunReadMessageListCompleted:(void (^)(id))success{
    
    NSMutableArray *array = [NSMutableArray new];
    
    [DataBaseManager getUnReadListDataCompleted:^(NSArray *obj) {
        
        [array addObjectsFromArray:GLOBARMANAGER.unreadMessageList];
        [array addObjectsFromArray:obj];
        if(success){
            success(array);
        }
        
    }];
    

}

//判断用户设置中是否禁用相册
- (BOOL)checkPhotoEnable{
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        //无权限
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在iPhone的“设置-隐私-相册”选项中，允许微美薇商家访问你的相册。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}
//判断用户设置中是否禁用相机
- (BOOL)checkCameraEnable{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在iPhone的“设置-隐私-相机”选项中，允许微美薇商家访问你的相机。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;
}
@end
