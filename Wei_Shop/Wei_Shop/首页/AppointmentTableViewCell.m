//
//  AppointmentTableViewCell.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "AppointmentTableViewCell.h"

@implementation AppointmentTableViewCell

+ (CGFloat)getCellHeight{
    return 115.0f;
}

- (void)awakeFromNib {
    // Initialization code
    self.imgUrl.layer.masksToBounds = YES;
    self.imgUrl.layer.cornerRadius = 40.0f;
    [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)teleBtnClick:(id)sender {
    
    if(self.delegate){
        
        [self.delegate didPhoneBtnClick:self.tel.text];
    }
}

- (void)confirm{
    
    if(self.delegate){
        
        [self.delegate didConfirmBtnClick:self.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
