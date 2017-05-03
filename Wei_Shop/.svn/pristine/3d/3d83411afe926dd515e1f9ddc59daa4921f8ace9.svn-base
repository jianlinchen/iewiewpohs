//
//  ChatModel.m
//  UUChatTableView
//
//  Created by shake on 15/1/6.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "ChatModel.h"
#import "UUMessage.h"

#import "AppDelegate.h"

#import "Reachability.h"
#import "SVProgressHUD.h"
#import "GlobarManager.h"
#import "API.h"
#import "Constant.h"

@implementation ChatModel

static NSString *previousTime = @"";

+ (void)getIMList:(NSInteger)page userId:(NSString *)userId
                success:(void (^)(id))success
                failure:(void (^)(NSString *))failure
{
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"userId":userId,@"pageSize":@(10),@"pageIndex":@(page)};
    
    
    [HttpRequest getData:[GLOBARMANAGER AppKeyTokenDic:dic] path:IMList method:@"GET" success:^(id object) {
        
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                if(success){
             
                    success([[[self getModelArray:object[@"result"]] reverseObjectEnumerator] allObjects]);
                }
            }
        }
        
    } fail:^(NSString *msg) {
        
        if (failure) {
            failure(msg);
        }
    }];
}

#pragma mark - 获取聊天历史记录，本地DB取出
+ (NSArray *)getHistoryListWithShopId:(NSString *)shopId andUserId:(NSString *)userId{
    
    NSArray *array = [DataBaseManager getIMHistoryData:StrFromObj(userId) shopId:StrFromObj(GLOBARMANAGER.userConfig.shopId)];
    NSMutableArray *data = [NSMutableArray new];
    for(Message *msg in array){
        [data addObject:[ChatModel generateUUMessageFrame:msg]];
    }
    return data;
}

+ (NSArray *)getModelArray:(NSArray *)arr{
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (int a = 0; a < arr.count; a ++) {
        
            [result addObject:[self generateUUMessageFrame:[arr objectAtIndex:a]flag:YES]];
        }
    
    return result;
}


+ (UUMessageFrame *)generateUUMessageFrame:(Message *)message{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    //设置内容 是文字还是图片
    
    if ([message.msgContentType isEqualToString:@"IMG"]) {
        
        [dic setObject:message.content forKey:@"picture"];
        
        [dic setObject:@(UUMessageTypePicture) forKey:@"type"];
        
    }else{
        
        [dic setObject:message.content forKey:@"strContent"];
        
        [dic setObject:@(UUMessageTypeText) forKey:@"type"];
        
    }
    
    //设置  内容是我发的还是接受的(设置头像)
    [dic setObject:message.messageId forKey:@"strId"];
    if ([message.RSType isEqualToString:IMReceive]) {
        
        [dic setObject:@(UUMessageFromOther) forKey:@"from"];
        [dic setObject:message.msgUserId forKey:@"strUserId"];
        if([GLOBARMANAGER.userImg isEqualToString:@""]){
            [dic setObject:@"" forKey:@"strIcon"];
        }else{
            [dic setObject:GLOBARMANAGER.userImg forKey:@"strIcon"];
        }
        
        [dic setObject:message.msgUserName forKey:@"strName"];
        
    }else{
        
        [dic setObject:@(UUMessageFromMe) forKey:@"from"];
        
        [dic setObject:GLOBARMANAGER.userConfig.shopImg forKey:@"strIcon"];
        
        [dic setObject:message.sendTime forKey:@"sendTime"];
        
    }
    
    //设置时间
    
    if (message.sendTime.length == 0) {
        
        [dic setObject:@"" forKey:@"strTime"];
        
    }else{
        
        [dic setObject:message.sendTime forKey:@"strTime"];
        
    }
    
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    
    UUMessage *mess = [[UUMessage alloc] init];
    
    [mess setWithDict:dic];
    
    //        [mess minuteOffSetStart:previousTime end:dic[@"sendTime"]];
    
    messageFrame.showTime = mess.showDateLabel;
    
    [messageFrame setMessage:mess];
    
    return messageFrame;
}

#pragma mark - 根据Dictionary生成UUMessageFrame,YES为收到，NO为发送
+ (UUMessageFrame *)generateUUMessageFrame:(NSDictionary *)source flag:(BOOL)flag{
    
    Message *message = [[Message alloc]init];
    
    [message getMessage:source];
    
    if(flag){
        message.RSType = IMReceive;
    }else{
        message.RSType = IMSend;
    }
    
    [DataBaseManager insertIMHistoryToDB:StrFromObj(message.messageId) userId:StrFromObj(message.msgUserId) shopId:StrFromObj(GLOBARMANAGER.userConfig.shopId) sendTime:StrFromObj(message.sendTime) messageType:StrFromObj(message.msgContentType) content:StrFromObj(message.content) receiveOrSend:StrFromObj(message.RSType)];
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    //设置内容 是文字还是图片
    
    if ([message.msgContentType isEqualToString:@"IMG"]) {
        
        [dic setObject:message.content forKey:@"picture"];
        
        [dic setObject:@(UUMessageTypePicture) forKey:@"type"];
        
    }else{
        
        [dic setObject:message.content forKey:@"strContent"];
        
        [dic setObject:@(UUMessageTypeText) forKey:@"type"];
        
    }
    
    //设置  内容是我发的  还是接受的   //设置头像
    [dic setObject:message.messageId forKey:@"strId"];
    if ([message.RSType isEqualToString:IMReceive]) {
        
        [dic setObject:@(UUMessageFromOther) forKey:@"from"];
        [dic setObject:message.msgUserId forKey:@"strUserId"];
        [dic setObject:GLOBARMANAGER.userImg forKey:@"strIcon"];
        [dic setObject:message.msgUserName forKey:@"strName"];
        
    }else{
        
        [dic setObject:@(UUMessageFromMe) forKey:@"from"];
        
        [dic setObject:GLOBARMANAGER.userConfig.icon forKey:@"strIcon"];
        
        [dic setObject:message.sendTime forKey:@"sendTime"];
        
    }
    
    //设置时间
    
    if (message.sendTime.length == 0) {
        
        [dic setObject:@"" forKey:@"strTime"];
        
    }else{
        
        [dic setObject:message.sendTime forKey:@"strTime"];
        
    }
    
    UUMessageFrame *messageFrame = [[UUMessageFrame alloc]init];
    
    UUMessage *mess = [[UUMessage alloc] init];
    
    [mess setWithDict:dic];
    
    //        [mess minuteOffSetStart:previousTime end:dic[@"sendTime"]];
    
    messageFrame.showTime = mess.showDateLabel;
    
    [messageFrame setMessage:mess];
    
    return messageFrame;
}

#pragma mark - 保存Message数组到数据库(收到数据)
+ (void)saveReceiveMessageToDBWithArray:(NSArray *)array{
    
    for (int i = 0; i < array.count; i ++) {
        
        Message *message = [[Message alloc]init];
        [message getMessage:[array objectAtIndex:i]];
    }
}




@end
