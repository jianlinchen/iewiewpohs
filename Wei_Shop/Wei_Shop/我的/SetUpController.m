//
//  SetUpController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "SetUpController.h"
#import "SetUpTableCell.h"
#import "RevisePssWordController.h"
#import "LoginViewController.h"
#import "Reachability.h"
@interface SetUpController (){
    NSMutableArray *arr1;
    NSString *strban;
    NSString *urlurl;
    NSString *uu;//获取当前版本

    NSString *forcedString;//是否强制更新
}

@end

@implementation SetUpController

- (void)viewDidLoad {
    [super viewDidLoad];
//     uu = [NSString stringWithFormat:@"V%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    uu = [NSString stringWithFormat:@"V%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    
     arr1=[[NSMutableArray alloc]initWithObjects:@"密码修改",nil];
    // Do any additional setup after loading the view from its nib.
    self.setUpTableView.delegate=self;
    self.setUpTableView.dataSource=self;
    self.setUpTableView.backgroundColor = RGBHex(0xf2f2f2);
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, APP_W, 80)];
    
    view.backgroundColor=[UIColor clearColor];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 15, APP_W - 20, 50)];
    button.backgroundColor=[UIColor whiteColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3.5f;
    button.layer.borderColor = RGBHex(0xdbdbdb).CGColor;
    button.layer.borderWidth = 0.5f;
    
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:68.0f/255.0f green:68.0f/255.0f blue:68.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    [self.setUpTableView setTableFooterView:view];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self versonUpdate];//调用系统更新
}

-(void)versonUpdate{
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             
                             nil];
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyDic:dic] path:CheckVersion method:@"GET" success:^(id object) {
        
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
            NSDictionary * dic= [object objectForKey:@"result"];
            if (![dic isKindOfClass:[NSNull class]]) {
                  NSString *qq=dic [@"versionNO"];
            strban=[NSString stringWithFormat:@"V%@",qq];
            urlurl=dic[@"versionURL"];
            forcedString=[NSString stringWithFormat:@"%@", dic[@"isForced"]];
            }
          
            }
             [self.setUpTableView reloadData];
            

        }
    } fail:^(NSString *msg) {
        
    }];
    
}

#pragma mark--menu_tabledatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SetUpTableCell";
    SetUpTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SetUpTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //   table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    if (indexPath.row==0) {
    cell.leftLabel.text=@"密码修改";
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3_go.png"]];
     cell.rightlabel.text=@"";
//    }else{
//        
//        if ([uu isEqualToString:strban]) {
//            
//            cell.leftLabel.text=@"已是最新版本";
//            cell.rightlabel.hidden=NO;
//            cell.rightlabel.text=[NSString stringWithFormat:@"当前版本为%@",uu];
//            cell.leftLabel.textColor=[UIColor redColor];
//            
//         }else{
//           cell.rightlabel.hidden=NO;
//            cell.leftLabel.text=[NSString stringWithFormat:@"当前版本为%@",uu];
//            cell.rightlabel.text=@"更新到最新版本";
//            cell.rightlabel.textColor=[UIColor redColor];
//        }

        
//    }
    
    
    
    
//    cell.leftLabel.text=[arr1 objectAtIndex:indexPath.row];
//    if (indexPath.row==0) {
//        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3_go.png"]];
//        cell.rightlabel.text=@"";
//    }else{
//        
//        cell.rightlabel.text=@"v0.1";
//    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        RevisePssWordController *control = [[RevisePssWordController alloc]initWithNibName:@"RevisePssWordController" bundle:nil];
        control.title=@"密码修改";
        [control setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:control animated:YES];
    }else{
        
        if (![uu isEqual:strban]) {
            UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定下载？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert1 show];
            
        }else{
            return;
        }


    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    if (buttonIndex ==1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlurl]];
//        NSLog(@"!2");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)quit{

//    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:Password];
    NSUserDefaults *userDefaut=[[NSUserDefaults alloc]init];
    [userDefaut removeObjectForKey:@"Account"];
    [userDefaut removeObjectForKey:@"Password"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [DataBaseManager DeleteSearchClientData];
    [DataBaseManager DeleteSearchHistoryData];

    GLOBARMANAGER.userConfig.shopId=nil;
    GLOBARMANAGER.userConfig.shopName=nil;
     GLOBARMANAGER.userConfig.account=nil;
     GLOBARMANAGER.userConfig.cityId=nil;
    GLOBARMANAGER.userConfig.merchantId=nil;
    GLOBARMANAGER.userConfig.mobile=nil;
    GLOBARMANAGER.userConfig.shopImg=nil;
    GLOBARMANAGER.userConfig.icon=nil;
//    LoginViewController *control = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginFail" object:nil];
   [self.navigationController popToRootViewControllerAnimated:NO];

//    [control setHidesBottomBarWhenPushed:YES];
//    control.title=@"关于微美薇";
////    [self.navigationController popToViewController:control animated:YES];
//    [self.navigationController pushViewController:control animated:YES];

    
    
   
    
//    [self.navigationController popToRootViewControllerAnimated:NO];
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
