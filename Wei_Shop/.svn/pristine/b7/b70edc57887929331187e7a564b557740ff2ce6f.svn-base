//
//  AddClientController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//
////扫描用户端授权码，获取用户信息add by cjl
//#define ScanCustomer @"/customer/relation/auth/info"
//
//
//
////添加账号add by cjl
//#define AddCustomer @"/customer/relation/auth/add"

#import "AddClientController.h"
#import "CustomViewController.h"
#import "CustomViewController.h"
@interface AddClientController (){
    NSString *userId;
    NSString *genStr;
    NSString *age;
    NSString *cityStr;

}
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddClientController
@synthesize dic;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.clientPhoneBtn.layer.masksToBounds = YES;
    self.clientPhoneBtn.layer.cornerRadius = 12.5f;
    self.clientPhoneBtn.layer.borderWidth = 0.5f;
    self.clientPhoneBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.clientPhoneBtn setTitle:[dic objectForKey:@"mobile"] forState:UIControlStateNormal];
    [self.clientPhoneBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
//    [button0 addTarget:self action:@selector(button0:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.cornerRadius = 3.5f;
   // 圆形头像
    self.headerImageView.layer.cornerRadius = self.headerImageView.frame.size.width /2;
    
    self.headerImageView.clipsToBounds = YES;
    
    self.headerImageView.layer.borderWidth = 0.0f;

    [self scanAction];
    [self loadNaviGationItem];
}
-(void)loadNaviGationItem{
    
    self.navigationItem.hidesBackButton =YES;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(selectLeftAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)selectLeftAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[CustomViewController  class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
}

-(void)scanAction{

   
    userId=[dic objectForKey:@"userId"];
//    self.headerImageView.imageURL=[NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]];
    
    NSURL *url=[NSURL URLWithString:[dic objectForKey:@"icon"]];
     [ self.headerImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4_cTouXiang"]];
    
    self.headerImageView.layer.cornerRadius = self.headerImageView.frame.size.width /2;
                
    self.headerImageView.clipsToBounds = YES;
                
    self.headerImageView.layer.borderWidth = 0.0f;

                
    self.clientNameLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]];
    
    if ([dic objectForKey:@"gender"] == [NSNull null] ) {
        genStr = @"";
    }else{
        genStr =[dic objectForKey:@"gender"];
    }

    //年龄
    
    
    if ([dic objectForKey:@"age"] == [NSNull null] ) {
        age= @"";
    }else{
        age = [NSString stringWithFormat:@"%@",[dic objectForKey:@"age"]];
    }
    //
    
    //地址
    if ([dic objectForKey:@"cityName"] == [NSNull null] ) {
        cityStr = @"";
    }else{
        cityStr =[dic objectForKey:@"cityName"];
    }
//    cityStr=@"";
     [self gend:genStr addAge:age addCity:cityStr];
    
}
-(void)gend:(NSString *)str1   addAge:(NSString * )str2 addCity:(NSString *)str3{

    if(str1.length!=0&&str2.length!=0&str3.length!=0){
        
       
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
         self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;
        
        
        NSString *yrStr=[[NSString alloc]init];
        if ([str1 isEqual:@"M"]) {
            
            yrStr=@"男";
        }else{
            yrStr=@"女";
        }
        
        
    
        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 178);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@ | %@岁 | %@",yrStr,str2,str3];
        [self.view addSubview:allLabel];
        
    }
    //有两个值
    else if (str1.length==0&&str2.length!=0&str3.length!=0){
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
        self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;

        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 165);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@岁 | %@",str2,str3];
        [self.view addSubview:allLabel];
        
        
    }else if (str1.length!=0&&str2.length==0&str3.length!=0){
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
        self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;

        
        NSString *yrStr=[[NSString alloc]init];
        if ([str1 isEqual:@"M"]) {
            
            yrStr=@"男";
        }else{
            yrStr=@"女";
        }
        
        
        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 165);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@ | %@",yrStr,str3];
        [self.view addSubview:allLabel];
        
        
        
    }else if (str1.length!=0&&str2.length!=0&str3.length==0){
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
        self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;

        NSString *yrStr=[[NSString alloc]init];
        if ([str1 isEqual:@"M"]) {
            
            yrStr=@"男";
        }else{
            yrStr=@"女";
        }
        
        
        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 165);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@ | %@岁",yrStr,str2];
        [self.view addSubview:allLabel];
        
        
        //只有一个值
        
    }else if (str1.length!=0&&str2.length==0&str3.length==0 ){
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
        self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;

        
        NSString *yrStr=[[NSString alloc]init];
        if ([str1 isEqual:@"M"]) {
            
            yrStr=@"男";
        }else{
            yrStr=@"女";
        }
        
        
        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 165);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@",yrStr];
        [self.view addSubview:allLabel];
        
        
        
    }else if (str1.length==0&&str2.length!=0&str3.length==0 ){
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
        self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;

        
        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 165);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@岁",str2];
        [self.view addSubview:allLabel];
        
        
    }else if (str1.length==0&&str2.length==0&str3.length!=0 ){
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        
        self.clientGenderLabel.hidden=YES;
        self.clientYearLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;

       
        
        UILabel *allLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , KScreenWidth-70, 25)];
        allLabel.center=CGPointMake(KScreenWidth/2, 165);
        allLabel.textColor=[UIColor whiteColor];
        allLabel.textAlignment= NSTextAlignmentCenter;
        allLabel.text=[NSString stringWithFormat:@"%@",str3];
        [self.view addSubview:allLabel];
        
    }else{
        self.clientGenderLabel.hidden=YES;
        self.deatailLeftLabel.hidden=YES;
        self.detailRightLabel.hidden=YES;
        self.clientGenderLabel.hidden=YES;
        self.clientCityLabel.hidden=YES;
    }
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addClientAction:(id)sender {

    NSDictionary *mydic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"authCode":self.str,@"userId":userId};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:mydic] path:AddCustomer method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
//            NSDictionary * dic= [object objectForKey:@"result"];
            [Utils alertView:@"添加成功"];
            
            
     [[NSNotificationCenter   defaultCenter] postNotificationName:@"back"object:self];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
           

//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[CustomViewController  class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//                }
//            }

        } else{
            [SVProgressHUD showErrorWithStatus:object[@"error"][@"extDesc"]];
        }
            
        }
    } fail:^(NSString *msg) {
        
    }];
}

- (void)callPhone:(id)sender{
    
    NSString *tel = self.clientPhoneBtn.titleLabel.text;
    
    tel = [tel  stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",tel]]];
}

@end
