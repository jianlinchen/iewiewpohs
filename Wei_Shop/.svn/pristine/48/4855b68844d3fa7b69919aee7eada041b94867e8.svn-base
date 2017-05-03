//
//  TwoDetailTableCell.m
//  Wei_Shop
//
//  Created by dzr on 15/11/13.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "TwoDetailTableCell.h"
#import "Constant.h"
@implementation TwoDetailTableCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    NSArray *ayy=[[NSArray alloc]initWithObjects:@"保湿补水",@"肤色净白",@"粉刺去除",@"油脂控制",@"斑点淡化",@"敏感修复",@"毛孔细致",@"细纹抚平",@"总分", nil];
    
    UILabel *huilabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 38, KScreenWidth, 1)];
    huilabel.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:huilabel];
    
    CGFloat wid = ([UIScreen mainScreen].bounds.size.width - 280)/10;
    CGFloat wid1 = ([UIScreen mainScreen].bounds.size.width - 130)/10;

    CGFloat bigX = 0.0f;
    CGFloat bigX1 = 0.0f;
    for (int i=0; i<ayy.count; i++) {
      
        bigX += wid;
        bigX1 += wid1;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(bigX, 6, 30, 30)];
        label.textColor = [UIColor lightGrayColor];
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(bigX1, 38, 1, 5)];
//        lab1.backgroundColor=RGBHex(0xf2f2f2);;
        lab1.backgroundColor=[UIColor lightGrayColor];
        
        label.textAlignment = NSTextAlignmentCenter;
//      label.backgroundColor = RGBHex(0xf2f2f2);
        if(i == 8){
            CGRect rect = label.frame;
            rect.size.width = 40.0f;
            
            label.frame = rect;
            bigX += 40;
            
            label.font = [UIFont systemFontOfSize:14.0f];
            
            //
            CGRect rect1 = lab1.frame;
            rect1.size.width = 1.0f;
//            rect1.size.width = 40.0f;

            lab1.frame = rect1;
            bigX1 += 40;

            
            
        }else{
            label.font = [UIFont systemFontOfSize:11.0f];
            bigX += 30;
            bigX1 += 15;
        }
         label.text=[NSString stringWithFormat:@"%@",ayy[i]];
        label.numberOfLines = 2;
        
        [self addSubview:label];
        [self addSubview:lab1];
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
