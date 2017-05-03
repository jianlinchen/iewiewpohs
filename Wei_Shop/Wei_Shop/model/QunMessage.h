//
//  QunMessage.h
//  Wei_Shop
//
//  Created by dzr on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QunMessage : NSObject
@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, strong) NSString *msgTitle;
@property (nonatomic, strong) NSString *msgContentType;
@property (nonatomic, strong) NSString *msgContent;
@property (nonatomic,strong)  NSString *sendTime;
@property (nonatomic,strong)  NSMutableArray *receiversArray;
//@property (nonatomic,strong)  NSString *cid;//会员/顾客ID
//
//@property (nonatomic,strong)  NSString *uid;//用户ID
//@property (nonatomic,strong)  NSString * name;//显示名称
-(void)QunMessage:(NSDictionary *)p;

@end
