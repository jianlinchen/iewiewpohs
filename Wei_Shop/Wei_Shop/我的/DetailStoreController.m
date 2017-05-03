//
//  DetailStoreController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "DetailStoreController.h"
#import "DetailStoreCell.h"
#import "StorePictureController.h"
#import "UIImageView+WebCache.h"
@interface DetailStoreController (){
    NSMutableArray *stoneArray;//固定的数组
    NSDictionary * dicJson;
}
@end
@implementation DetailStoreController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.detailTableView.delegate=self;
    self.detailTableView.dataSource=self;
    self.detailTableView.frame=CGRectMake(0, 0, APP_W, KScreenHeight);
    self.detailTableView.tableHeaderView=self.detailView;
    self.detailTableView.tableFooterView=self.footerView;
    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    stoneArray=[[NSMutableArray alloc]initWithObjects:@"门店信息",@"地址",@"联系人",@"座机" ,@"手机" ,@"门店照片" ,nil];
//   self.detailTableView.tableFooterView=[[UIView alloc]init];

    self.labelll.backgroundColor = RGBHex(0xDBDBDB);
    [self loadStoreDetail];
    
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)loadStoreDetail{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:StoreDetail method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            dicJson=[[NSDictionary alloc]init];
            dicJson= [object objectForKey:@"result"];
            
            NSURL *url=[NSURL URLWithString:[dicJson objectForKey:@"shopImgLogo"]];
            
           [self.shopImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            self.nameLabel.text=[dicJson objectForKey:@"shopName"];
           
          }
            [self.detailTableView reloadData];
        }
    } fail:^(NSString *msg) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--menu_tabledatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return stoneArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return [DetailStoreCell getCellHeight] + 30.0f;
    }else{
        return [DetailStoreCell getCellHeight];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"DetailStoreCell";
    DetailStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailStoreCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //   table.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(indexPath.row ==5){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
        
    cell.detailLeftLabel.text=[stoneArray objectAtIndex:indexPath.row];
//    NSLog(@"+++++++++++++++++%@",dicJson);
    if (indexPath.row==0) {
        cell.detailRightLabel.text=@"";
        
    }else if (indexPath.row==1){
        cell.detailRightLabel.text=[NSString stringWithFormat:@"%@",[dicJson objectForKey:@"shopAddr"]];

        
    }else if (indexPath.row==2){
        cell.detailRightLabel.text=[NSString stringWithFormat:@"%@",[dicJson objectForKey:@"linkman"]];

    }else if (indexPath.row==3){
        cell.detailRightLabel.text=[NSString stringWithFormat:@"%@",[dicJson objectForKey:@"fixedPhone"]];

    }else if (indexPath.row==4){
        cell.detailRightLabel.text=[NSString stringWithFormat:@"%@",[dicJson objectForKey:@"mobilePhone"]];
        
    }else{
        cell.detailRightLabel.text=@"";

    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, cell.frame.size.height - 0.5, APP_W - 20, 0.5)];
    line.backgroundColor = RGBHex(0x333333);
    [cell addSubview:line];
    
    if(indexPath.row == 0){
        line.frame = CGRectMake(10, [DetailStoreCell getCellHeight] + 29.5f, APP_W - 20, 0.5);
        line.backgroundColor = RGBHex(0x333333);
        cell.detailLeftLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    }else{
        line.backgroundColor = RGBHex(0xdbdbdb);
        cell.detailLeftLabel.textColor = [UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
        if(indexPath.row == 5){
            [line removeFromSuperview];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==5) {
        
  
    StorePictureController *control = [[StorePictureController alloc]initWithNibName:@"StorePictureController" bundle:nil];
    [control setHidesBottomBarWhenPushed:YES];
    control.title=@"门店照片";
//  control.title=@"商家风采";
    [self.navigationController pushViewController:control animated:YES];
        
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 300;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,KScreenWidth , 300)];
//    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, KScreenWidth-30, 300)];
//    titleLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.font = [UIFont systemFontOfSize:14];
//   
//    titleLabel.text = @"手机端不支持信息修改，请登录PC端维护信息";
//    [bgView addSubview:titleLabel];
//    return titleLabel;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
