//
//  FeedBackController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface FeedBackController : BaseViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *feedTextView;

@property (strong, nonatomic) IBOutlet UILabel *fanLabel;
@end
