//
//  CouponDetailViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "CouponDetailViewController.h"
#import "CouponDetailTableViewCell.h"
#import "BarnchGetCouponViewController.h"

@interface CouponDetailViewController ()


@property (nonatomic, strong) NSArray *titArray;
@property (weak, nonatomic) IBOutlet UILabel *CodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *proNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ruleLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation CouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认消费";
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 4.0f;
    
    if(self.couponDetail[@"verifyCode"]){
        self.CodeLabel.text = self.couponDetail[@"verifyCode"];
    }else{
       self.CodeLabel.text = @"";
    }
    if(self.couponDetail[@"couponName"]){
        self.proNameLabel.text = self.couponDetail[@"couponName"];
    }else{
        self.proNameLabel.text = @"";
    }
    if(self.couponDetail[@"feeValue"]){
        self.priceLabel.text = self.couponDetail[@"feeValue"];
    }else{
        self.priceLabel.text = @"";
    }
    
    if(self.couponDetail[@"startTime"] && self.couponDetail[@"endTime"]){
        self.DateLabel.text = [NSString stringWithFormat:@"%@至%@",self.couponDetail[@"startTime"],self.couponDetail[@"endTime"]];
    }else{
        self.DateLabel.text = @"";
    }
    
    if(self.couponDetail[@"couponTitle"]){
        self.ruleLabel.text = self.couponDetail[@"couponTitle"];
    }else{
        self.ruleLabel.text = @"";
    }
    
    [self.confirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(id)sender{
    
    if(self.couponDetail[@"takeId"]){
        [self useCoupon:self.couponDetail[@"takeId"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - HTTP确认消费接口
- (void)useCoupon:(NSString *)couponStr{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"takeId":couponStr};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:VerifyUse method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                [SVProgressHUD showSuccessWithStatus:@"确认成功!"];
                
                for(UIViewController *vc in self.navigationController.viewControllers){
                    if([vc isKindOfClass:[BarnchGetCouponViewController class]]){
                        [self.navigationController popToViewController:vc animated:YES];
                        return;
                    }
                }
                BarnchGetCouponViewController *VC = [[BarnchGetCouponViewController alloc]initWithNibName:@"BarnchGetCouponViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                return;
            }else{
                [SVProgressHUD showErrorWithStatus:@"使用失败"];
            }
        }
    } fail:^(NSString *msg) {
        
    }];
}
@end
