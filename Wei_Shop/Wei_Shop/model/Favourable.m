//
//  Favourable.m
//  Wei_Shop
//
//  Created by dzr on 15/12/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "Favourable.h"

@implementation Favourable
-(void)getFavourable:(NSDictionary *)p{
    Dictionary2Object(p, @"id", self.id);
    Dictionary2Object(p, @"name", self.name);
    Dictionary2Object(p, @"title", self.title);
    Dictionary2Object(p, @"shopId", self.shopId);
    Dictionary2Object(p, @"shopName", self.shopName);
    Dictionary2Object(p, @"hot", self.hot);
    Dictionary2Object(p, @"feeValue", self.feeValue);
    Dictionary2Object(p, @"startTime", self.startTime);
    Dictionary2Object(p, @"endTime", self.endTime);
    
    Dictionary2Object(p, @"takeCount", self.takeCount);
    Dictionary2Object(p, @"allCount", self.allCount);
    Dictionary2Object(p, @"limitCount", self.limitCount);
    Dictionary2Object(p, @"isRecommended", self.isRecommended);
    Dictionary2Object(p, @"status", self.status);
    Dictionary2Object(p, @"statusName", self.statusName);
}



@end
