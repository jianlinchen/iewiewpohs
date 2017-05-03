//
//  Client.h
//  Wei_Shop
//
//  Created by dzr on 15/10/30.
//  Copyright (c) 2015年 cjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject
@property (nonatomic, strong) NSString *customerId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic,strong)  NSString *remark;
@property (nonatomic,strong)  NSString *spell;
@property (nonatomic,strong)  NSString *icon;
@property (nonatomic,strong)  NSString *mobile;
@property (nonatomic,strong)  NSArray *tagIds;
@property (nonatomic)  BOOL isSelect;
@property(nonatomic,strong)NSString *ttt ;
-(void)getClient:(NSDictionary *)p;

@end
