//
//  CustomView.h
//  Wei_Shop
//
//  Created by Geniune on 15/11/10.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^disMissViewCallback) (NSInteger obj);

@interface CustomView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (copy,nonatomic) disMissViewCallback dismissCallback;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic)NSArray *imgArr;
@property (strong, nonatomic)NSArray *titArr;

+ (CustomView *)showCustomAlertViewAtView:(UIView *)view withTitleArr:(NSArray *)titleArr andImageArr:(NSArray *)imageArr andCallback:(disMissViewCallback)callBack;

@end
