//
//  Chant.h
//  Wei_Shop
//
//  Created by dzr on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved.
//
//接收
#import <Foundation/Foundation.h>

@interface Chant : NSObject
@property (nonatomic, strong) NSString *id;//消息ID,long
@property (nonatomic, strong) NSString *msgUserId;//发送者用户ID,Long
@property (nonatomic, strong) NSString *msgUserName;//发送者用户名称
@property (nonatomic, strong) NSString *msgContentType;//消息类型,IMG("IMG","图片"),TEXT("TEXT","文字"),WAP("WAP","网页"),JSON("JSON","json"),
@property (nonatomic,strong)  NSString *content;//内容
@property (nonatomic,strong)  NSString *sendTime;//发送时间
@property (nonatomic, strong) NSString *shopId;//商家Id

@property (nonatomic, strong) NSString *RS;//收到/发送

-(void)QunMessage:(NSDictionary *)p;

@end
