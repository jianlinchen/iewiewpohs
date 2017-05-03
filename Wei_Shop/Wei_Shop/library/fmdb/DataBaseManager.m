//
//  DataBaseManager.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "DataBaseManager.h"
#import "Message.h"

@implementation DataBaseManager


//打开数据库
+ (FMDatabase *)openDataBase{

    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/data.db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if(db.open){
        return db;
    }else{
        [db open];
        return db;
    }
}

//创建表的集合
+ (void)createTables{
    
    [DataBaseManager createSearchHistoryTable];
    [DataBaseManager createIMHistoryTable];
    [DataBaseManager createUnReadListTable];
    [DataBaseManager createSearchClientTable];//客户的表格
}

//未读消息数据库表
+ (BOOL)createUnReadListTable{
    
    BOOL res = [DATAMANAGER executeUpdate:@"create table if not exists UnReadList(senderId varchar(256) primary  key,senderName,senderIcon,lastContent,lastSendTime)"];
    
    if (res == NO) {
        NSLog(@"UnReadList创建失败");
    }else if(res==YES){
        NSLog(@"UnReadList创建成功");
    }
    return res;
}
//未读消息记录插入
+ (void)insertUnReadListToDB:(NSString *)senderId senderName:(NSString *)senderName senderIcon:(NSString *)senderIcon content:(NSString *)lastContent lastSendTime:(NSString *)lastSendTime{
    
    BOOL flag = [DATAMANAGER executeUpdate:@"INSERT INTO UnReadList (senderId,senderName,senderIcon,lastContent,lastSendTime) VALUES (?,?,?,?,?)",senderId,senderName,senderIcon,lastContent,lastSendTime];
    if(flag){
        NSLog(@"UnReadList插入成功");
    }else{
        NSLog(@"UnReadList插入成功");
    }
}
//未读消息记录取出
+ (void)getUnReadListDataCompleted:(void (^)(id))success{
    
    FMResultSet* set = [DATAMANAGER executeQuery:@"select * from UnReadList"];
    
    NSMutableArray* array = [NSMutableArray new];
    
    while ([set next]){
        
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"senderId"]    = [set stringForColumnIndex:0];
        dic[@"senderName"]  = [set stringForColumnIndex:1];
        dic[@"senderIcon"]  = [set stringForColumnIndex:2];
        dic[@"lastContent"] = [set stringForColumnIndex:3];
        dic[@"lastSendTime"]= [set stringForColumnIndex:4];
        [array addObject:dic];
    }
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSMutableDictionary *dic1 = (NSMutableDictionary *)obj1;
        NSMutableDictionary *dic2 = (NSMutableDictionary *)obj2;
        
        if ([dic1[@"lastSendTime"] compare:dic2[@"lastSendTime"]] == NSOrderedAscending) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([dic1[@"lastSendTime"] compare:dic2[@"lastSendTime"]] == NSOrderedDescending) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    if(success){
        success(sortedArray);
    }
}
//删除与某个人的未读消息
+ (void)deleteUnReadList:(NSString *)senderId Completed:(void (^)(id))success{
    
    BOOL res = [DATAMANAGER executeUpdate:@"delete from UnReadList where senderId=?",senderId];

    if (res == NO) {
        NSLog(@"UnReadList删除失败");
    }else if(res==YES){
        NSLog(@"UnReadList删除成功");
        if(success){
            success(nil);
        }
    }
}

//搜索历史数据库表
+ (BOOL)createIMHistoryTable{
    
    BOOL res = [DATAMANAGER executeUpdate:@"create table if not exists IMHistoryList(id PRIMARY KEY,userId,shopId,sendTime,type,content,RS)"];
    
    if (res == NO) {
        NSLog(@"IMHistoryList创建失败");
    }else if(res==YES){
        NSLog(@"IMHistoryList创建成功");
    }
    return res;
}

//聊天历史记录插入
+ (void)insertIMHistoryToDB:(NSString *)messageId userId:(NSString *)userId shopId:(NSString *)shopId sendTime:(NSString *)sendTime messageType:(NSString *)type content:(NSString *)content receiveOrSend:(NSString *)RS{
    
    BOOL flag = [DATAMANAGER executeUpdate:@"INSERT INTO IMHistoryList (id,userId,shopId,sendTime,type,content,RS) VALUES (?,?,?,?,?,?,?)",messageId,userId,shopId,sendTime,type,content,RS];
    if(flag){
        NSLog(@"聊天记录插入成功");
    }
}

//聊天历史记录取出
+ (NSArray *)getIMHistoryData:(NSString *)userId shopId:(NSString *)shopId{
    
    FMResultSet* set = [DATAMANAGER executeQuery:@"select * from IMHistoryList where userId=? and shopId=?",userId,shopId];
    
    NSMutableArray* array = [NSMutableArray new];
    
    while ([set next]){
        //按条取出数据，转换为Model输出
        Message *message = [[Message alloc]init];
        //消息id
        message.messageId = [set stringForColumnIndex:0];
        //用户id
        message.msgUserId = [set stringForColumnIndex:1];
        //商家id
        message.shopId = [set stringForColumnIndex:2];
        //时间戳
        message.sendTime = [set stringForColumnIndex:3];
        //数据类型
        message.msgContentType = [set stringForColumnIndex:4];
        //内容
        message.content = [set stringForColumnIndex:5];
        //收到/发出消息:
        message.RSType = [set stringForColumnIndex:6];
        message.msgUserName = @"";
        
        [array addObject:message];
    }
    [set close];
    
    //根据时间戳排序
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
        Message *object1 = (Message *)obj1;
        Message *object2 = (Message *)obj2;
        
        if ([object1.sendTime compare:object2.sendTime] == NSOrderedAscending) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([object1.sendTime compare:object2.sendTime] == NSOrderedDescending) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return sortedArray;
    

}


//搜索历史数据库表
+ (BOOL)createSearchHistoryTable{
    
    BOOL res = [DATAMANAGER executeUpdate:@"create table if not exists SearchHistoryList(keyWord)"];
    
    if (res == NO) {
        NSLog(@"SearchHistoryList创建失败");
    }else if(res==YES){
        NSLog(@"SearchHistoryList创建成功");
    }
    return res;
}


//搜索历史记录插入数据库
+ (void)insertSearchHistoryToDB:(NSString *)keyWord{
    
    BOOL flag = [DATAMANAGER executeUpdate:@"INSERT INTO SearchHistoryList (keyWord) VALUES (?)",keyWord];
   
}

//搜索历史记录从数据库中取出
+ (NSMutableArray *)getSearchHistoryData{
    
    FMResultSet* set = [DATAMANAGER executeQuery:@"select * from SearchHistoryList"];
    
    NSMutableArray* array = [NSMutableArray new];
    
    while ([set next]){

        [array addObject:[set stringForColumnIndex:0]];
    }
    [set close];
    
    return array;
}

+(void)DeleteSingleHistoryData:(NSString *)keyWord{
    [DATAMANAGER executeUpdate:@"delete from SearchHistoryList where "];
    
}
+ (void)DeleteSearchHistoryData{
    
    [DATAMANAGER executeUpdate:@"delete from SearchHistoryList"];
}









//搜索历史数据库表


+ (BOOL)createSearchClientTable{
    
    BOOL res = [DATAMANAGER executeUpdate:@"create table if not exists SearchClientList(keyWord)"];
    
    if (res == NO) {
        NSLog(@"SearchClientList创建失败");
    }else if(res==YES){
        NSLog(@"SearchClientList创建成功");
    }
    return res;
}


//搜索历史记录插入数据库
+ (void)insertSearchClientToDB:(NSString *)keyWord{
    
    BOOL flag = [DATAMANAGER executeUpdate:@"INSERT INTO SearchClientList (keyWord) VALUES (?)",keyWord];
    
}




//搜索历史记录从数据库中取出
+ (NSMutableArray *)getSearchClientData{
    
    FMResultSet* set = [DATAMANAGER executeQuery:@"select * from SearchClientList"];
    
    NSMutableArray* array = [NSMutableArray new];
    
    while ([set next]){
        
        [array addObject:[set stringForColumnIndex:0]];
    }
    [set close];
    
    return array;
}

+ (void)DeleteSearchClientData{
    
    [DATAMANAGER executeUpdate:@"delete from SearchClientList"];
}
//删除一条搜索历史记录
+ (void)DeletSingleeSearchClientData{
    
};


@end
