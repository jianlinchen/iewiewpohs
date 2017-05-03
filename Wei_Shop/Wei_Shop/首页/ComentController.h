//
//  ComentController.h
//  Wei_Shop
//
//  Created by dzr on 15/12/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ComentController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{
    
  }
@property (strong, nonatomic) IBOutlet UITableView *commentTableview;
@property (strong, nonatomic) IBOutlet UIView *feedBackView;
@property (strong, nonatomic) IBOutlet UIView *moveView;
@property (strong, nonatomic) IBOutlet UITextView *moveTextView;
- (IBAction)sendAction:(id)sender;

@end
