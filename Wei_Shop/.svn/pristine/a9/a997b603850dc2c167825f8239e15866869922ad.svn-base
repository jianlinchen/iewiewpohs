//
//  BaseViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#import "BaseViewController.h"
#import "HttpRequest.h"

@interface BaseViewController (){
    
    UIView *noDataView;
    UIView *CJView;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
        
    {
        [[UINavigationBar appearance] setShadowImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake(320, 3)]];
    }

    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-10, 0, 20, 15);
    
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//     [self resetNoMoreData];
    
    
    NSMutableArray *imgArr = [NSMutableArray array];
    NSArray *refreshArr = @[[UIImage imageNamed:@"1_head"]];
    for(int i = 1;i <= 5;i ++){
        [imgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d_head",i]]];
    }
    
    // 设置普通状态的动画图片
    [self.header setImages:refreshArr forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.header setImages:refreshArr forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self.header setImages:imgArr forState:MJRefreshStateRefreshing];
    
    
    // 设置header
    // 隐藏时间
    self.header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    self.header.stateLabel.hidden = YES;
}

- (void)loadNewData{
    

}

- (void)setTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor whiteColor];
    label.text = title;
    
    self.navigationItem.titleView = label;
}

-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)internetEnable{
    
    
    return YES;
}

- (void)showNoDataViewWithString:(NSString *)str andImage:(UIImage *)image{
    
    noDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, APP_W, APP_H)];
    noDataView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, APP_W, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    if(str == nil){
        label.text = @"";
    }else{
        label.text = str;
    }
    label.font = [UIFont systemFontOfSize:15.0f];
    [noDataView addSubview:label];
    
    [self.view addSubview:noDataView];
    [self.view bringSubviewToFront:noDataView];
}

- (void)showNoDataViewWithString2:(NSString *)str andImage:(UIImage *)image{
    
    CJView = [[UIView alloc]initWithFrame:CGRectMake(0,140, APP_W, APP_H-300)];
    CJView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, APP_W, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    if(str == nil){
        label.text = @"";
    }else{
        label.text = str;
    }
    label.font = [UIFont systemFontOfSize:15.0f];
    [CJView addSubview:label];
    
    [self.view addSubview:CJView];
    [self.view bringSubviewToFront:CJView];
}
-(void)removeNoDataView2{
    [CJView removeFromSuperview];
}
- (void)removeNoDataView{
    
    [noDataView removeFromSuperview];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
}

@end
