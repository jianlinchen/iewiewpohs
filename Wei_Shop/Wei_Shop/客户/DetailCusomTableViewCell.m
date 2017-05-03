//
//  DetailCusomTableViewCell.m
//  Wei_Shop
//
//  Created by dzr on 15/11/3.
//  Copyright (c) 2015年 cjl. All rights reserved.
//

#import "DetailCusomTableViewCell.h"

@implementation DetailCusomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    
}
-(void)setCell:(NSDictionary *)dic{
    
    
    
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10 , 13, KScreenWidth-20, 20)];
    timeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    timeLabel.text=[dic objectForKey:@"analysisTime"];
    
    UILabel *huiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, KScreenWidth-20, 1)];
    huiLabel.backgroundColor=[UIColor blackColor];
    
    [self addSubview:timeLabel];
    [self addSubview:huiLabel];
     NSMutableArray *ayy=[dic objectForKey:@"scoreList"];
    
    NSMutableArray *chenArray=[[NSMutableArray alloc]init];
    for (int a=0; a<ayy.count; a++) {
        [chenArray addObject:[ayy[a]objectForKey:@"score"]];
    }
    [chenArray addObject:[dic objectForKey:@"sumScore"]];
    
    
    NSLog(@"%@",chenArray);
  NSLog(@"%lu",(unsigned long)chenArray.count);
    
    
            CGFloat wid = ([UIScreen mainScreen].bounds.size.width - 280)/10;
            CGFloat bigX = 0.0f;
    
            for (int i=0; i<chenArray.count; i++) {
    
                bigX += wid;
              
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(bigX, 50, 30, 30)];
                label.textColor = [UIColor blackColor];
                

                label.textAlignment = NSTextAlignmentCenter;
                //      label.backgroundColor = RGBHex(0xf2f2f2);
                if(i == 8){
                    CGRect rect = label.frame;
                    rect.size.width = 40.0f;
    
                    label.frame = rect;
                    bigX += 40;
    
                    label.font = [UIFont systemFontOfSize:16.0f];
                   label.text=@"80";
    
                }else{
                    
                    label.font = [UIFont systemFontOfSize:12.0f];
                    bigX += 30;
                    
                }
                label.text=[NSString stringWithFormat:@"%@",chenArray[i]];
                [self addSubview:label];
                
                
            }

    
    
};
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
