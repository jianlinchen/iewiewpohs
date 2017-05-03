//
//  Demo3ViewController.m
//  Wei_Shop
//
//  Created by dzr on 15/12/8.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "Demo3ViewController.h"
#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"
#import "ProductViewController.h"
#import "PageNViewController.h"
#import "Demo2ViewController.h"
@interface Demo3ViewController (){
    UIView *downView;
    BOOL down;
    UIButton *btn1;
    UIButton *btn2;
}
@end
@implementation Demo3ViewController{
    NSMutableArray *itemArray_;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationBar *bar= [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    bar.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:bar];
    self.serviceBottomView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideServiceBottomView)];
    [self.serviceBottomView addGestureRecognizer:tap];
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:6];
    DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    tabbar.tabItemNormalColor = [UIColor blackColor];
    tabbar.tabItemSelectedColor = [UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
    tabbar.tabItemNormalFontSize = 16.0f;
    tabbar.trackColor =[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
    itemArray_ = [NSMutableArray array];
    DLScrollTabbarItem *item1 = [DLScrollTabbarItem itemWithTitle:@"全部" width:50];
    [itemArray_ addObject:item1];
    DLScrollTabbarItem *item2 = [DLScrollTabbarItem itemWithTitle:@"待审核" width:75];
    [itemArray_ addObject:item2];
    DLScrollTabbarItem *item3 = [DLScrollTabbarItem itemWithTitle:@"审核通过" width:90];
    [itemArray_ addObject:item3];
    DLScrollTabbarItem *item4 = [DLScrollTabbarItem itemWithTitle:@"审核不通过" width:120];
    [itemArray_ addObject:item4];
    DLScrollTabbarItem *item5 = [DLScrollTabbarItem itemWithTitle:@"上架" width:50];
    [itemArray_ addObject:item5];
    DLScrollTabbarItem *item6 = [DLScrollTabbarItem itemWithTitle:@"下架" width:50];
    [itemArray_ addObject:item6];
    
    DLScrollTabbarItem *item7 = [DLScrollTabbarItem itemWithTitle:@"违规下架" width:90];
    [itemArray_ addObject:item7];
    tabbar.tabbarItems =[[NSArray alloc]initWithObjects:item1,item2,item3,item4,item5,item6,item7, nil];

    self.slideView.tabbar = tabbar;
    self.slideView.cache = cache;
    self.slideView.tabbarBottomSpacing = -1;
    self.slideView.baseViewController = self;
    [self.slideView setup];
    self.slideView.selectedIndex = 0;
    down=YES;
   self.demo3NavView.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-10, 0, 20, 15);
    
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    // Do any additional setup after loading the view.
}
-(void)Back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender{
    return itemArray_.count;
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index{
    PageNViewController *ctrl = [[PageNViewController alloc] init];
    ctrl.ttt= [NSString stringWithFormat:@"%ld", (long)index];
    return ctrl;
}

- (IBAction)demo3NacButton:(id)sender {
    if (down){
        self.demo3NavImageView.image=[UIImage imageNamed:@"1_top.png"];
        
        [downView removeFromSuperview];
        down=YES;
        downView=[[UIView alloc]initWithFrame:CGRectMake(100, 64, 120, 90)];
        downView.center=CGPointMake(KScreenWidth/2, 100);
        btn1=[[UIButton alloc]initWithFrame:CGRectMake(10, 5,100 , 40)];
        [btn1 setTitle:@"产品" forState:UIControlStateNormal];
        
        [btn1 addTarget:self action:@selector(product) forControlEvents:UIControlEventTouchUpInside ];

        btn2=[[UIButton alloc]initWithFrame:CGRectMake(10, 45,100 , 40)];
        [btn2 setTitle:@"服务" forState:UIControlStateNormal];
        
        [btn2 setTitleColor:[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(service) forControlEvents:UIControlEventTouchUpInside ];
        [downView addSubview:btn1];
        [downView addSubview:btn2];
        downView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self.navigationController.view addSubview:self.serviceBottomView];
        [self.navigationController.view addSubview:downView];
        down=NO;
    }else{
        self.demo3NavImageView.image=[UIImage imageNamed:@"1_down.png"];
        [downView removeFromSuperview];
          [self.demo3NavView removeFromSuperview];
        down=YES;
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    self.demo3NavImageView.image=[UIImage imageNamed:@"1_down.png"];
    [self.demo3NavView removeFromSuperview];
    [downView removeFromSuperview];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.demo3NavView.center=CGPointMake(KScreenWidth/2, 20);
    [self .navigationController.navigationBar addSubview:self.demo3NavView];
    
}

-(void)product{
    self.demo3NavImageView.image=[UIImage imageNamed:@"1_down.png"];
    down=YES;
      [self.serviceBottomView removeFromSuperview];
    [downView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:NO];

    
}
-(void)service{
    down=YES;
      [self.serviceBottomView removeFromSuperview];
    self.demo3NavImageView.image=[UIImage imageNamed:@"1_down.png"];

    [downView removeFromSuperview];
}
-(void)hideServiceBottomView{
    self.demo3NavImageView.image=[UIImage imageNamed:@"1_down.png"];
    [downView removeFromSuperview];
    [self.serviceBottomView removeFromSuperview];
    down=YES;
    
}

@end
