//
//  MyViewController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableCell.h"
#import "FeedBackController.h"
#import "AbousCompanyController.h"
#import "SetUpController.h"
#import "DetailStoreController.h"
#import "Reachability.h"
@interface MyViewController (){
    NSMutableArray *arr1;
    NSMutableArray *arr2;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     self.myAccountLabel.text=[GlobarManager shareInstance].userConfig.account;
    self.beijImageview.userInteractionEnabled=YES;
     UITapGestureRecognizer* singleRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    
    [self.beijImageview addGestureRecognizer:singleRecognizer];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.tableFooterView=[[UIView alloc]init];
    self.myTableView.frame=CGRectMake(0, 120, KScreenWidth, KScreenHeight-120);
    self.myTableView.scrollEnabled=NO;

    self.myTableView.backgroundColor = RGBHex(0xf2f2f2);
    self.myTableView.tableFooterView = [[UIView alloc]init];
    self.myTableHeaderView.frame = CGRectMake(0, 0, APP_W, self.myTableHeaderView.frame.size.height);
    self.myTableView.tableHeaderView=self.myTableHeaderView;
    [self.myTableHeaderView addGestureRecognizer:singleRecognizer];
    

    arr1=[[NSMutableArray alloc]initWithObjects:@"商铺热线",@"意见反馈",@"关于微美薇",@"设置" ,nil];
    arr2=[[NSMutableArray alloc]initWithObjects:@"4008096866",@"",@"",@"" ,nil];
    
    
}

//处理单击操作
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    if (![reach isReachable]) {
        [Utils alertView:@"网络异常,请检查网络连接!"];
        return;
    }

    DetailStoreController *control = [[DetailStoreController alloc]initWithNibName:@"DetailStoreController" bundle:nil];

    [control setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:control animated:YES];
    
}
//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    
//    [self loadStoreDetail];
//    
//}

-(void)loadStoreDetail{
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId};
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:StoreDetail method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            NSDictionary * dic= [object objectForKey:@"result"];
            self.myAccountLabel.text=[dic objectForKey:@"mobilePhone"];
//            self.myImageView.imageURL=[dic objectForKey:@"shopImgLogo"];
          
            NSURL *url=[NSURL URLWithString:[dic objectForKey:@"shopImgLogo"]];
            [self.myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            self.myNameLabel.text=[dic objectForKey:@"shopName"];
         }
        }
    } fail:^(NSString *msg) {
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self loadStoreDetail];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark--menu_tabledatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MyTableCell";
    MyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //   table.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row==0) {
     [cell setAccessoryType:UITableViewCellAccessoryNone]; 
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text=[arr1 objectAtIndex:indexPath.row];
    cell.rightLabel.text=[arr2 objectAtIndex:indexPath.row];
   
    return cell ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
     
        UIActionSheet * myActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"4008096866" otherButtonTitles:nil, nil];
        [myActionSheet showInView:self.view];
        
    }else if (indexPath.row==1){
        FeedBackController *control = [[FeedBackController alloc]initWithNibName:@"FeedBackController" bundle:nil];
        control.title=@"意见反馈";
        [control setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:control animated:YES];

        
    }else if (indexPath.row==2){
        AbousCompanyController *control = [[AbousCompanyController alloc]initWithNibName:@"AbousCompanyController" bundle:nil];
        [control setHidesBottomBarWhenPushed:YES];
        control.title=@"关于微美薇";
        [self.navigationController pushViewController:control animated:YES];

        
    }else if (indexPath.row==3){
        SetUpController *control = [[SetUpController alloc]initWithNibName:@"SetUpController" bundle:nil];
        [control setHidesBottomBarWhenPushed:YES];
        control.title=@"设置";
//        [self.navigationController popToViewController:control animated:YES];
        [self.navigationController pushViewController:control animated:YES];

    }
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0){
        NSLog(@"asdasda");
        
         NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:4008096866"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
