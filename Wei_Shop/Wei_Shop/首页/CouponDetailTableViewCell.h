//
//  CouponDetailTableViewCell.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

+ (CGFloat)getCellHeight;

@end
