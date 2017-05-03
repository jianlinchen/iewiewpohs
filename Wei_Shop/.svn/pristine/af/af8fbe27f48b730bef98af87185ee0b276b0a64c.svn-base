//
//  StorePictureController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/7.
//  Copyright © 2015年 cjl. All rights reserved.
//
static NSString *kcellIdentifier = @"PictureCollectionCell";
#import "StorePictureController.h"
#import "PictureCollectionCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface StorePictureController (){
    NSMutableArray *pictureArray;//全体数组
 
    
}

@end

@implementation StorePictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    pictureArray=[[NSMutableArray alloc]init];
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
//    self.myCollectionView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight+50);
    // Do any additional setup after loading the view from its nib.
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"PictureCollectionCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self pictureData];
}
-(void)pictureData{
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:PictureStore method:@"GET" success:^(id object) {
        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
           pictureArray=[object objectForKey:@"result"];
            
           }
            [self.myCollectionView reloadData];
        }
    } fail:^(NSString *msg) {
        
    }];
    
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    PictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
 
    if (pictureArray.count!=0) {
        
        NSURL *url=[NSURL URLWithString:[[pictureArray objectAtIndex:indexPath.row] objectForKey:@"imgUrl"]];
        
         cell.collectonImageView.tag=[indexPath row];
        cell.collectonImageView.userInteractionEnabled = YES;
        [cell.collectonImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        cell.collectonImageView.clipsToBounds = YES;
        cell.collectonImageView.contentMode = UIViewContentModeScaleAspectFill;

         [cell.collectonImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        
        cell.collectionLabel.text=[[pictureArray objectAtIndex:indexPath.row] objectForKey:@"imgName"];
        
    }
    return cell;
    
}
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSInteger count = pictureArray.count;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [pictureArray[i][@"imgUrl"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KScreenWidth/2-10, KScreenWidth/2+40);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return pictureArray.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
