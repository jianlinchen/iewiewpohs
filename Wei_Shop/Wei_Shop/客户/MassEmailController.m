//
//  MassEmailController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "MassEmailController.h"
#import "MassEmailTableCell.h"
#import "PostEmailController.h"
@interface MassEmailController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *sendArray;//被选中的数组，也是要传递到下一页的数组
    BOOL cellButton;
    int kl;
    NSMutableArray *clientArray;
    NSMutableArray *oneArray;//字母数组
    NSMutableArray *twoArray;//客户资料
    NSMutableArray *arrMut;
    int page;
    UIButton *button0;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;
    UIButton *button6;
    UIButton *button7;
    UIButton *button8;
    
    BOOL  orAll;
    int  oneIndex;
    int  twoIndex;
    int  threeIndex;
    int  fourIndex;
    int  fiveIndex;
    int  sixIndex;
    int  sevevIndex;
    int  eightIndex;
    
    int  zeroIndex;
    
    BOOL isAll;
    
    int allIndex;
    UIButton *nextButton;
    
    }

@end

@implementation MassEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
   
    sendArray=[[NSMutableArray alloc]init];
    clientArray=[[NSMutableArray alloc]init];
    arrMut=[[NSMutableArray alloc]init];
    oneArray =[[NSMutableArray alloc]init];
    twoArray=[[NSMutableArray alloc]init];
   
    
     page = 1;
    
        [self loadSendDetai];
    [self initButton];

    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 103, KScreenWidth, KScreenHeight-170)];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    table.sectionIndexBackgroundColor = [UIColor clearColor];
    table.sectionIndexColor = [UIColor blackColor];
    
    UIView *view = [[UIView alloc]init];
    table .tableFooterView = view;
   
    NSString * countStr=[NSString stringWithFormat:@"下一步(%lu/%lu)",(unsigned long)sendArray.count,(unsigned long)arrMut.count ];
    nextButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    nextButton.titleLabel.font=[UIFont systemFontOfSize: 11.0];
   [nextButton setTitle:countStr forState:UIControlStateNormal];

    [nextButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = backItem;
//          [self drantConer];
}
-(void)initButton{

    double x=(KScreenWidth-290)/6;
    NSLog(@"%@",sendArray);
   button0=[[UIButton alloc]initWithFrame:CGRectMake(x, 15, 58, 62)];
    [button0 setTitle:@"全部" forState:UIControlStateNormal];
    button0.titleLabel.font = [UIFont systemFontOfSize: 17.0];
    [button0 addTarget:self action:@selector(button0:) forControlEvents:UIControlEventTouchUpInside];
    
    

    button1=[[UIButton alloc]initWithFrame:CGRectMake(58+2*x, 15, 58, 28)];
    [button1 setTitle:@"保湿补水" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];

    
    button2=[[UIButton alloc]initWithFrame:CGRectMake(116+3*x, 15, 58, 28)];
    [button2 setTitle:@"肤色净白" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];

    button3=[[UIButton alloc]initWithFrame:CGRectMake(174+4*x, 15, 58, 28)];
    [button3 setTitle:@"风刺祛除" forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button3 addTarget:self action:@selector(button3:) forControlEvents:UIControlEventTouchUpInside];

    button4=[[UIButton alloc]initWithFrame:CGRectMake(232+5*x, 15, 58, 28)];
    [button4 setTitle:@"油脂控制" forState:UIControlStateNormal];
    button4.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button4 addTarget:self action:@selector(button4:) forControlEvents:UIControlEventTouchUpInside];

    
    button5=[[UIButton alloc]initWithFrame:CGRectMake(58+2*x, 49, 58, 28)];
    [button5 setTitle:@"斑点淡化" forState:UIControlStateNormal];
    button5.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button5 addTarget:self action:@selector(button5:) forControlEvents:UIControlEventTouchUpInside];

    button6=[[UIButton alloc]initWithFrame:CGRectMake(116+3*x, 49, 58, 28)];
    [button6 setTitle:@"敏感修复" forState:UIControlStateNormal];
    button6.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button6 addTarget:self action:@selector(button6:) forControlEvents:UIControlEventTouchUpInside];

    
    button7=[[UIButton alloc]initWithFrame:CGRectMake(174+4*x, 49, 58, 28)];
    [button7 setTitle:@"毛孔细致" forState:UIControlStateNormal];
    button7.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button7 addTarget:self action:@selector(button7:) forControlEvents:UIControlEventTouchUpInside];

    
    button8=[[UIButton alloc]initWithFrame:CGRectMake(232+5*x, 49, 58, 28)];
    [button8 setTitle:@"细纹抚平" forState:UIControlStateNormal];
    button8.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [button8 addTarget:self action:@selector(button8:) forControlEvents:UIControlEventTouchUpInside];
    
       
    UILabel *downLabel=[[UILabel alloc]initWithFrame:CGRectMake(x, 83, 280, 14)];
    downLabel.font=[UIFont systemFontOfSize: 12];
    downLabel.text=@"请选择八大指标问题肌肤客户（可多选)";
    [self drantConer];
    [self.topView addSubview:downLabel];
    [self.topView addSubview:button0];
    [self.topView addSubview:button1];
    [self.topView addSubview:button2];
    [self.topView addSubview:button3];
    [self.topView addSubview:button4];
    [self.topView addSubview:button5];
    [self.topView addSubview:button6];
    [self.topView addSubview:button7];
    [self.topView addSubview:button8];

    [self drantConer];
}

-(void)drantConer{
    button0.layer.borderWidth = 1.0;
    button0.layer.cornerRadius = 4.5;
    button0.layer.borderColor=[UIColor blackColor].CGColor;
    [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button0.backgroundColor=[UIColor whiteColor];
    
    
     button1.layer.borderWidth = 1.0;
     button1.layer.cornerRadius = 4.5;
     button1.layer.borderColor=[UIColor blackColor].CGColor;
     button1.backgroundColor=[UIColor whiteColor];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    button2.layer.borderWidth = 1.0;
    button2.layer.cornerRadius = 4.5;
    button2.layer.borderColor=[UIColor blackColor].CGColor;
    button2.backgroundColor=[UIColor whiteColor];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    button3.layer.borderWidth = 1.0;
    button3.layer.cornerRadius = 4.5;
    button3.layer.borderColor=[UIColor blackColor].CGColor;
    button3.backgroundColor=[UIColor whiteColor];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    
    button4.layer.borderWidth = 1.0;
    button4.layer.cornerRadius = 4.5;
    button4.layer.borderColor=[UIColor blackColor].CGColor;
    button4.backgroundColor=[UIColor whiteColor];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];



    button5.layer.borderWidth = 1.0;
    button5.layer.cornerRadius = 4.5;
    button5.layer.borderColor=[UIColor blackColor].CGColor;
    button5.backgroundColor=[UIColor whiteColor];
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];



    button6.layer.borderWidth = 1.0;
    button6.layer.cornerRadius = 4.5;
    button6.layer.borderColor=[UIColor blackColor].CGColor;
    button6.backgroundColor=[UIColor whiteColor];
    [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    button7.layer.borderWidth = 1.0;
    button7.layer.cornerRadius = 4.5;
     button7.layer.borderColor=[UIColor blackColor].CGColor;
    button7.backgroundColor=[UIColor whiteColor];
    [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    button8.layer.borderWidth = 1.0;
    button8.layer.cornerRadius = 4.5;
    button8.layer.borderColor=[UIColor blackColor].CGColor;
    button8.backgroundColor=[UIColor whiteColor];
    [button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    
    }
-(void)loadSendDetai{
    NSMutableArray * ar1=[[NSMutableArray alloc]init];
   NSMutableArray *  ar2=[[NSMutableArray alloc]init];
    NSMutableArray * ar3=[[NSMutableArray alloc]init];
    NSMutableArray * ar4=[[NSMutableArray alloc]init];
    NSMutableArray * ar5=[[NSMutableArray alloc]init];
    NSMutableArray * ar6=[[NSMutableArray alloc]init];
   NSMutableArray *  ar7=[[NSMutableArray alloc]init];
   NSMutableArray *  ar8=[[NSMutableArray alloc]init];
   NSMutableArray *  ar9=[[NSMutableArray alloc]init];

   
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"pageIndex":@(page),@"pageSize":@(10000)};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:CommonList method:@"GET" success:^(id object) {
        if (object) {
            
            if ([[object objectForKey:@"success"]intValue] == 1) {
                
                if(page == 1){
                    [arrMut removeAllObjects];
                    [oneArray removeAllObjects];
                    [twoArray removeAllObjects];

                    // [table .footer resetNoMoreData];
                    [arrMut addObjectsFromArray:[object objectForKey:@"result"]];
                }else{
                    [arrMut addObjectsFromArray:[object objectForKey:@"result"]];
                }
                
                if(arrMut.count > 0){
                    [table reloadData];
                }
//                NSArray *sortedArray = [arrMut sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//                    //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
//                    NSComparisonResult result = [obj1[@"spell"] compare:obj2[@"spell"]];
//                    return result;
//                }];
                NSString * countStr=[NSString stringWithFormat:@"下一步(%lu/%lu)",(unsigned long)sendArray.count,(unsigned long)arrMut.count ];
        
                [nextButton setTitle:countStr forState:UIControlStateNormal];
                
                
                NSMutableArray *topArray = [NSMutableArray new];
                for(NSDictionary *dic in arrMut){
                    
                    [topArray addObject:dic[@"spell"]];
                }
                
                
                //字母排序的去重
                NSMutableArray *TwoArray = [NSMutableArray new];
                for (int i = 0 ; i< [topArray count]; i ++) {
                    if ( [TwoArray containsObject:topArray[i]]==NO) {
                        
                        [TwoArray addObject:topArray[i]];
                    }
                }
                oneArray=TwoArray;//一维数组已经确定。
                
                
                if (oneArray.count!=0) {
                    twoArray = [self generateTwoArray:arrMut];
                }
                for (int a = 0; a < twoArray.count; a++) {
                    NSMutableArray *arr = [twoArray objectAtIndex:a];
                    for (int j = 0; j < arr.count; j++) {
                        Client *one = [arr objectAtIndex:j];
                        if ( [one.tagIds containsObject:[NSNumber numberWithInt:1]]) {
                            [ar1 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:2]]){
                            [ar2 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:3]]){
                            [ar3 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:4]]){
                            [ar4 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:5]]){
                            [ar5 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:6]]){
                            [ar6 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:7]]){
                            [ar7 addObject:one];
                        }
                        if ([one.tagIds containsObject:[NSNumber numberWithInt:8]]){
                            [ar8 addObject:one];
                        }if (one.tagIds.count==0) {
                            [ar9 addObject:one];
                        }
                    }
                    
                }

                
                if (ar1.count==0) {
                    button1.enabled=NO;
                    button1.layer.borderColor=[UIColor clearColor].CGColor;
                    button1.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                }else{
                    button1.enabled=YES;
                }
                
                if (ar2.count==0) {
                    button2.enabled=NO;
                    button2.layer.borderColor=[UIColor clearColor].CGColor;
                    button2.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];

                }else{
                    button2.enabled=YES;
                }
                
                if (ar3.count==0) {
                    button3.enabled=NO;
                    button3.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                    button3.layer.borderColor=[UIColor clearColor].CGColor;
                }else{
                    button1.enabled=YES;
                }
                if (ar4.count==0) {
                    button4.enabled=NO;
                    button4.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                    button4.layer.borderColor=[UIColor clearColor].CGColor;
                }else{
                    button4.enabled=YES;
                }
                if (ar5.count==0) {
                    button5.enabled=NO;
                    button5.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                    button5.layer.borderColor=[UIColor clearColor].CGColor;
                }else{
                    button5.enabled=YES;
                }
                if (ar6.count==0) {
                    button6.enabled=NO;
                    button6.layer.borderColor=[UIColor clearColor].CGColor;
                    button6.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];                }else{
                    button6.enabled=YES;
                }
                if (ar7.count==0) {
                    button7.enabled=NO;
                    button7.layer.borderColor=[UIColor clearColor].CGColor;
                    button7.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                }else{
                    button7.enabled=YES;
                }
                if (ar8.count==0) {
                    button8.enabled=NO;
                    button8.layer.borderColor=[UIColor clearColor].CGColor;
                    button8.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                }else{
                    button8.enabled=YES;
                }

                if (ar9.count==0) {
                    button0.enabled=NO;
                    button0.layer.borderColor=[UIColor clearColor].CGColor;
                    button0.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
                }else{
                    button0.enabled=YES;
                }

                [table reloadData];
            }
            
        }
        if(page == 1 && arrMut.count == 0){
            
        }
        if(page != 1){
            NSArray *array = [object objectForKey:@"result"];
            if(array.count < 10){
                [table.footer endRefreshingWithNoMoreData];
                
            }else{
                [table.footer endRefreshing];
            }
        }else{
            [table.header endRefreshing];
        }
        
        
    } fail:^(NSString *msg) {
        
    }];
    
}
- (NSMutableArray *)generateTwoArray:(NSArray *)array{
    
//    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
//        NSComparisonResult result = [obj1[@"spell"] compare:obj2[@"spell"]];
//        return result;
//    }];
    
    NSMutableArray *topArray = [NSMutableArray new];
    for(NSDictionary *dic in array){
        
        [topArray addObject:dic[@"spell"]];
    }
    
    
    NSSet *set = [NSSet setWithArray:topArray];
    
    
    NSMutableArray *TwoArray = [NSMutableArray new];
    for (int i  = 0; i < set.count; i ++) {
        [TwoArray addObject:[NSMutableArray new]];
    }
    
    
    NSString *spell = array[0][@"spell"];
    
    int lie = 0;
    
    for (int i = 0; i < array.count; i ++) {
        
        NSDictionary *clientDic = array[i];
        Client *client=[[Client alloc]init];
        [client getClient:clientDic];
        if([array[i][@"spell"] isEqualToString:spell]){
            NSMutableArray *array = TwoArray[lie];
            [array addObject:client];
            
        }else{
            lie++;
            spell = array[i][@"spell"];
            NSMutableArray *array = TwoArray[lie];
            [array addObject:client];
        }
    }
    return TwoArray;
}
//点击下一步的按钮，执行的方法
-(void)sendMessage{
    NSLog(@"点击下一步的时候 sendArray.count是  %lu",(unsigned long)sendArray.count);
    
    NSLog(@"点击下一步的时候 arrMut.count是  %lu",(unsigned long)arrMut.count);

   
    if (sendArray.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择至少一个客户!"];
    }else{
        PostEmailController  *qc = [[PostEmailController alloc]initWithNibName:@"PostEmailController" bundle:nil];
        qc.title=@"群发活动消息";
        qc.cusArray=sendArray;
        qc.allCusArray=arrMut;
        [self.navigationController pushViewController:qc animated:YES];
 
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MassEmailTableCell";
    MassEmailTableCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MassEmailTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Client *client=[[Client alloc]init];
    client=[twoArray [indexPath.section] objectAtIndex:indexPath.row];
    
//    cell.massButton.tag=indexPath.section*1000+indexPath.row;
     NSURL *url=[NSURL URLWithString:client.icon];

    [ cell.massHeaderImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"4_cTouXiang"]];
    cell.massHeaderImageView.layer.cornerRadius = cell.massHeaderImageView.frame.size.width /2;
    
    cell.massHeaderImageView.clipsToBounds = YES;
    
    cell.massHeaderImageView.layer.borderWidth = 0.0f;
    if (client.remark.length==0) {
        cell.massNameLabel.text=client.nickName;
    }else{
         cell.massNameLabel.text=client.remark;
    }
    cell.massPhoneLabel.text=client.mobile;
    
    if (client.isSelect) {
        cell.lateImageView.image=[UIImage imageNamed:@"2_select"];
        

    }else{
          cell.lateImageView.image=[UIImage imageNamed:@"2_noSelect"];
    }
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return oneArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return [(NSMutableArray *)[twoArray objectAtIndex:section] count];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return oneArray;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSString *key = [oneArray objectAtIndex:index];
    if (key == UITableViewIndexSearch) {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    return index;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    NSString *key = [oneArray objectAtIndex:section];
    titleLabel.text = key;
    [bgView addSubview:titleLabel];
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    allIndex=0;
    Client *one = [[twoArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (one.isSelect) {
        [sendArray removeObject:one];
        one.isSelect = NO;
    }else{
        [sendArray addObject:one];

        one.isSelect = YES;
    }
//    if (sendArray.count==arrMut.count) {
//         allIndex=1;
//        self.Button0.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
//        self.Button0.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
//        [self.Button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }else{
//         allIndex=0;
//        self.Button0.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
//        self.Button0.backgroundColor=[UIColor whiteColor];
//        [self.Button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//  
//    }
//    [self deternButtonColour];
   NSLog(@"此刻的sendArray.cout 是 %lu",(unsigned long)sendArray.count);
    NSString * countStr=[NSString stringWithFormat:@"下一步(%lu/%lu)",(unsigned long)sendArray.count,(unsigned long)arrMut.count ];
//    NSString * countStr=[NSString stringWithFormat:@"下一步(200/200)"];

    [nextButton setTitle:countStr forState:UIControlStateNormal];
    [table reloadData];
}

-(void)deternButtonColour{
    NSLog(@"%@",sendArray);
    NSMutableArray *arr1=[[NSMutableArray alloc]init];
    NSMutableArray *arr2=[[NSMutableArray alloc]init];
    NSMutableArray *arr3=[[NSMutableArray alloc]init];
    NSMutableArray *arr4=[[NSMutableArray alloc]init];
    NSMutableArray *arr5=[[NSMutableArray alloc]init];
    NSMutableArray *arr6=[[NSMutableArray alloc]init];
    NSMutableArray *arr7=[[NSMutableArray alloc]init];
    NSMutableArray *arr8=[[NSMutableArray alloc]init];
    
    NSMutableArray *arr11=[[NSMutableArray alloc]init];
    NSMutableArray *arr22=[[NSMutableArray alloc]init];
    NSMutableArray *arr33=[[NSMutableArray alloc]init];
    NSMutableArray *arr44=[[NSMutableArray alloc]init];
    NSMutableArray *arr55=[[NSMutableArray alloc]init];
    NSMutableArray *arr66=[[NSMutableArray alloc]init];
    NSMutableArray *arr77=[[NSMutableArray alloc]init];
    NSMutableArray *arr88=[[NSMutableArray alloc]init];
  
    
    for (int a = 0; a < twoArray.count; a++) {
        NSMutableArray *arr = [twoArray objectAtIndex:a];
        for (int j = 0; j < arr.count; j++) {
            Client *one = [arr objectAtIndex:j];
            if ( [one.tagIds containsObject:[NSNumber numberWithInt:1]]) {
                [arr1 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:2]]){
                [arr2 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:3]]){
                [arr3 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:4]]){
                [arr4 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:5]]){
                [arr5 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:6]]){
                [arr6 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:7]]){
                [arr7 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:8]]){
                [arr8 addObject:one];
            }
        }
            
    }
    
    
    
    for (int a=0; a<sendArray.count; a++) {
        Client *client1=[sendArray objectAtIndex:a];
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:1]]) {
            [arr11 addObject:client1];
        }
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:2]]) {
            [arr22 addObject:client1];
        }
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:3]]) {
            [arr33 addObject:client1];
        }
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:4]]) {
            [arr44 addObject:client1];
        }if ( [client1.tagIds containsObject:[NSNumber numberWithInt:5]]) {
            [arr55 addObject:client1];
        }
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:6]]) {
            [arr66 addObject:client1];
        }
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:7]]) {
            [arr77 addObject:client1];
        }
        if ( [client1.tagIds containsObject:[NSNumber numberWithInt:8]]) {
            [arr88 addObject:client1];
        }
    }
    //第一个button
    if (arr1.count==arr11.count&&arr1.count!=0) {
        oneIndex = 1;
        
        button1.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button1.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        oneIndex = 0;
        button1.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button1.backgroundColor=[UIColor whiteColor];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }

     //第二个button
    if (arr2.count==arr22.count&&arr2.count!=0) {
        twoIndex = 1;
        
        button2.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button2.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        twoIndex = 0;
       button2.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button2.backgroundColor=[UIColor whiteColor];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

     //第三个button
    if (arr3.count==arr33.count&&arr3.count!=0) {
        threeIndex = 1;
        
        button3.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
         button3.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [ button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        threeIndex = 0;
         button3.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
         button3.backgroundColor=[UIColor whiteColor];
        [ button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
     //第四个button
    if (arr4.count==arr44.count&&arr4.count!=0) {
        fourIndex = 1;
        
         button4.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button4.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        fourIndex = 0;
        button4.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button4.backgroundColor=[UIColor whiteColor];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

     //第五个button
    if (arr5.count==arr55.count&&arr5.count!=0) {
        fiveIndex = 1;
        
        button5.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button5.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        fiveIndex = 0;
        button5.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button5.backgroundColor=[UIColor whiteColor];
        [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

     //第六个button
    if (arr6.count==arr66.count&&arr6.count!=0) {
        sixIndex = 1;
        
        button6.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button6.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        sixIndex = 0;
        button6.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button6.backgroundColor=[UIColor whiteColor];
        [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }

     //第第七个button
    if (arr7.count==arr77.count&&arr7.count!=0) {
        sevevIndex = 1;

        button7.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button7.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button7 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        sevevIndex = 0;
        button7.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button7.backgroundColor=[UIColor whiteColor];
        [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    
     //第八个button
    if (arr8.count==arr88.count&&arr8.count!=0) {
        eightIndex = 1;
        button8.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button8.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button8 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        eightIndex = 0;
        button8.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
        button8.backgroundColor=[UIColor whiteColor];
        [button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
//    [sendArray removeAllObjects];
    NSString * countStr=[NSString stringWithFormat:@"下一步(%lu/%lu)",(unsigned long)sendArray.count,(unsigned long)arrMut.count ];
    [nextButton setTitle:countStr forState:UIControlStateNormal];

    NSLog(@"界面出现的此刻的sendArray.cout 是 %lu",(unsigned long)sendArray.count);
}

-(void)mangieButtonBackgrounColor{
    NSMutableArray * ar1=[[NSMutableArray alloc]init];
    NSMutableArray *  ar2=[[NSMutableArray alloc]init];
    NSMutableArray * ar3=[[NSMutableArray alloc]init];
    NSMutableArray * ar4=[[NSMutableArray alloc]init];
    NSMutableArray * ar5=[[NSMutableArray alloc]init];
    NSMutableArray * ar6=[[NSMutableArray alloc]init];
    NSMutableArray *  ar7=[[NSMutableArray alloc]init];
    NSMutableArray *  ar8=[[NSMutableArray alloc]init];
//    NSMutableArray *  ar9=[[NSMutableArray alloc]init];

    
    
    for (int a = 0; a < twoArray.count; a++) {
        NSMutableArray *arr = [twoArray objectAtIndex:a];
        for (int j = 0; j < arr.count; j++) {
            Client *one = [arr objectAtIndex:j];
            if ( [one.tagIds containsObject:[NSNumber numberWithInt:1]]) {
                [ar1 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:2]]){
                [ar2 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:3]]){
                [ar3 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:4]]){
                [ar4 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:5]]){
                [ar5 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:6]]){
                [ar6 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:7]]){
                [ar7 addObject:one];
            }
            if ([one.tagIds containsObject:[NSNumber numberWithInt:8]]){
                [ar8 addObject:one];
            }
//                if (one.tagIds.count==0) {
//                [ar9 addObject:one];
//            }
        }
        
    }
    button0.layer.borderColor=[UIColor blackColor].CGColor;
    button0.backgroundColor=[UIColor whiteColor];
    [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    
    if (ar1.count==0) {
        button1.enabled=NO;
        button1.layer.borderColor=[UIColor clearColor].CGColor;
        button1.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    }else{
        button1.enabled=YES;
        button1.backgroundColor=[UIColor whiteColor];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         button1.layer.borderColor=[UIColor blackColor].CGColor;

    }
    
    if (ar2.count==0) {
        button2.enabled=NO;
        button2.layer.borderColor=[UIColor clearColor].CGColor;
        button2.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
        
    }else{
        button2.enabled=YES;
        button2.backgroundColor=[UIColor whiteColor];
         button2.layer.borderColor=[UIColor blackColor].CGColor;
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    }
    
    if (ar3.count==0) {
        button3.enabled=NO;
        button3.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
        button3.layer.borderColor=[UIColor clearColor].CGColor;
    }else{
        button3.enabled=YES;
        button3.backgroundColor=[UIColor whiteColor];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button3.layer.borderColor=[UIColor blackColor].CGColor;

    }
    if (ar4.count==0) {
        button4.enabled=NO;
        button4.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
        button4.layer.borderColor=[UIColor clearColor].CGColor;
    }else{
        button4.enabled=YES;
         button4.layer.borderColor=[UIColor blackColor].CGColor;
        button4.backgroundColor=[UIColor whiteColor];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    }
    if (ar5.count==0) {
        button5.enabled=NO;
        button5.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
        button5.layer.borderColor=[UIColor clearColor].CGColor;
    }else{
        button5.enabled=YES;
         button5.layer.borderColor=[UIColor blackColor].CGColor;
        [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        button5.backgroundColor=[UIColor whiteColor];

    }
    if (ar6.count==0) {
        button6.enabled=NO;
        button6.layer.borderColor=[UIColor clearColor].CGColor;
        button6.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    }else{
            button6.enabled=YES;
         button6.layer.borderColor=[UIColor blackColor].CGColor;
        [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        button6.backgroundColor=[UIColor whiteColor];

        }
    if (ar7.count==0) {
        button7.enabled=NO;
        button7.layer.borderColor=[UIColor clearColor].CGColor;
        button7.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    }else{
        button7.backgroundColor=[UIColor whiteColor];
        [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button7.layer.borderColor=[UIColor blackColor].CGColor;
        button7.enabled=YES;
    }
    if (ar8.count==0) {
        button8.enabled=NO;
        button8.layer.borderColor=[UIColor clearColor].CGColor;
        button8.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    }else{
        button8.backgroundColor=[UIColor whiteColor];
        [button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button8.layer.borderColor=[UIColor blackColor].CGColor;
        button8.enabled=YES;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
//    allIndex=0;
//    oneIndex=0;
//    twoIndex=0;
//    threeIndex=0;
//    fourIndex=0;
//    fiveIndex=0;
//    sixIndex=0;
//    sevevIndex=0;
//    eightIndex=0;
//    zeroIndex=0;
   
//    for(NSArray *arr in twoArray){
//        for(Client *kehu in arr){
//            kehu.isSelect = NO;
//        }
//    }
//    [self mangieButtonBackgrounColor];
//  NSLog(@"%ld",(unsigned long)sendArray.count);
    [table reloadData];
  
}
//八大指标button背景变为灰色
-(void)grayButton{
    
    button1.enabled=NO;
    button1.layer.borderColor=[UIColor clearColor].CGColor;
     [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    button2.enabled=NO;
    button2.layer.borderColor=[UIColor clearColor].CGColor;
     [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    button3.enabled=NO;
    button3.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    button3.layer.borderColor=[UIColor clearColor].CGColor;
     [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.enabled=NO;
    button4.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    button4.layer.borderColor=[UIColor clearColor].CGColor;
     [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button5.enabled=NO;
    button5.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
    button5.layer.borderColor=[UIColor clearColor].CGColor;
     [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button6.enabled=NO;
    button6.layer.borderColor=[UIColor clearColor].CGColor;
    button6.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
     [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button7.enabled=NO;
    button7.layer.borderColor=[UIColor clearColor].CGColor;
    button7.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
   [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button8.enabled=NO;
    button8.layer.borderColor=[UIColor clearColor].CGColor;
     [button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button8.backgroundColor=[UIColor colorWithRed:0xE0/255.0 green:0xE0/255.0 blue:0xE0/255.0 alpha:1.0];
}
-(void)button0:(id)sender{
    [sendArray removeAllObjects];
        if (allIndex==1) {
            
//            button0.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
            button0.layer.borderColor=[UIColor blackColor].CGColor;
            button0.backgroundColor=[UIColor whiteColor];
            [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
          [self mangieButtonBackgrounColor];
            
            for (int a = 0; a < twoArray.count; a++) {
                NSMutableArray *arr = [twoArray objectAtIndex:a];
                for (int j = 0; j < arr.count; j++) {
                    Client *one = [arr objectAtIndex:j];
                    one.isSelect = NO;
                     [sendArray removeAllObjects];
                }
    
            }
    
            [table reloadData];
            allIndex = 0;
        }else{
            oneIndex=0;
            twoIndex=0;
            threeIndex=0;
            fourIndex=0;
            fiveIndex=0;
            sixIndex=0;
            sevevIndex=0;
            eightIndex=0;
            [self grayButton];
        button0.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
            button0.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
            [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            for (int a = 0; a < twoArray.count; a++) {
                NSMutableArray *arr = [twoArray objectAtIndex:a];
                for (int j = 0; j < arr.count; j++) {
                    Client *one = [arr objectAtIndex:j];
                    one.isSelect = YES;
                    [sendArray addObject:one];
                }
            }
           
            [table reloadData];
            allIndex = 1;
        }
    NSLog(@"此刻的sendArray.cout 是 %lu",(unsigned long)sendArray.count);
    NSString * countStr=[NSString stringWithFormat:@"下一步(%lu/%lu)",(unsigned long)sendArray.count,(unsigned long)arrMut.count ];
    [nextButton setTitle:countStr forState:UIControlStateNormal];
//    [self deternButtonColour];
//    if (isAll) {
//        for (int a = 0; a < twoArray.count; a++) {
//            NSMutableArray *arr = [twoArray objectAtIndex:a];
//            for (int j = 0; j < arr.count; j++) {
//                Client *one = [arr objectAtIndex:j];
//                one.isSelect = NO;
//                 [sendArray removeAllObjects];
//            }
//             
//        }
//        
//        [table reloadData];
//        isAll = NO;
//    }else{
//        for (int a = 0; a < twoArray.count; a++) {
//            NSMutableArray *arr = [twoArray objectAtIndex:a];
//            for (int j = 0; j < arr.count; j++) {
//                Client *one = [arr objectAtIndex:j];
//                one.isSelect = YES;
//                [sendArray addObject:one];
//            }
//        }
//       
//        [table reloadData];
//        isAll = YES;
//    }

}
-(void)button1:(id)sender{
      NSLog(@"1");
    if (oneIndex ==0) {
        
        button1.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button1.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        oneIndex = 1;
    }else{
        oneIndex = 0;
        button1.layer.borderColor=[UIColor blackColor].CGColor;
        button1.backgroundColor=[UIColor whiteColor];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
      [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
    
}

-(void)button2:(id)sender{
   
      NSLog(@"2");
    if (twoIndex ==0) {
        button2.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button2.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [(UIButton *)sender setBackgroundColor:[UIColor redColor]];
        twoIndex = 2;
    }else{
        twoIndex = 0;
//        [(UIButton *)sender setBackgroundColor:[UIColor blueColor]];
        button2.layer.borderColor=[UIColor blackColor].CGColor;
        button2.backgroundColor=[UIColor whiteColor];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
}
-(void)button3:(id)sender{
      NSLog(@"3");
    if (threeIndex ==0) {
        button3.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button3.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        threeIndex = 3;
    }else{
        threeIndex = 0;
        button3.layer.borderColor=[UIColor blackColor].CGColor;
        button3.backgroundColor=[UIColor whiteColor];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
}

-(void)button4:(id)sender{
      NSLog(@"4");
    if (fourIndex ==0) {
        button4.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button4.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        fourIndex = 4;
    }else{
        fourIndex = 0;
        button4.layer.borderColor=[UIColor blackColor].CGColor;
        button4.backgroundColor=[UIColor whiteColor];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
}
-(void)button5:(id)sender{
      NSLog(@"5");
    if (fiveIndex ==0) {
        button5.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button5.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        fiveIndex = 5;
    }else{
        fiveIndex = 0;
        button5.layer.borderColor=[UIColor blackColor].CGColor;
        button5.backgroundColor=[UIColor whiteColor];
        [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
}

-(void)button6:(id)sender{
      NSLog(@"6");
    if (sixIndex ==0) {
        button6.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button6.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sixIndex = 6;
    }else{
        sixIndex = 0;
        button6.layer.borderColor=[UIColor blackColor].CGColor;
        button6.backgroundColor=[UIColor whiteColor];
        [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
}

-(void)button7:(id)sender{
      NSLog(@"7");
      if (sevevIndex ==0) {
        button7.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button7.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button7 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        sevevIndex = 7;
    }else{
        sevevIndex = 0;
        button7.layer.borderColor=[UIColor blackColor].CGColor;
        button7.backgroundColor=[UIColor whiteColor];
        [button7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ];
}

-(void)button8:(id)sender{
    NSLog(@"8");
    if (eightIndex ==0) {
        button8.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
        button8.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
        [button8 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        eightIndex = 8;
    }else{
        eightIndex = 0;
        button8.layer.borderColor=[UIColor blackColor].CGColor;
        button8.backgroundColor=[UIColor whiteColor];
        [button8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self getAllSlelctUser:oneIndex two:twoIndex three:threeIndex four:fourIndex five:fiveIndex six:sixIndex seven:sevevIndex eight:eightIndex ] ;
}

-(void)getAllSlelctUser:(int)o two:(int)two three:(int)three four:(int)four five:(int)five six:(int)six seven:(int)s eight:(int)e {
    [sendArray removeAllObjects];
    for (int a = 0; a < twoArray.count; a++) {
        NSMutableArray *arr = [twoArray objectAtIndex:a];
        for (int j = 0; j < arr.count; j++) {
            Client *one = [arr objectAtIndex:j];
            one.isSelect = NO;
            
            

            
            if ([one.tagIds containsObject:[NSNumber numberWithInt:o]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:two]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:three]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:four]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:five]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:six]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:s]]
                || [one.tagIds containsObject:[NSNumber numberWithInt:e]]) {
                one.isSelect = YES;
                [sendArray addObject:one];
            }else{
                one.isSelect = NO;
                
              }
         }
   
}
//    if (sendArray.count==arrMut.count) {
//        allIndex=1;
//        self.Button0.layer.borderColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0].CGColor;
//        self.Button0.backgroundColor=[UIColor colorWithRed:0x00/255.0 green:0xb7/255.0 blue:0xee/255.0 alpha:1.0];
//        [self.Button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }else{
//        allIndex=0;
//        self.Button0.layer.borderColor=[UIColor colorWithRed:0xdd/255.0 green:0xdd/255.0 blue:0xdd/255.0 alpha:1.0].CGColor;
//        self.Button0.backgroundColor=[UIColor whiteColor];
//        [self.Button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        
//    }

    [table reloadData];
    NSLog(@"sendArray.cout 是 %lu",(unsigned long)sendArray.count);
    NSString * countStr=[NSString stringWithFormat:@"下一步(%lu/%lu)",(unsigned long)sendArray.count,(unsigned long)arrMut.count ];
    [nextButton setTitle:countStr forState:UIControlStateNormal];
}


@end
