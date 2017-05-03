//
//  Service.h
//  Wei_Shop
//
//  Created by dzr on 15/12/8.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *serviceDesc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic,strong)  NSString *status;
@property (nonatomic,strong)  NSString *statusName;
@property (nonatomic,strong)  NSString *shopName;

@property (nonatomic,strong)  NSString *collectCount;
@property (nonatomic,strong)  NSString *wapUrl;

@property(nonatomic,strong)NSString *ttt ;
-(void)getService:(NSDictionary *)p;


@end
