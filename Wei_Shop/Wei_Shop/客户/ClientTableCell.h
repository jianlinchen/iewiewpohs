//
//  ClientTableCell.h
//  Wei_Shop
//
//  Created by dzr on 15/10/30.
//  Copyright (c) 2015年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
@interface ClientTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *clientImageView;
@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientPhoneLabel;
-(void)getClient:(Client*)client;
@end
