//
//  AppointmentSearchViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "AppointmentSearchViewController.h"
#import "AppointmentTableViewCell.h"
@interface AppointmentSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,AppointmentTableViewCellDelegate,UISearchBarDelegate>{
    UITextField* m_searchField;     //顶部搜索框
    UISearchBar *mySearchBar;
    NSInteger page;
}

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *historyArray;

@end

@implementation AppointmentSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray new];
    self.historyArray = [NSMutableArray new];
    page = 1;
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 5, APP_W - 100, 35)];
    mySearchBar.delegate = self;
    
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APP_W, APP_H - 44)];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.backgroundColor = RGBHex(0xf5f5f5);
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *footView = [[UIView alloc]init];
    self.mainTableView.tableFooterView = footView;
    
    
    [self.view addSubview:self.mainTableView];
    mySearchBar.tintColor = [UIColor blueColor];
    
    if (iOSo7) {
        UIView* barView = [mySearchBar.subviews objectAtIndex:0];
        [[barView.subviews objectAtIndex:0] removeFromSuperview];
        UITextField* searchField = [barView.subviews objectAtIndex:0];
        searchField.font = [UIFont systemFontOfSize:13.0f];
        [searchField setReturnKeyType:UIReturnKeySearch];
    } else {
        [[mySearchBar.subviews objectAtIndex:0] removeFromSuperview];
        UITextField* searchField = [mySearchBar.subviews objectAtIndex:0];
        searchField.delegate = self;
        searchField.font = [UIFont systemFontOfSize:13.0f];
        [searchField setReturnKeyType:UIReturnKeySearch];
        m_searchField = searchField;
    }
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:mySearchBar];
    mySearchBar.placeholder = @"电话/姓氏";
    [self loadHistoryData];
    [mySearchBar becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [mySearchBar resignFirstResponder];
    [mySearchBar removeFromSuperview];
    
}

#pragma mark - 获取历史数据
- (void)loadHistoryData{
    [self.historyArray removeAllObjects];
    NSMutableArray *deleArray=[[NSMutableArray alloc]init];
    deleArray=[DataBaseManager getSearchHistoryData];
    NSArray* reversedArray = [[deleArray reverseObjectEnumerator] allObjects];
    
    for (unsigned i = 0; i < [reversedArray count]; i++){
        
        if ([self.historyArray containsObject:[reversedArray objectAtIndex:i]] == NO){
            
            [self.historyArray addObject:[reversedArray objectAtIndex:i]];
            
        }
        
        
        
    }
//   self.historyArray = [DataBaseManager getSearchHistoryData];
////    
    
    
    if(self.historyArray.count > 0){
        [self removeNoDataView];
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 45.0f)];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 50, 21)];
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        label.text = @"搜索历史";
        [headView addSubview:label];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5f, APP_W, 0.5f)];
        line.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
        [headView addSubview:line];
        self.mainTableView.tableHeaderView = headView;
    
        [self.mainTableView reloadData];
    }else{
        [self showNoDataViewWithString:@"暂无历史搜索记录" andImage:nil];
    }
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchBar.text isEqualToString:@""]){
        [self.dataArray removeAllObjects];
        [self removeNoDataView];
        self.mainTableView.footer = nil;
        [self loadHistoryData];
    }else{
        self.mainTableView.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            page ++;
            [self loadDataWithKeyword:mySearchBar.text];
            
        }];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    NSMutableArray *topArray = [NSMutableArray new];
//    topArray= [DataBaseManager getSearchHistoryData];
//    for (int i = 0 ; i< [topArray count]; i ++) {
//    if ( [topArray containsObject:searchBar.text]==NO) {
////            [self.historyArray addObject:topArray[i]];
//        
//        
//        
//    }else{
        [DataBaseManager insertSearchHistoryToDB:searchBar.text];
//    }
//
//    
//    }
   
    
    page = 1;
    [self loadDataWithKeyword:searchBar.text];
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([mySearchBar.text isEqualToString:@""]){
        
        return 44.0f;
        
    }else{
        return [AppointmentTableViewCell getCellHeight];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([mySearchBar.text isEqualToString:@""]){
        return self.historyArray.count;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.historyArray.count > 0 && self.dataArray.count == 0){
        return 49.0f;
    }else{
        return 0.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if(self.historyArray.count == 0 && self.dataArray.count == 0){
        return nil;
    }
    
    UIView *cell = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W , 49.0f)];
    cell.backgroundColor = [UIColor whiteColor];
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 5)];
    seperator.backgroundColor = RGBHex(0xF5F5F5);
    [cell addSubview:seperator];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 4.5, APP_W, 0.5)];
    line.backgroundColor = RGBHex(0xDBDBDB);
    [seperator addSubview:line];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 48.5, APP_W, 0.5)];
    line1.backgroundColor = RGBHex(0xDBDBDB);
    [cell addSubview:line1];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5.0, APP_W, 44.0f)];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"清空历史记录";
    UIButton *clearButton = [[UIButton alloc]initWithFrame:cell.frame];
    [clearButton addTarget:self action:@selector(clearHistoryData) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:label];
    [cell addSubview:clearButton];

    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([mySearchBar.text isEqualToString:@""]){
        
        NSString *CellIdentifier = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, APP_W, 0.5)];
        line.backgroundColor = RGBHex(0xDBDBDB);
        [cell addSubview:line];
//        cell.textLabel.text = self.historyArray[self.historyArray.count - indexPath.row - 1];
        cell.textLabel.text = [self.historyArray objectAtIndex:indexPath.row];

        
        return cell;
        
    }else{
      
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

//        [cell.confirmBtn setTitle:dic[@"statusName"] forState:UIControlStateNormal];
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        if (![reach isReachable]) {
            [Utils alertView:@"网络异常,请检查网络连接!"];
            return;
        }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([mySearchBar.text isEqualToString:@""]){
        
//        mySearchBar.text = self.historyArray[self.historyArray.count - indexPath.row - 1];
        mySearchBar.text = [self.historyArray objectAtIndex:indexPath.row];
        page = 1;
        [DataBaseManager insertSearchHistoryToDB:mySearchBar.text];

        [self loadDataWithKeyword:mySearchBar.text];
             
    }else{
        
        return;
    }
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
        NSDictionary *dic = self.dataArray[indexPath.row];
        [self deleteAppointment:dic[@"id"]];
        [self.dataArray removeObject:dic];
        [self.mainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - AppointmentTableViewCellDelegate
- (void)didConfirmBtnClick:(NSInteger)index{
    
    NSDictionary *dic = self.dataArray[index];
    
    [self confirmAppointment:dic[@"id"]];
}

- (void)didPhoneBtnClick:(NSString *)tel{
    
    [[[UIAlertView alloc]initWithTitle:tel message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil] show];
}
- (void)clearHistoryData{
    
    [DataBaseManager DeleteSearchHistoryData];
    
    [self loadHistoryData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [mySearchBar resignFirstResponder];
}

#pragma mark - HTTP请求列表数据
- (void)loadDataWithKeyword:(NSString *)keyWord{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"keyWord":keyWord,@"pageSize":@(1000)};
    
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    
    [HttpRequest getWebData:requestDic path:ShopAppointmentList method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                if(page == 1){
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }else{
                    [self.dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }
                if(self.dataArray.count > 0){
                    [self.mainTableView reloadData];
                }
            }
        }
        if(self.dataArray.count > 0){
            self.mainTableView.tableHeaderView = nil;
            [self removeNoDataView];
  
        }
        if(page == 1 && self.dataArray.count == 0){
            [self showNoDataViewWithString:@"无搜索结果" andImage:nil];
        }
        if(page != 1){
            
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

#pragma mark - HTTP确认预约
- (void)confirmAppointment:(NSString *)appoiStr{
    
    NSDictionary *dic = @{@"id":appoiStr};
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    [HttpRequest getWebData:requestDic path:ConfirmAppointment method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                [SVProgressHUD showSuccessWithStatus:@"确认成功!"];
                page = 1;
                 [self.mainTableView.footer resetNoMoreData];
                [self loadDataWithKeyword:mySearchBar.text];
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
                page = 1;
                [self.mainTableView.footer resetNoMoreData];
                [self loadDataWithKeyword:mySearchBar.text];
            }
        }
    } fail:^(NSString *msg) {
        
    }];
}



@end
