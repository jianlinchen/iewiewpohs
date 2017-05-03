//
//  Message.m
//  Weimei
//
//  Created by Mac air on 15/8/26.
//  Copyright (c) 2015年 xujt@iwellfie.net. All rights reserved.
//

#import "Message.h"
#import "GlobarManager.h"

@implementation Message
-(void)getMessage:(NSDictionary *)p{
    
    self.content        = [p objectForKey:@"content"];
    self.msgContentType = [p objectForKey:@"msgContentType"];
    self.messageId      = [p objectForKey:@"id"];
    self.msgUserId      = [p objectForKey:@"msgUserId"];
    self.shopId         = GLOBARMANAGER.userConfig.shopId;
    self.msgUserName    = [p objectForKey:@"msgUserName"];
    self.sendTime       = [p objectForKey:@"sendTime"];
      
}
@end
