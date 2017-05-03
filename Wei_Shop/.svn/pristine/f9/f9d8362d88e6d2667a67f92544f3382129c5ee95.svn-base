//
//  BarnchGetCouponViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/3.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "BarnchGetCouponViewController.h"
#import "CouponQuanTableViewCell.h"
#import "CouponDetailViewController.h"
#import "ScanReaderViewController.h"

@interface BarnchGetCouponViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    NSInteger pageIndex;
    
}
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *plachholderLabel;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BarnchGetCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"商户验券";
    [self.codeField addTarget:self action:@selector(numberChanged:) forControlEvents:UIControlEventEditingChanged];
    self.codeField.delegate = self;
    pageIndex = 1;
    self.dataArray = [NSMutableArray new];
    self.topView.frame = CGRectMake(0, 0, APP_W, 183);
    self.mainTableView.tableHeaderView = self.topView;
    
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.tableFooterView = footView;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.plachholderLabel.hidden = NO;
    self.mainTableView.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        pageIndex ++;
        [self loadData];
        
    }];
    
    self.mainTableView.header = self.header;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
}
- (void)numberChanged:(id)sender{
    
    if([self.codeField.text isEqualToString:@""]){
        self.plachholderLabel.hidden = NO;
    }else{
        self.plachholderLabel.hidden = YES;
    }
    
}
- (void)loadNewData{
    [super loadNewData];
    [self.mainTableView.footer resetNoMoreData];
    pageIndex = 1;
    [self loadData];
}

#pragma mark - 扫描二维码页面跳转
- (IBAction)pushToScanView:(id)sender {

    if([GLOBARMANAGER checkCameraEnable]){
        ScanReaderViewController *VC = [[ScanReaderViewController alloc]initWithNibName:@"ScanReaderViewController" bundle:nil];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if(![textField.text isEqualToString:@""]){
        [self CouponQuanInfo:textField.text];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CouponQuanTableViewCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponQuanTableViewCell *cell = (CouponQuanTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CouponQuanTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    NSString *time = dic[@"verifyTime"];
    NSArray *array = [time componentsSeparatedByString:@" "];
    
    cell.dateLabel.text     = array[0];
    cell.timeLabel.text     = array[1];
    cell.proName.text       = dic[@"couponName"];
    cell.priceLabel.text    = [NSString stringWithFormat:@"￥%@",dic[@"feeValue"]];
    cell.codeLabel.text     = dic[@"verifyCode"];
    cell.costLabel.text     = dic[@"nickName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.codeField resignFirstResponder];
}

#pragma mark - 列表数据获取
- (void)loadData{

    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(pageIndex),@"pageSize":@(10)};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:VerifyList method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                if(pageIndex == 1){
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }else{
                    [self.dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }
                if(self.dataArray.count == 0){
                    
                }else{
                    [self.mainTableView reloadData];
                }
                
            }
        }
        
        if(pageIndex != 1){
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [self.mainTableView.footer endRefreshingWithNoMoreData];
            }else{
                [self.mainTableView.footer endRefreshing];
            }
        }
        
        [self.mainTableView.header endRefreshing];
    } fail:^(NSString *msg) {
        [self.mainTableView.header endRefreshing];
        [self.mainTableView.footer endRefreshing];
        
    }];
}


#pragma mark - 扫码/输入兑换码请求
- (void)CouponQuanInfo:(NSString *)couponStr{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"verifyCode":couponStr};

    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:Verifyinfo method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                CouponDetailViewController *VC = [[CouponDetailViewController alloc]initWithNibName:@"CouponDetailViewController" bundle:nil];
                VC.couponDetail = [object objectForKey:@"result"];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:[object objectForKey:@"error"][@"extDesc"]];
            }
        }
            } fail:^(NSString *msg) {
        
        
    }];

}

-(void)doBack:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
