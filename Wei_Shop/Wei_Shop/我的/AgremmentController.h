//
//  AgremmentController.h
//  Wei_Shop
//
//  Created by dzr on 15/12/10.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AgremmentController : BaseViewController
@property (nonatomic, strong) NSString *URL;
@property (strong, nonatomic) IBOutlet UIWebView *agreeWebView;
@end
