//
//  DetailStoreCell.h
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailStoreCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *detailLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailRightLabel;

+ (CGFloat)getCellHeight;
@end
