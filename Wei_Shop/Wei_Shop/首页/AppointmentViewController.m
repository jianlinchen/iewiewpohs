//
//  AppointmentViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "AppointmentViewController.h"
#import "AppointmentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AppointmentSearchViewController.h"

@interface AppointmentViewController ()<UITableViewDataSource,UITableViewDelegate,AppointmentTableViewCellDelegate,UIAlertViewDelegate>{
    NSInteger page;
}

@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation AppointmentViewController
@synthesize mainTableView;
@synthesize dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约信息";
    page = 1;
    dataArray = [NSMutableArray new];
    
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - 44)];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
         [self.mainTableView .footer resetNoMoreData];
        // 进入刷新状态后会自动调用这个block
        page ++;
        [self loadData];
    }];
    
    self.mainTableView.header = self.header;
    [self.view addSubview:mainTableView];
    
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtnClick:)];
    
    self.navigationItem.rightBarButtonItem = right;
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 44, 44);
//    
//    [backBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self loadData];
}
- (void)loadNewData{
    [super loadNewData];
    [mainTableView.footer resetNoMoreData];
    page = 1;
    [self loadData];
}

- (void)searchBtnClick:(id)sender{
    
    AppointmentSearchViewController *VC = [[AppointmentSearchViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AppointmentTableViewCellDelegate
- (void)didConfirmBtnClick:(NSInteger)index{
    
    NSDictionary *dic = self.dataArray[index];
    
    [self confirmAppointment:dic[@"id"]];
}

- (void)didPhoneBtnClick:(NSString *)tel{
    
    [[[UIAlertView alloc]initWithTitle:tel message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil] show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",alertView.title]]];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [AppointmentTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppointmentTableViewCell *cell = (AppointmentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"AppointmentTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.tag = indexPath.row;
    cell.delegate = self;
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.name.text = dic[@"call"];
    cell.tel.text = dic[@"appointMobile"];
    cell.time.text = [NSString stringWithFormat:@"预约时间：%@",dic[@"appointmentTime"]];
    NSURL *url=[NSURL URLWithString:dic[@"icon"]];
    [cell.imgUrl setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4_cTouXiang"]];
    
    if(indexPath.row + 1 == self.dataArray.count){
        cell.sepeator.hidden = YES;
        cell.line1.hidden = YES;
        cell.line2.hidden = YES;
    }else{
        cell.sepeator.hidden = NO;
        cell.line1.hidden = NO;
        cell.line2.hidden = NO;
    }
    
    NSString *tt=dic[@"statusName"];
    
    if ([tt isEqualToString:@"待确认"]) {
        [cell.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    }else{
        [cell.confirmBtn setTitle:@"已确认" forState:UIControlStateNormal];
        
    }
    
//    [cell.confirmBtn setTitle:dic[@"statusName"] forState:UIControlStateNormal];
    if([dic[@"status"] intValue] == 1){
        cell.confirmImage.hidden = YES;
        cell.confirmBtn.titleLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0f];
        cell.confirmBtn.enabled = NO;
    }else{
        cell.confirmImage.hidden = NO;
        cell.confirmBtn.titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:138.0/255.0 blue:183.0/255.0 alpha:1.0f];
        cell.confirmBtn.enabled = YES;
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSDictionary *dic = dataArray[indexPath.row];
//    if([dic[@"status"] intValue] == 1){
//        return NO;
//    }else{
        return YES;
//    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        NSDictionary *dic = dataArray[indexPath.row];
        [self deleteAppointment:dic[@"id"]];
        [dataArray removeObject:dic];
        [self.mainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - HTTP请求列表数据
- (void)loadData{

    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"keyWord":@"",@"pageSize":@(10)};
    
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    
    [HttpRequest getWebData:requestDic path:ShopAppointmentList method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                if(page == 1){
                    [dataArray removeAllObjects];
                    [dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }else{
                    [dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }
                if(dataArray.count > 0){
                    [self.mainTableView reloadData];
                }
            }
        }
        if(page == 1 && dataArray.count == 0){
            [self showNoDataViewWithString:@"没有数据" andImage:nil];
        }
        if(page != 1){
            
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [self.mainTableView.footer endRefreshingWithNoMoreData];
            }else{
                [self.mainTableView.footer endRefreshing];
            }
        }else{
            [self.mainTableView.header endRefreshing];
        }
    } fail:^(NSString *msg) {
        
    }];
}
#pragma mark - HTTP确认预约
- (void)confirmAppointment:(NSString *)appoiStr{
    
//    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%@",appoiStr);
    NSDictionary *dic = @{@"id":appoiStr};
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    [HttpRequest getWebData:requestDic path:ConfirmAppointment method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                [SVProgressHUD showSuccessWithStatus:@"确认成功!"];
                page = 1;
                [mainTableView.footer resetNoMoreData];
                [self loadData];
            }
        }
    } fail:^(NSString *msg) {
        
        
    }];
}

#pragma mark - HTTP删除预约
- (void)deleteAppointment:(NSString *)appoiStr{
    
    NSDictionary *dic = @{@"id":appoiStr};
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    [HttpRequest getData:requestDic path:DeleteAppointment method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                [SVProgressHUD showSuccessWithStatus:@"删除成功!"];
                 [mainTableView.footer resetNoMoreData];
                page = 1;
                [self loadData];
            }
        }
    } fail:^(NSString *msg) {
        
    }];
}
@end
