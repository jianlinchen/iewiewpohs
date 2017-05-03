//
//  Message.h
//  Weimei
//
//  Created by Mac air on 15/8/26.
//  Copyright (c) 2015年 xujt@iwellfie.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *content;//消息内容
@property (nonatomic, strong) NSString *messageId;//消息id
@property (nonatomic, strong) NSString *msgContentType;//消息类型:TEXT/IMG
@property (nonatomic, strong) NSString *msgUserId;//用户id
@property (nonatomic, strong) NSString *msgUserName;//用户Name
@property (nonatomic, strong) NSString *sendTime;//发送时间
@property (nonatomic, strong) NSString *shopId;//商户id

@property (nonatomic, strong) NSString *RSType;//收到/发出

-(void)getMessage:(NSDictionary *)p;

@end
