//
//  ClientTableCell.m
//  Wei_Shop
//
//  Created by dzr on 15/10/30.
//  Copyright (c) 2015年 cjl. All rights reserved.
//

#import "ClientTableCell.h"

@implementation ClientTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)getClient:(Client*)client{
    self.clientImageView.layer.cornerRadius = self.clientImageView.frame.size.width /2;
    
   self.clientImageView.clipsToBounds = YES;
    
    self.clientImageView.layer.borderWidth = 0.0f;
    NSURL *url=[NSURL URLWithString:client.icon];
         [self.clientImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4_cTouXiang"]];
      if (client.remark.length==0) {
        self.clientNameLabel.text=client.nickName;
      }else{
        self.clientNameLabel.text=client.remark;
     }
    self.clientPhoneLabel.text=client.mobile;
    
}
@end
