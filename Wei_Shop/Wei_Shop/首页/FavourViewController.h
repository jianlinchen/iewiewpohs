//
//  FavourViewController.h
//  DLSlideViewDemo
//
//  Created by dzr on 15/12/7.
//  Copyright © 2015年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLCustomSlideView.h"
#import "BaseViewController.h"
@interface FavourViewController : BaseViewController<DLCustomSlideViewDelegate>
@property (weak, nonatomic) IBOutlet DLCustomSlideView *slideView;
@end
