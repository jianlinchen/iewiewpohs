//
//  MassEmailTableCell.h
//  Wei_Shop
//
//  Created by dzr on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
@interface MassEmailTableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *massHeaderImageView;
@property (strong, nonatomic) IBOutlet UILabel *massNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *massPhoneLabel;
//@property (strong, nonatomic) IBOutlet UIButton *massButton;


@property (strong, nonatomic) IBOutlet UIImageView *lateImageView;

//-(void)getMassCell:(Client*)client andTag:(NSInteger)p  addNsmuAaay:(NSMutableArray *)arr;
@end
