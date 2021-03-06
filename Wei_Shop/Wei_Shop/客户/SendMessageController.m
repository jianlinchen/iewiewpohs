//
//  SendMessageController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/5.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "SendMessageController.h"
#import "SendMessageTableCell.h"
#import "QunMessage.h"
#import "MassEmailController.h"
@interface SendMessageController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *chantArray;
    int p;
    UIButton *newButton;
    NSMutableArray * allArray;
     NSMutableString *memberString;
    NSMutableArray *dataArray;
}

@end

@implementation SendMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
     dataArray = [NSMutableArray new];
    p =1;

    
    allArray=[[NSMutableArray alloc]init];


    self.title = @"群发消息";

    chantArray=[[NSMutableArray alloc]init];
    newButton=[[UIButton alloc]initWithFrame:CGRectMake(0, KScreenHeight-100, KScreenWidth, 40)];
    newButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"2_nav"]];
    
     [newButton setTitle:@"新建群发" forState:UIControlStateNormal];
    [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(massEmaiAction) forControlEvents:UIControlEventTouchUpInside];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-100)];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self.view insertSubview:newButton aboveSubview:table];
//    table.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
//    UIView *view = [[UIView alloc]init];
//    table .tableFooterView = view;
    table.tableFooterView=[[UIView alloc]init];
    table.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
//        [table .footer resetNoMoreData];
        // 进入刷新状态后会自动调用这个block
        p ++;
        
        [self loadChant];
        
    }];
    
//    table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        p = 1;
//        [self loadChant];
//    }];
    table.header=self.header;
    [self.view addSubview:table];
//     [self loadChant];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [allArray removeAllObjects];
     p = 1;
    
    [self removeNoDataView2];
    [self loadChant];
    
    
}
- (void)loadNewData{
    [super loadNewData];
    p = 1;
    [self loadChant];
}
-(void)loadChant{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(p),@"pageSize":@(10)};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:QunList method:@"GET" success:^(id object) {
//        if(object && [object isKindOfClass:[NSDictionary class]]){
        
            if([[object objectForKey:@"success"] intValue] == 1){
                
                if(p == 1){
                    [dataArray removeAllObjects];
                    [dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }else{
                    [dataArray addObjectsFromArray:[object objectForKey:@"result"]];
                }
                if(dataArray.count > 0){
                    [table reloadData];
                }
            }
        
        if(p == 1 && dataArray.count == 0){
            [self showNoDataViewWithString2:@"您暂无发送的消息" andImage:nil];
            
        }else{
            [self removeNoDataView2];
        }

        if(p != 1){
            
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [table.footer endRefreshingWithNoMoreData];
            }else{
                [table.footer endRefreshing];
            }
        }else{
            [table.header endRefreshing];
        }
    } fail:^(NSString *msg) {
         [table.header endRefreshing];
         [table.footer endRefreshing];
    }];
    
}
#pragma mark--menu_tabledatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SendMessageTableCell";
    SendMessageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SendMessageTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    cell.topLabel.backgroundColor= RGBHex(0xDBDBDB);
    cell.huiColorLabel.backgroundColor= RGBHex(0xDBDBDB);
    NSDictionary *dic = dataArray[indexPath.row];
    cell.timeLabel.text=[dic objectForKey:@"sendTime"];
    memberString=[[NSMutableString alloc]init];
    
    NSMutableArray *array=[dic objectForKey:@"receivers"];
    if (array.count!=0) {
        for (int i=0; i<array.count; i++) {
            
            NSString *tt=[array[i] objectForKey:@"name"];
            [memberString appendString:[NSString stringWithFormat:@"%@,",tt]];
        }
        NSString  *str=[memberString  substringToIndex:(memberString.length -1)];
        cell.allNameLabel.text= [NSString stringWithFormat:@"收件人：%@",str];
    }

//    cell.allNameLabel.numberOfLines = 0;
//    
//    CGSize echocontentSize = [cell.allNameLabel.text boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
//    [cell.allNameLabel setFrame:CGRectMake(20, 40, KScreenWidth-40, echocontentSize.height)];
//    [cell.huiColorLabel setFrame:CGRectMake(15, 48+ echocontentSize.height, KScreenWidth-30, 1)];
    
    
    
    
    cell.contentLabel.numberOfLines = 0;
    cell.contentLabel.text=[dic objectForKey:@"msgContent"];
//    CGSize contentSize = [cell.contentLabel.text boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
//    
//     [cell.contentLabel setFrame:CGRectMake(20,  55+ echocontentSize.height, KScreenWidth-40, echocontentSize.height)];
//    
//    [cell.bottomLabel setFrame:CGRectMake(0,70+ echocontentSize.height+ contentSize.height, KScreenWidth, 4)];
//    

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return 200;
    NSDictionary *dic = dataArray[indexPath.row];
    NSMutableString *str=[[NSMutableString alloc]init];
    
    NSMutableArray *array=[dic objectForKey:@"receivers"];
    if (array.count!=0) {
        for (int i=0; i<array.count; i++) {
            
            NSString *tt=[array[i] objectForKey:@"name"];
            [str appendString:[NSString stringWithFormat:@"%@,",tt]];
        }
    }
    CGSize echocontentSize = [str boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;

     CGSize contentSize = [[dic objectForKey:@"msgContent"] boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    
    
    return echocontentSize.height +contentSize.height+100;
}

#pragma mark--menu_tabledelegate
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)massEmaiAction{
    if (self.oneOneArray.count!=0) {
        
        MassEmailController *qc = [[MassEmailController alloc]initWithNibName:@"MassEmailController" bundle:nil];
        qc.title=@"选择群发客户";
    [qc setHidesBottomBarWhenPushed:YES];
//    qc.oneArray=self.oneOneArray;
//    qc.twoArray=self.twoTwoArray;
    [self.navigationController pushViewController:qc animated:YES];
    }
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
