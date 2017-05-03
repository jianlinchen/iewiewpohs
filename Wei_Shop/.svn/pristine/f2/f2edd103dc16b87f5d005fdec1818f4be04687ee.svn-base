//
//  CustomView.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/10.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "CustomView.h"
#import "Constant.h"
#import "CustomTCell.h"
@implementation CustomView

+ (CustomView *)showCustomAlertViewAtView:(UIView *)view withTitleArr:(NSArray *)titleArr andImageArr:(NSArray *)imageArr andCallback:(disMissViewCallback)callBack{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:nil options:nil];
    CustomView *alertView = [nibView objectAtIndex:0];
//    alertView.backgroundColor=[UIColor redColor];
    alertView.dismissCallback = callBack;
    
    alertView.imgArr = imageArr;
    alertView.titArr = titleArr;
    
    CGRect rect = alertView.mainTableView.frame;
    rect.size.height = 44.0f * titleArr.count;
    alertView.mainTableView.frame = rect;
    [alertView.mainTableView reloadData];
    [view addSubview:alertView];
    return alertView;
}
#pragma mark - TableViewDelegate;
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.tableFooterView=[[UIView alloc]init];
    self.mainTableView.layer.cornerRadius=0.8;
    self.mainTableView.scrollEnabled=NO;
//    self.mainTableView.tableFooterView=[[UIView alloc]init];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.backView addGestureRecognizer:tap];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CustomTCell";
    CustomTCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomTCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.backgroundColor=[UIColor whiteColor];
       cell.customImageView.image= [UIImage imageNamed:self.imgArr[indexPath.row]];
       cell.customLabel.text=self.titArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.dismissCallback){
        self.dismissCallback(indexPath.row);
    }
    [self removeFromSuperview];
}

- (void)hideView{
    
    [self removeFromSuperview];
    
}

@end
