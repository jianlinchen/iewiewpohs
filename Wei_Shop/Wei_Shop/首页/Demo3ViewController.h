//
//  Demo3ViewController.h
//  Wei_Shop
//
//  Created by dzr on 15/12/8.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLCustomSlideView.h"
#import "BaseViewController.h"
@interface Demo3ViewController : BaseViewController<DLCustomSlideViewDelegate>
@property (weak, nonatomic) IBOutlet DLCustomSlideView *slideView;

@property (strong, nonatomic) IBOutlet UIView *demo3NavView;
- (IBAction)demo3NacButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *demo3NavImageView;
@property (strong, nonatomic) IBOutlet UIView *serviceBottomView;
@end
