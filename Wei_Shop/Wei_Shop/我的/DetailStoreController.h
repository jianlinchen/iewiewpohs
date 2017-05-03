//
//  DetailStoreController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailStoreController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shopImageView;
- (IBAction)BackAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *labelll;
@end
