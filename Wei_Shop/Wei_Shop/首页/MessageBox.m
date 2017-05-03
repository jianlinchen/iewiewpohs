//
//  MessageBox.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/9.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "MessageBox.h"
#import "API.h"
#import "Constant.h"
@implementation MessageBox


//获取聊天未读消息列表请求
+ (void)getUnReadListSuccess:(void (^)(id))success
                     failure:(void (^)(NSString *))failure{
    
    if(GLOBARMANAGER.userConfig && GLOBARMANAGER.userConfig.shopId){
        
    }else{
        return;
    }
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId};
    
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    
    [HttpRequest getData:requestDic path:ChatList method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            [GLOBARMANAGER.unreadMessageList removeAllObjects];
            [GLOBARMANAGER.unreadMessageList addObjectsFromArray:[object objectForKey:@"result"]];
            GLOBARMANAGER.unReadCount = 0;
            for(NSDictionary *dic in GLOBARMANAGER.unreadMessageList){
                
                GLOBARMANAGER.unReadCount += [dic[@"messageCount"] integerValue];
                
                [DataBaseManager deleteUnReadList:StrFromObj(dic[@"senderId"])Completed:^(id obj) {
                    
                }];
                
            }
            
            if(GLOBARMANAGER.unreadMessageList.count > 0){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UnreadMessage" object:nil];
            }
            if(success){
                success(GLOBARMANAGER.unreadMessageList);
            }
            
        }
    } fail:^(NSString *msg) {
        if(failure){
            failure(msg);
        }
    }];

}

@end
