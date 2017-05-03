//
//  FavourViewController.m
//  DLSlideViewDemo
//
//  Created by dzr on 15/12/7.
//  Copyright © 2015年 dongle. All rights reserved.
//

#import "FavourViewController.h"
#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"
#import "PageFavourController.h"

@interface FavourViewController (){
    
}

@end

@implementation FavourViewController{
    NSMutableArray *itemArray_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO; // 如果你使用了UITabBarController, 系统会自动调整scrollView的inset。加上这个如果出错的话。
    // Do any additional setup after loading the view from its nib.
    
    DLLRUCache *cache = [[DLLRUCache alloc] initWithCount:7];
    
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender{
    return itemArray_.count;
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index{
    PageFavourController *ctrl = [[PageFavourController alloc] init];
    ctrl.favStr= [NSString stringWithFormat:@"%ld", (long)index];
    return ctrl;
}
@end

