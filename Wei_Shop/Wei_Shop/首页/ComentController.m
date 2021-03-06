//
//  ComentController.m
//  Wei_Shop
//
//  Created by dzr on 15/12/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "ComentController.h"
#import "ComentTableCell.h"
#import "Coment.h"
#import "KeyboardManager.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface ComentController (){
    NSMutableArray *commentArray;
    NSInteger page;
    BOOL _wasKeyboardManagerEnabled;
    UIButton *tagButton;
//    NSMutableArray *dataArray;
    UIButton *buttonIndex;
}
@end
@implementation ComentController

- (void)viewDidLoad {
    [super viewDidLoad];
    tagButton=[[UIButton alloc]init];
    
//    buttonIndex=[[UIButton alloc]init];
    // Do any additional setup after loading the view from its nib.
//    dataArray=[[NSMutableArray alloc]init];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
    view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.commentTableview.tableHeaderView=view1;
    self.moveTextView.delegate=self;
    self.feedBackView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight);
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.feedBackView addGestureRecognizer:tap];
    commentArray=[[NSMutableArray alloc]init];
    
     page=1;
//    self.commentTableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.commentTableview.delegate=self;
    self.commentTableview.dataSource=self;
    
    self.commentTableview.header=self.header;//下拉刷新的步骤
    self.commentTableview.tableFooterView=[[UIView alloc]init];
    self.commentTableview.footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        //        [table .footer resetNoMoreData];
        // 进入刷新状态后会自动调用这个block
        page ++;
        
        [self HttpCommentData];
        
    }];

    [self HttpCommentData];
}
- (void)loadNewData{
    [super loadNewData];
      [self.commentTableview.footer resetNoMoreData];
     page = 1;
    [self HttpCommentData];
}
-(void)HttpCommentData{
  
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"pageSize":@(10)};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:FeeedCoustomerList method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
        
        if([[object objectForKey:@"success"] intValue] == 1){
            
            NSMutableArray *arr=[object objectForKey:@"result"];
            
            if(page == 1){
                [commentArray removeAllObjects];
                
            }

             for (int a = 0; a < arr.count; a ++) {
            NSDictionary *dict = [arr objectAtIndex:a];
            Coment *cVip = [[Coment alloc]init];
            [cVip getComent:dict];
            [commentArray addObject:cVip];
         }
    }
            if(commentArray.count > 0){
                [self.commentTableview reloadData];
            }
        }
               if(page == 1 && commentArray.count == 0){
            [self showNoDataViewWithString2:@"暂无相关评价" andImage:nil];
            
        }else{
            [self removeNoDataView2];
        }
        
        if(page != 1){
            
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [self.commentTableview.footer endRefreshingWithNoMoreData];
            }else{
                [self.commentTableview.footer endRefreshing];
            }
        }else{
            [self.commentTableview.header endRefreshing];
        }
    } fail:^(NSString *msg) {
        [self.commentTableview.header endRefreshing];
        [self.commentTableview.footer endRefreshing];
        
    }];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ComentTableCell";
    ComentTableCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ComentTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.feedBackLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.feedBackButton.tag=[indexPath row];
    buttonIndex=[[UIButton alloc]init];
    Coment* coment=[[Coment alloc]init];
    coment=[commentArray objectAtIndex:indexPath.row];
    buttonIndex.tag=[indexPath row];
    cell.starTimeLabel.text=coment.commentTime;
    [cell setStar:coment.score];
   cell.clientImageView.layer.cornerRadius = cell.clientImageView.frame.size.width /2;
    cell.clientImageView.clipsToBounds = YES;
    cell.clientImageView.layer.borderWidth = 3.0f;
    cell.clientImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor ].CGColor;
    NSURL *url=[NSURL URLWithString:coment.commentUserIcon];
    [cell.clientImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4_cTouXiang"]];
    cell.clientNameLabel.text=coment.commentUserName;
    cell.clientContentLabel.text=coment.content;
    cell.clientContentLabel.numberOfLines = 0;
     cell.feedBackLabel.numberOfLines = 0;
    cell.downView.backgroundColor=[UIColor colorWithRed:0xf8/255.0 green:0xf8/255.0 blue:0xf8/255.0 alpha:1.0];
    if (coment.echoList == NULL ) {
        [cell.feedBackButton setTitle:@"回复解释" forState:UIControlStateNormal];
        [cell.feedBackButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.feedBackButton.hidden=YES;
//        cell.feedBackButton.enabled=NO;
//         [cell.feedBackButton setTitle:@"已回复" forState:UIControlStateNormal];
//        [cell.feedBackButton setTitleColor:[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0] forState:UIControlStateNormal];

    }
    
    
    CGSize contentSize = [coment.content boundingRectWithSize:CGSizeMake(KScreenWidth-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    [cell.clientContentLabel setFrame:CGRectMake(20, 50, KScreenWidth-40, contentSize.height)];
    
   

    if (coment.imgList ==NULL) {
        cell.oneImageView.hidden=YES;
        cell.twoImageView.hidden=YES;
        cell.threeImageView.hidden=YES;
        cell.fourImageView.hidden=YES;
        cell.fiveImageView.hidden=YES;
        cell.sixImageView.hidden=YES;
        [cell.feedBackButton setFrame:CGRectMake(KScreenWidth-80, 50+contentSize.height, 60, 30)];
       
        if (coment.echoList == NULL ) {
            cell.downView.hidden=YES;
            cell.feedBackLabel.hidden=YES;

        }else{
            cell.downView.hidden=NO;
            cell.feedBackLabel.text=[NSString stringWithFormat:@"【我的回复】%@",coment.echoList[0][@"commentEcho"]];
           cell.feedBackLabel.numberOfLines = 0;
             cell.feedBackLabel.numberOfLines = 0;
            CGSize contentSize2 =[cell.feedBackLabel.text boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
            
            cell.feedBackLabel.frame=CGRectMake(10, 2, KScreenWidth-60, contentSize2.height);
            cell.downView.backgroundColor=[UIColor colorWithRed:0xf8/255.0 green:0xf8/255.0 blue:0xf8/255.0 alpha:1.0];
            cell.downView.frame=CGRectMake(30, 50+ contentSize.height+30,KScreenWidth-40 ,contentSize2.height+5);
           
        }
    }else{
         [cell.feedBackButton setFrame:CGRectMake(KScreenWidth-80, 40+60+contentSize.height, 60, 30)];
        if (coment.imgList.count==1) {
            cell.oneImageView.hidden=NO;
            cell.oneImageView.userInteractionEnabled = YES;
            cell.oneImageView.tag=indexPath.row*1000+ 0;
            
            
            [cell.oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
           

            [cell.oneImageView setFrame:CGRectMake(20, contentSize.height+50+10, 40, 40)];
            NSURL *url=[NSURL URLWithString:coment.imgList[0]];
            [cell.oneImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            cell.twoImageView.hidden=YES;
            cell.threeImageView.hidden=YES;
            cell.fourImageView.hidden=YES;
            cell.fiveImageView.hidden=YES;
            cell.sixImageView.hidden=YES;

        }else if (coment.imgList.count==2) {
            cell.oneImageView.hidden=NO;
            cell.twoImageView.hidden=NO;
            
            cell.oneImageView.userInteractionEnabled = YES;
            cell.twoImageView.userInteractionEnabled = YES;
            
            cell.oneImageView.tag=indexPath.row*1000+ 0;
            cell.twoImageView.tag=indexPath.row*1000+ 1;
          
            
            
            
            [cell.oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.twoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            

            [cell.oneImageView setFrame:CGRectMake(20, contentSize.height+50+10, 40, 40)];
            [cell.twoImageView setFrame:CGRectMake(70, contentSize.height+50+10, 40, 40)];
            NSURL *url1=[NSURL URLWithString:coment.imgList[0]];
            [cell.oneImageView setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            NSURL *url2=[NSURL URLWithString:coment.imgList[1]];
            
            [cell.twoImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
          
            cell.threeImageView.hidden=YES;
            cell.fourImageView.hidden=YES;
            cell.fiveImageView.hidden=YES;
            cell.sixImageView.hidden=YES;
            
        }else if (coment.imgList.count==3) {
            cell.oneImageView.hidden=NO;
            cell.twoImageView.hidden=NO;
            cell.threeImageView.hidden=NO;
            cell.oneImageView.userInteractionEnabled = YES;
            cell.twoImageView.userInteractionEnabled = YES;
            cell.threeImageView.userInteractionEnabled = YES;
            
            cell.oneImageView.tag=indexPath.row*1000+ 0;
            cell.twoImageView.tag=indexPath.row*1000+ 1;
            cell.threeImageView.tag=indexPath.row*1000+2;
            
            
            
            [cell.oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.twoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.threeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
           


            [cell.oneImageView setFrame:CGRectMake(20, contentSize.height+50+10, 40, 40)];
            [cell.twoImageView setFrame:CGRectMake(70, contentSize.height+50+10, 40, 40)];
            [cell.threeImageView setFrame:CGRectMake(120, contentSize.height+50+10, 40, 40)];

            NSURL *url1=[NSURL URLWithString:coment.imgList[0]];
            [cell.oneImageView setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            NSURL *url2=[NSURL URLWithString:coment.imgList[1]];
            
            [cell.twoImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url3=[NSURL URLWithString:coment.imgList[2]];
            [cell.threeImageView setImageWithURL:url3 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
  
            cell.fourImageView.hidden=YES;
            cell.fiveImageView.hidden=YES;
            cell.sixImageView.hidden=YES;
            
        }else if (coment.imgList.count==4) {
            cell.oneImageView.hidden=NO;
            cell.twoImageView.hidden=NO;
            cell.threeImageView.hidden=NO;
            cell.fourImageView.hidden=NO;
            cell.oneImageView.userInteractionEnabled = YES;
            cell.twoImageView.userInteractionEnabled = YES;
            cell.threeImageView.userInteractionEnabled = YES;
            cell.fourImageView.userInteractionEnabled = YES;
            
            cell.oneImageView.tag=indexPath.row*1000+ 0;
            cell.twoImageView.tag=indexPath.row*1000+ 1;
            cell.threeImageView.tag=indexPath.row*1000+2;
            cell.fourImageView.tag=indexPath.row*1000+ 3;
           
            
            
            [cell.oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.twoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.threeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.fourImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
           


            [cell.oneImageView setFrame:CGRectMake(20, contentSize.height+50+10, 40, 40)];
            [cell.twoImageView setFrame:CGRectMake(70, contentSize.height+50+10, 40, 40)];
            [cell.threeImageView setFrame:CGRectMake(120,contentSize.height+50+10, 40, 40)];
            [cell.fourImageView setFrame:CGRectMake(170, contentSize.height+50+10, 40, 40)];
            
            NSURL *url1=[NSURL URLWithString:coment.imgList[0]];
            [cell.oneImageView setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            NSURL *url2=[NSURL URLWithString:coment.imgList[1]];
            
            [cell.twoImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url3=[NSURL URLWithString:coment.imgList[2]];
            [cell.threeImageView setImageWithURL:url3 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url4=[NSURL URLWithString:coment.imgList[3]];
            [cell.fourImageView setImageWithURL:url4 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
           

            cell.fiveImageView.hidden=YES;
            cell.sixImageView.hidden=YES;
            
        }else if (coment.imgList.count==5) {
            cell.oneImageView.hidden=NO;
            cell.twoImageView.hidden=NO;
            cell.threeImageView.hidden=NO;
            cell.fourImageView.hidden=NO;
            cell.fiveImageView.hidden=NO;
            cell.oneImageView.userInteractionEnabled = YES;
            cell.twoImageView.userInteractionEnabled = YES;
            cell.threeImageView.userInteractionEnabled = YES;
            cell.fourImageView.userInteractionEnabled = YES;
            cell.fiveImageView.userInteractionEnabled = YES;
            
            cell.oneImageView.tag=indexPath.row*1000+ 0;
            cell.twoImageView.tag=indexPath.row*1000+ 1;
            cell.threeImageView.tag=indexPath.row*1000+2;
            cell.fourImageView.tag=indexPath.row*1000+ 3;
            cell.fiveImageView.tag=indexPath.row*1000+ 4;
         
            
            [cell.oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.twoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.threeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.fourImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.fiveImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
            
            
    
            [cell.oneImageView setFrame:CGRectMake(20, contentSize.height+50+10, 40, 40)];
            [cell.twoImageView setFrame:CGRectMake(70, contentSize.height+50+10, 40, 40)];
            [cell.threeImageView setFrame:CGRectMake(120, contentSize.height+50+10, 40, 40)];
            [cell.fourImageView setFrame:CGRectMake(170, contentSize.height+50+10, 40, 40)];
            [cell.fiveImageView setFrame:CGRectMake(220, contentSize.height+50+10, 40, 40)];
            
            NSURL *url1=[NSURL URLWithString:coment.imgList[0]];
            [cell.oneImageView setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            NSURL *url2=[NSURL URLWithString:coment.imgList[1]];
            
            [cell.twoImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url3=[NSURL URLWithString:coment.imgList[2]];
            [cell.threeImageView setImageWithURL:url3 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url4=[NSURL URLWithString:coment.imgList[3]];
            [cell.fourImageView setImageWithURL:url4 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url5=[NSURL URLWithString:coment.imgList[4]];
            [cell.fiveImageView setImageWithURL:url5 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            cell.sixImageView.hidden=YES;
            
        }else if (coment.imgList.count==6) {
            cell.oneImageView.hidden=NO;
            cell.twoImageView.hidden=NO;
            cell.threeImageView.hidden=NO;
            cell.fourImageView.hidden=NO;
            cell.fiveImageView.hidden=NO;
            cell.sixImageView.hidden=NO;
            
            cell.oneImageView.userInteractionEnabled = YES;
            cell.twoImageView.userInteractionEnabled = YES;
            cell.threeImageView.userInteractionEnabled = YES;
            cell.fourImageView.userInteractionEnabled = YES;
            cell.fiveImageView.userInteractionEnabled = YES;
            cell.sixImageView.userInteractionEnabled = YES;
            
            cell.oneImageView.tag=indexPath.row*1000+ 0;
            cell.twoImageView.tag=indexPath.row*1000+ 1;
            cell.threeImageView.tag=indexPath.row*1000+2;
            cell.fourImageView.tag=indexPath.row*1000+ 3;
            cell.fiveImageView.tag=indexPath.row*1000+ 4;
            cell.sixImageView.tag=indexPath.row*1000+ 5;
            
            [cell.oneImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.twoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.threeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.fourImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.fiveImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            [cell.sixImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
           
            
            [cell.oneImageView setFrame:CGRectMake(20, contentSize.height+50+10, 40, 40)];
            [cell.twoImageView setFrame:CGRectMake(70, contentSize.height+50+10, 40, 40)];
            [cell.threeImageView setFrame:CGRectMake(120, contentSize.height+50+10, 40, 40)];
            [cell.fourImageView setFrame:CGRectMake(170, contentSize.height+50+10, 40, 40)];
            [cell.fiveImageView setFrame:CGRectMake(220, contentSize.height+50+10, 40, 40)];
            [cell.sixImageView setFrame:CGRectMake(270, contentSize.height+50+10, 40, 40)];
            
             NSURL *url1=[NSURL URLWithString:coment.imgList[0]];
            [cell.oneImageView setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
            NSURL *url2=[NSURL URLWithString:coment.imgList[1]];
            
            [cell.twoImageView setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url3=[NSURL URLWithString:coment.imgList[2]];
            [cell.threeImageView setImageWithURL:url3 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url4=[NSURL URLWithString:coment.imgList[3]];
            [cell.fourImageView setImageWithURL:url4 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url5=[NSURL URLWithString:coment.imgList[4]];
            [cell.fiveImageView setImageWithURL:url5 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            NSURL *url6=[NSURL URLWithString:coment.imgList[5]];
            [cell.sixImageView setImageWithURL:url6 placeholderImage:[UIImage imageNamed:@"1.jpg"]];
            
        }

        
        if (coment.echoList == NULL ) {
            cell.downView.hidden=YES;
            cell.feedBackLabel.hidden=YES;
            
        }else{

            cell.feedBackLabel.numberOfLines = 0;
            cell.downView.hidden=NO;
           cell.feedBackLabel.text=[NSString stringWithFormat:@" 【我的回复】 %@",coment.echoList[0][@"commentEcho"]];

            cell.feedBackLabel.numberOfLines = 0;
            CGSize contentSize2 = [cell.feedBackLabel.text boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
            cell.feedBackLabel.frame=CGRectMake(10, 2  , KScreenWidth-60, contentSize2.height);
            cell.downView.backgroundColor=[UIColor colorWithRed:0xf8/255.0 green:0xf8/255.0 blue:0xf8/255.0 alpha:1.0];
            [cell.downView setFrame:CGRectMake(30, 40+60+contentSize.height+30,KScreenWidth-40 ,contentSize2.height+5)];
        }

    }
    
    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//   return 280;
    Coment* coment=[[Coment alloc]init];
    coment=[commentArray objectAtIndex:indexPath.row];
    CGSize contentSize = [coment.content boundingRectWithSize:CGSizeMake(KScreenWidth-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;

    NSString *conStr=[NSString stringWithFormat:@" [门店回复] %@",coment.echoList[0][@"commentEcho"]];
      CGSize contentSize2 = [conStr boundingRectWithSize:CGSizeMake(KScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    
    if (coment.imgList ==NULL) {
        if (coment.echoList == NULL) {
            return 50+contentSize.height+50;
        }else{
            return 50+contentSize.height+30+contentSize2.height+20;
        }
    }else {
        if (coment.echoList == NULL) {
            return 50+contentSize.height+95;
        }else{
            return 50+contentSize.height+30+contentSize2.height+75;
        }

    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return commentArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //禁用iq键盘
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //启用iq键盘
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    
   }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)keyboardWillShow:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.moveView  setFrame:CGRectMake(0, APP_H-kbSize.height-40, KScreenWidth, 60)];
    //    [self.view addSubview:self.moveView];
    
}
- (void)keyboardWillHide:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.moveView setFrame:CGRectMake(0, KScreenHeight-60, KScreenWidth, 60)];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"回复评价...."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"回复评价....";
        textView.textColor = [UIColor lightGrayColor];
    }
}

-(void)buttonPressed:(UIButton *)btn{
    tagButton=btn;
  
    [self.navigationController.view addSubview:self.feedBackView];
    self.moveTextView.text=@"回复评价....";
    [self.moveView setFrame:CGRectMake(0, KScreenHeight-60, KScreenWidth, 60)];
    [self.navigationController.view addSubview:self.moveView];
    [self.moveTextView becomeFirstResponder];
}
-(void)hideView{
    [self.feedBackView removeFromSuperview];
    [self.moveView removeFromSuperview];
}
/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendAction:(id)sender {
    self.moveTextView.delegate=self;
    NSLog(@"%@",self.moveTextView.text);
    if ( [self.moveTextView.text isEqualToString:@"回复评价...."]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"你好" message:@"请输入您要评论的内容"
                                                      delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
        
    }
    if ([[self.moveTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入您要评论的内容!"
                                                      delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
      NSLog(@"++++++++++++++++++%ld",tagButton.tag);
    Coment* coment=[[Coment alloc]init];
    coment=[commentArray objectAtIndex:tagButton.tag];
    
    NSDictionary *dic = @{@"commentEcho":self.moveTextView.text};
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:dic, nil];
//    [coment.echoList addObjectsFromArray:arr];
    coment.echoList =arr;

//    NSString *str=[NSString stringWithFormat:@"%@",self.moveTextView.text];
    
//    self.moveTextView.text=@"self.moveTextView.text stringByTrimmingCharactersInSetself.moveTextView.text stringByTrimmingCharactersInSetself.moveTextView.text stringByTrimmingCharactersInSetself.moveTextView.text stringByTrimmingCharactersInSetself.moveTextView.text stringByTrimmingCharactersInSet";
   NSDictionary * dict= @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"echoContent":self.moveTextView.text,@"commentId":coment.id};

[HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dict] path:FeeedCoustomer method:@"GET" success:^(id object) {
    if (object) {
        if ([[object objectForKey:@"success"]intValue] == 1) {
//            [Utils alertView:@"信息已发送"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tagButton.tag inSection:0];
    [self.commentTableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.feedBackView removeFromSuperview];
    [self.moveView removeFromSuperview];
    

            
        }else{
            [self.feedBackView removeFromSuperview];
            [self.moveView removeFromSuperview];

            //  self.moveTextView.text=@"";
            NSDictionary *dict=[object objectForKey:@"error"];
            NSString *yy=[dict objectForKey:@"extDesc"];
            [Utils alertView:yy];
            NSLog(@"错误");
        }
    }
} fail:^(NSString *msg) {
    
}];
    // coment.echoList[0][@"commentEcho"]=self.moveTextView.text;
}
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"WEQEQEQWEQ");
//    NSLog(@"%ld",(long)buttonIndex.tag);
    Coment* coment=[[Coment alloc]init];
    coment=[commentArray objectAtIndex:tap.view.tag/1000];
    
    NSInteger count = coment.imgList.count;
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [ coment.imgList[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag%1000; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

@end
