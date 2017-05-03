//
//  AbousCompanyController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AbousCompanyController : BaseViewController<UIScrollViewDelegate>
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ImageLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LableLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LabelHightLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imTopLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imTopHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imTopWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneHeightLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imBotomHeightLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imBotomWidthLayout;

@end
