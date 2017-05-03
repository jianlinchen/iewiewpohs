//
//  ChatModel.h
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "UUMessageFrame.h"

@interface ChatModel : NSObject


+ (void)saveReceiveMessageToDBWithArray:(NSArray *)array;

+ (void)saveSendMessageToDBWithArray:(NSArray *)array;

+ (void)SaveToDBWithMessage:(Message *)message Receive:(BOOL)flag;

#pragma mark - 根据Dictionary生成UUMessageFrame,YES为收到，NO为发送
+ (UUMessageFrame *)generateUUMessageFrame:(NSDictionary *)source flag:(BOOL)flag;
#pragma mark - 获取聊天历史记录，本地DB取出
+ (NSArray *)getHistoryListWithShopId:(NSString *)shopId andUserId:(NSString *)userId;

//获取聊天未读消息列表请求
+ (void)getIMList:(NSInteger)page userId:(NSString *)userId
          success:(void (^)(id))success
          failure:(void (^)(NSString *))failure;
@end
