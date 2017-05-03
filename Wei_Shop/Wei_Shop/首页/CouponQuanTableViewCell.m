//
//  CouponQuanTableViewCell.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/3.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "CouponQuanTableViewCell.h"

@implementation CouponQuanTableViewCell

+ (CGFloat)getCellHeight{
    
    return 85.0f;
}

- (void)awakeFromNib {
    // Initialization code
    self.dateLabel.text     = @"";
    self.timeLabel.text     = @"";
    self.proName.text       = @"";
    self.priceLabel.text    = @"";
    self.codeLabel.text     = @"";
    self.costLabel.text     = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
