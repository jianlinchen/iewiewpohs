//
//  AbousCompanyController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "AbousCompanyController.h"

@interface AbousCompanyController ()

@end

@implementation AbousCompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (KScreenHeight >568) {
        self.imTopLayout.constant=50;
        self.imTopWidth.constant=95;
        self.imTopHeight.constant=105;
        self.ImageLayout.constant = 10;
        self.LableLayout.constant = 50;
         self.LabelHightLayout.constant = 150;
        self.contentLabel.font = [UIFont systemFontOfSize:13];
        self.oneHeightLayout.constant=20;
        self.imBotomHeightLayout.constant=180;
        self.imBotomWidthLayout.constant=180;
                
    }else{
    }
//    UIScrollView  *scrView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
//    UIImageView*topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];//导航条
//    topImageView.image=[UIImage imageNamed:@"2_nav@2x.png"];
//    [scrView addSubview:topImageView];
//    
//    // log标志图
//    UIImageView *logImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    logImageView.center=CGPointMake(KScreenWidth/2, 65);
//    logImageView.image=[UIImage imageNamed:@"aboutEnd.png"];
//    [scrView addSubview:logImageView];
//
//    
//    
//    UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 270, 91)];
//    contentLabel.center=CGPointMake(KScreenWidth/2, 150);
////    contentLabel.lineBreakMode=0;
//    [contentLabel setNumberOfLines:5];
//    
//    
//    contentLabel.text=@"   深圳微美薇健康美容科技有限公司成立于2014年9月，坐落于特区中的特区--深圳前海，是一家以科技为驱动力的互联网公司，公司借助全新云计算皮肤健康监测与分析系统，打造个性化美容B2B+020服务平台，形成微美薇独有美业大数据解决方案，致力于让大众随时随地都能享受量身定制的个性化美丽服务。";
//    
//    [scrView addSubview:contentLabel];
//    
//    
//    
//    
//    
//    //扫描图像
//    UIImageView *scanImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
//    
//    scanImageView.center=CGPointMake(KScreenWidth/2, 280);
//    scanImageView.image=[UIImage imageNamed:@"wmw_download_ewm.png"];
//    
//    
//    //下边的灰色view
//    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,60 )];
//    bottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    
//    UILabel  *bottomLabel1=[[UILabel alloc]initWithFrame:CGRectMake(0,0, KScreenWidth-40, 20)];
//    bottomLabel1.center=CGPointMake(KScreenWidth/2, 10);
//    bottomLabel1.text=@"加盟热线：400-089-6866";
//     bottomLabel1.textAlignment= NSTextAlignmentCenter;
//    
//    UILabel *bottomLabel2=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth-40, 25)];
//    bottomLabel2.center=CGPointMake(KScreenWidth/2, 30);
//    bottomLabel2.text=@"深圳微美薇健康美容科技有限公司";
//    bottomLabel2.textAlignment= NSTextAlignmentCenter;
//    
//    
//    [bottomView addSubview:bottomLabel1];
//    [bottomView addSubview:bottomLabel2];
//    
//    
//    
//    [scrView addSubview:scanImageView];
    
//     [self.contentLabe]
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
