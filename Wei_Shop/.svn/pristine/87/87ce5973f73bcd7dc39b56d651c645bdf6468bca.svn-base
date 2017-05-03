//
//  PageFavourController.m
//  Wei_Shop
//
//  Created by dzr on 15/12/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "PageFavourController.h"
#import "PageFavourCell.h"
#import "Favourable.h"
@interface PageFavourController (){
    NSMutableArray *arr0;
     NSMutableArray *arr1;
    NSString *dexString;
     NSInteger page;
}

@end

@implementation PageFavourController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arr0=[[NSMutableArray alloc]init];
    arr1=[[NSMutableArray alloc]init];

    self.favTableview.dataSource=self;
    self.favTableview.delegate=self;
    self.favTableview.tableFooterView=[[UIView alloc]init];
   self.favTableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    self.view.backgroundColor=[UIColor]
    
    self.favTableview.header = self.header;

    page=1;
    dexString=self.favStr;

    self.favTableview.separatorStyle = NO;
    [self loadCouble :dexString];
    self.favTableview.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        // [table .footer resetNoMoreData];
        // 进入刷新状态后会自动调用这个block
        page ++;
        
        [self loadCouble:dexString];
        
    }];
    

    // Do any additional setup after loading the view from its nib.
}
- (void)loadNewData{
    [super loadNewData];
    page=1;
    [self.favTableview.footer resetNoMoreData];
   [self loadCouble:dexString];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.favTableview reloadData];
    dexString=self.favStr;

    
}
-(void)loadCouble:(NSString *)dex{
    NSDictionary *dic=[[NSDictionary alloc]init];
    if ([dex isEqualToString:@"0"]) {
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"pageSize":@(10)};
    }else if ([dex isEqualToString:@"1"]){
        
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"status":@"2",@"pageSize":@(10)};
    }else if ([dex isEqualToString:@"2"]){
        
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"status":@"3",@"pageSize":@(10)};
    }else if ([dex isEqualToString:@"3"]){
        
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"status":@"4",@"pageSize":@(10)};
    }else if ([dex isEqualToString:@"4"]){
        
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"status":@"1",@"pageSize":@(10)};
    }else if ([dex isEqualToString:@"5"]){
        
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"status":@"0",@"pageSize":@(10)};
    }else{
        dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"status":@"5",@"pageSize":@(10)};
    }
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyTokenDic:dic];
    
   
    
    [HttpRequest getWebData:requestDic path:Seguecoupon method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]])
            
        {
            
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                if(page == 1){
                    [arr0 removeAllObjects];
                    [arr1 removeAllObjects];

                    [arr0 addObjectsFromArray:[object objectForKey:@"result"]];
                }else{
                    [arr0 addObjectsFromArray:[object objectForKey:@"result"]];
                }
                if(arr0.count > 0){
                    [self.favTableview reloadData];
                }
            }
        }
        
        for (int a = 0; a < arr0.count; a ++) {
            NSDictionary *dic = [arr0 objectAtIndex:a];
            Favourable *cVip = [[  Favourable alloc]init];
            [cVip getFavourable:dic];
            
            [arr1 addObject:cVip];
        }

     
        if(arr0.count > 0){
            self.favTableview.tableHeaderView = nil;
            [self removeNoDataView];
            
        }
        if(page == 1 && arr0.count == 0){
            [self showNoDataViewWithString:@"暂无相关内容" andImage:nil];
        }
        if(page != 1){
            
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [self.favTableview.footer endRefreshingWithNoMoreData];
            }else{
                [self.favTableview.footer endRefreshing];
            }
        }
        [self.favTableview.header endRefreshing];
    } fail:^(NSString *msg) {
        [self.favTableview.header endRefreshing];
        [self.favTableview.footer endRefreshing];
    }];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arr0.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return bgView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"PageFavourCell";
    PageFavourCell *cell = (PageFavourCell*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PageFavourCell" owner:self options:nil]lastObject];
    }
    cell.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    Favourable *fav=[[Favourable alloc]init];
    fav=[arr1 objectAtIndex:indexPath.row];
    [cell setFavourable:fav];
    return cell;
}


@end
