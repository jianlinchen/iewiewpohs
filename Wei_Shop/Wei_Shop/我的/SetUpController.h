//
//  SetUpController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface SetUpController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *setTableView;
}

@property (strong, nonatomic) IBOutlet UITableView *setUpTableView;
@end
