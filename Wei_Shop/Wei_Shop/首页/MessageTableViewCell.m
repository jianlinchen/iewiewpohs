//
//  MessageTableViewCell.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/6.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imagIcon.layer.masksToBounds = YES;
    self.imagIcon.layer.cornerRadius = 32.0f;
    
    self.nameLabel.text = @"";
    self.contentLabel.text = @"";
    self.numberLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeight{
    
    return 100.0f;
}

- (void)setCell:(NSDictionary *)dic{
    
    [self.imagIcon setImageWithURL:[NSURL URLWithString:dic[@"senderIcon"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.timeLabel.text = [self formatString:dic[@"lastSendTime"]];
    
    
    self.nameLabel.text = [self formatString:dic[@"senderName"]];
    
    NSString *content = [self formatString:dic[@"lastContent"]];
    
    NSRange range = [content rangeOfString:@"://"];//判断字符串是否包含
    if(range.length > 0){
        self.contentLabel.text = @"[图片]";
    }else{
        self.contentLabel.text = content;
    }
    NSString *number = [self formatString:dic[@"messageCount"]];
    
    if([number intValue] == 0 || [number isEqualToString:@""]){
        self.numberIcon.hidden = YES;
        self.numberLabel.hidden = YES;
    }else{
        self.numberIcon.hidden = NO;
        self.numberLabel.hidden = NO;
        self.numberLabel.text = number;
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(0xdbdbdb);
    [self addSubview:line];
}

- (NSString *)formatString:(id)obj{
    
    if(obj == nil){
        return @"";
    }
    return [NSString stringWithFormat:@"%@",obj];
}

@end
