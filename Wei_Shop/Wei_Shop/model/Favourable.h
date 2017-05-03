//
//  Favourable.h
//  Wei_Shop
//
//  Created by dzr on 15/12/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Favourable : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic,strong)  NSString *shopName;
@property (nonatomic,strong)  NSString *hot;
@property (nonatomic,strong)  NSString *feeValue;
@property (nonatomic,strong)  NSString *startTime;
@property (nonatomic,strong)  NSString *endTime;

@property (nonatomic,strong)   NSString * takeCount;
@property (nonatomic,strong)   NSString * allCount;
@property (nonatomic,strong)   NSString * limitCount;

@property (nonatomic,strong)   NSString * isRecommended;
@property (nonatomic,strong)   NSString * status;
@property (nonatomic,strong)  NSString *statusName;

@property(nonatomic,strong)NSString *ttt ;
-(void)getFavourable:(NSDictionary *)p;

@end
