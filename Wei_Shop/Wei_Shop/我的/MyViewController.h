//
//  MyViewController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface MyViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *beijImageview;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *myTableHeaderView;

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *myNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *myAccountLabel;
@end
