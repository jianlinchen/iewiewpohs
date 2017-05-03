//
//  ProductViewController.h
//  Wei_Shop
//
//  Created by dzr on 15/12/8.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ProductViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSString *ttt;
@property(strong,nonatomic)NSString *verStr;
@end
