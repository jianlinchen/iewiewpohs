//
//  DetailCustomController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/3.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
#import "BaseViewController.h"
@interface DetailCustomController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)changeNameAction:(id)sender;

- (IBAction)callACtion:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *clinentButton;
@property (strong, nonatomic) IBOutlet UILabel *detailLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailRightLabel;

@property (strong, nonatomic) IBOutlet UIView *detailHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic)  Client *detailClient;

@property (strong, nonatomic) IBOutlet UIImageView *clientImageView;
@property (strong, nonatomic) IBOutlet UILabel *clientNickLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientRemakLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientGenderLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientYearLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientAddresLabel;

@property (strong, nonatomic) IBOutlet UILabel *clientcountLabel;
- (IBAction)popBckAction:(id)sender;
@end
