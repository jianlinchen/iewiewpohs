//
//  User.m
//  Tourism
//
//  Created by vin on 14-10-16.
//  Copyright (c) 2014年 LianZhan. All rights reserved.
//

#import "UserConstant.h"

@implementation UserConstant

-(id)init{
    self = [super init];
    if (self) {
//        [User shareUser].isAuth = nil;
        
        self.lat = @"0";
        self.lon = @"0";
    }
    return self;
}
-(void)getUser:(NSDictionary *)p{
    Dictionary2Object(p, @"imgURL", self.imgURL);
    Dictionary2Object(p, @"phoneNO", self.phoneNO);
    Dictionary2Object(p, @"signFlag", self.signFlag);
    Dictionary2Object(p, @"userId", self.userId);
    Dictionary2Object(p, @"userName", self.userName);
}
@end
