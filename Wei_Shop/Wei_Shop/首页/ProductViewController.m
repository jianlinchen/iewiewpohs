//
//  ProductViewController.m
//  Wei_Shop
//
//  Created by dzr on 15/12/8.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "ProductViewController.h"
#import "Product.h"
#import "PageTableViewCell.h"
@interface ProductViewController (){
    NSMutableArray *arr0;
//    NSMutableArray *arr1;
    NSString *dexString;
    NSInteger page;

    UITableView *table;
}

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    table=[[UITableView alloc]init];
    table.frame=CGRectMake(0,0, KScreenWidth, KScreenHeight-100);
    [self.view addSubview:table];
    arr0=[[NSMutableArray alloc]init];
//    arr1=[[NSMutableArray alloc]init];
    table.separatorStyle=NO;
    table.dataSource=self;
    table.delegate=self;
    table.tableFooterView=[[UIView alloc]init];
    table.backgroundColor=[UIColor groupTableViewBackgroundColor];
    table.header = self.header;
    
    page=1;
    dexString=self.ttt;
    
    //    self.TesttableView.separatorStyle = NO;
    [self loadCouble :dexString];
   table.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
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
    [table.footer resetNoMoreData];
    [self loadCouble:dexString];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //  [self.favTableview reloadData];
    dexString=self.ttt;
    
    
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
    
    NSMutableDictionary *requestDic = [GLOBARMANAGER AppKeyDic:dic];
    
    [HttpRequest getWebData:requestDic path:SegueProduct method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]])
            
        {
            if([[object objectForKey:@"success"] intValue] == 1){
                NSMutableArray *arr=[object objectForKey:@"result"];
                
                if(page == 1){
                    [arr0 removeAllObjects];
                  
                }
                
            for (int a = 0; a < arr.count; a ++) {
            NSDictionary *dict = [arr objectAtIndex:a];
            Product *cVip = [[Product alloc]init];
            [cVip getProduct:dict];
            
            [arr0 addObject:cVip];
        }

                if(arr0.count > 0){
                    [table reloadData];
                }
            }
        }
        
               
        
        if(arr0.count > 0){
            table.tableHeaderView = nil;
            [self removeNoDataView];
            
        }
        if(page == 1 && arr0.count == 0){
            [self showNoDataViewWithString:@"暂无相关内容" andImage:nil];
        }
        if(page != 1){
            
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [table.footer endRefreshingWithNoMoreData];
            }else{
                [table.footer endRefreshing];
            }
        }
        [table.header endRefreshing];
    } fail:^(NSString *msg) {
        [table.header endRefreshing];
        [table.footer endRefreshing];
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
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"PageTableViewCell";
    PageTableViewCell *cell = (PageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PageTableViewCell" owner:self options:nil]lastObject];
    }
    // cell.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Product *product=[[Product alloc]init];
    product=[arr0 objectAtIndex:indexPath.row];
     
//    cell.allImageView.imageURL=product.imgUrl;
    NSURL *url=[NSURL URLWithString:product.imgUrl];
    [cell.allImageView setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    cell.allPriceLabel.text=[NSString stringWithFormat:@"￥ %@",product.price];
    cell.allTitleLabel.text=product.productName;
    if ([product.statusName isEqualToString:@"审核通过"]) {
        cell.allExameLabel.textColor=[UIColor colorWithRed:0x3b/255.0 green:0xa3/255.0 blue:0x3b/255.0 alpha:1.0];

//    self.examzeImageView.image=[UIImage imageNamed:@"1_blueFav.png"];
    }else if ([product.statusName isEqualToString:@"审核不通过"]||[product.statusName isEqualToString:@"违规下架"]||[product.statusName isEqualToString:@"下架"]){
         cell.allExameLabel.textColor=[UIColor colorWithRed:0xff/255.0 green:0x62/255.0 blue:0x56/255.0 alpha:1.0];
    }else{
         cell.allExameLabel.textColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
    }

    cell.allExameLabel.text=product.statusName;
    
    return cell;
}

@end
