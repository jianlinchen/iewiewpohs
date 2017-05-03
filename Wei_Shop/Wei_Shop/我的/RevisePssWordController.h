//
//  RevisePssWordController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "BaseViewController.h"

@interface RevisePssWordController : BaseViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *oneTextField;
@property (strong, nonatomic) IBOutlet UITextField *twoTextField;
@property (strong, nonatomic) IBOutlet UITextField *threeTextField;

- (IBAction)cirPassWordAction:(id)sender;
@end
