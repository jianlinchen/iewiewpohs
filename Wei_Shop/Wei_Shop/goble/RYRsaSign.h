//
//  RYRsaSign.h
//  RYEnDecrypt
//
//  Created by 张如进 on 14-6-10.
//  Copyright (c) 2014年 raiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RYRsaSign : NSObject

+ (NSString *)RSAEncrypt:(NSString *)string key:(NSString *)key;

@end
