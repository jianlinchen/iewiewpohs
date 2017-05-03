//
//  AppointmentTableViewCell.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppointmentTableViewCellDelegate <NSObject>

- (void)didPhoneBtnClick:(NSString *)tel;
- (void)didConfirmBtnClick:(NSInteger)index;

@end

@interface AppointmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *sepeator;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIImageView *imgUrl;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIImageView *confirmImage;

@property (assign, nonatomic) id<AppointmentTableViewCellDelegate>delegate;

+ (CGFloat)getCellHeight;

@end
