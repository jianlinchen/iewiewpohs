//
//  StorePictureController.h
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "BaseViewController.h"

@interface StorePictureController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end
