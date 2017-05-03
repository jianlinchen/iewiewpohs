//
//  Coment.h
//  Wei_Shop
//
//  Created by dzr on 15/12/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coment : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *commentUserName;
@property (nonatomic, strong) NSString *commentUserIcon;
@property (nonatomic, strong) NSString *content;
@property (nonatomic,strong)  NSString *commentTime;
@property (nonatomic,strong)  NSString *score;
@property (nonatomic,strong)  NSMutableArray *imgList;
@property (nonatomic,strong)  NSMutableArray *echoList;

-(void)getComent:(NSDictionary *)p;

@end
