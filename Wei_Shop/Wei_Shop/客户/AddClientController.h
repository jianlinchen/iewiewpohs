//
//  AddClientController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AddClientController : BaseViewController
@property(strong,nonatomic)NSString *str;//用户端的流水号

@property (nonatomic, strong) NSDictionary *dic;

@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;

@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientYearLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientCityLabel;

@property (strong, nonatomic) IBOutlet UIButton *clientPhoneBtn;
@property (strong, nonatomic) IBOutlet UILabel *clientGenderLabel;

- (IBAction)addClientAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *deatailLeftLabel;

@property (strong, nonatomic) IBOutlet UILabel *detailRightLabel;
@end
