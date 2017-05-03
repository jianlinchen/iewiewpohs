//
//  PageFavourCell.h
//  Wei_Shop
//
//  Created by dzr on 15/12/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favourable.h"
@interface PageFavourCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *examzeImageView;
@property (strong, nonatomic) IBOutlet UILabel *examzeLabel;
@property (strong, nonatomic) IBOutlet UILabel *coupleLabel;
@property (strong, nonatomic) IBOutlet UILabel *singleCouLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
-(void)setFavourable:(Favourable *)favourable;
@end
