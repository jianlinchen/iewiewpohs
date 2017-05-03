//
//  HttpRequest.h
//  hk_money
//
//  Created by vin on 14-7-21.
//  Copyright (c) 2014年 LianZhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

//+(HttpRequest*)shareInstance;

+(void)getWebData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail;


//上传图片方法
+(void)uploadImage:(NSDictionary *)params path:(NSString *)path image:(NSArray *)imageArr file:(NSString *)file success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail;


+(void)getData:(NSDictionary *)params path:(NSString *)path method:(NSString *)method success:(void(^)(id object))success fail:(void(^)(NSString* msg))fail;
@end
