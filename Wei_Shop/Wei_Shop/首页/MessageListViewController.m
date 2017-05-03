//
//  MessageListViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/6.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageTableViewCell.h"
#import "CallViewController.h"
#import "MessageBox.h"

@interface MessageListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSInteger pageIndex;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息盒子";
    self.dataArray = [[NSMutableArray alloc]init];
    
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView.header = self.header;
   

}
- (void)loadNewData{
    [super loadNewData];
    
    pageIndex = 1;
    [self loadData];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    NSLog(@"dataArray现在有%lu条数据",(unsigned long)self.dataArray.count);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (newMessage:) name:@"UnreadMessage" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UnreadMessage" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UnreadMessage" object:nil];
}

- (void)newMessage:(id)sender{
 
    [GLOBARMANAGER getunReadMessageListCompleted:^(NSArray *array) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        [self.mainTableView reloadData];
    }];

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MessageTableViewCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
  
    [cell setCell:dic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld行",(long)indexPath.row);
    if(indexPath.row >= self.dataArray.count){
        return;
    }

    NSDictionary *dic = self.dataArray[indexPath.row];
    
    
    [DataBaseManager deleteUnReadList:dic[@"senderId"] Completed:^(id obj) {
        [DataBaseManager insertUnReadListToDB:StrFromObj(dic[@"senderId"]) senderName:StrFromObj(dic[@"senderName"]) senderIcon:StrFromObj(dic[@"senderIcon"]) content:StrFromObj(dic[@"lastContent"]) lastSendTime:StrFromObj(dic[@"lastSendTime"])];
    }];
   [GLOBARMANAGER.unreadMessageList removeObject:dic];

    CallViewController *VC = [[CallViewController alloc]initWithNibName:@"CallViewController" bundle:nil];
    VC.userDic = dic;
    VC.userid = dic[@"senderId"];
    VC.userName = dic[@"senderName"];
    
    if(dic[@"senderIcon"] && ![dic[@"senderIcon"] isEqualToString:@""]){
        GLOBARMANAGER.userImg = dic[@"senderIcon"];
    }else{
        GLOBARMANAGER.userImg = @"";
    }
    
    GLOBARMANAGER.unReadCount -= [dic[@"messageCount"] integerValue];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)loadData{
    
   [self removeNoDataView];
    [GLOBARMANAGER getunReadMessageListCompleted:^(NSArray *array) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        if(self.dataArray.count > 0){
           [self.mainTableView reloadData];
        }else{
            [self showNoDataViewWithString:@"没有数据" andImage:nil];
        }
        [self.mainTableView.header endRefreshing];
    }];
}

@end
