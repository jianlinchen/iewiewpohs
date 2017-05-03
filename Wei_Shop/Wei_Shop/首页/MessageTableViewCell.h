//
//  MessageTableViewCell.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/6.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagIcon;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberIcon;

+ (CGFloat)getCellHeight;
- (void)setCell:(NSDictionary *)dic;

@end
