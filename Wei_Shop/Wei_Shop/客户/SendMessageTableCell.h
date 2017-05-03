//
//  SendMessageTableCell.h
//  Wei_Shop
//
//  Created by dzr on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *topLabel;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *allNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *huiColorLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;
@end
