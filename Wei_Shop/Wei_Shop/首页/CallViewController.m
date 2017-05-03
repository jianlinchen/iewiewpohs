//
//  CallViewController.m
//  Weimei
//
//  Created by xujt@iwellfie.net on 15/5/20.
//  Copyright (c) 2015年 xujt@iwellfie.net. All rights reserved.
//
#import "IQKeyboardManager.h"
#import "SBJsonParser.h"

#import "CallViewController.h"
#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import "Message.h"
#import "AppDelegate.h"

#define V_H APP_H - 44

@interface CallViewController ()<UUInputFunctionViewDelegate,UUMessageCellDelegate,UITableViewDataSource,UITableViewDelegate>{
     BOOL _wasKeyboardManagerEnabled;
}

@property (strong, nonatomic) ChatModel *chatModel;
@property (nonatomic, assign)int pageNo;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CallViewController{
    UUInputFunctionView *IFView;
   int ppp;
    
    NSTimer *time;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.title = @"沈医生";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = self.shopName;
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self.dataArray addObjectsFromArray:[ChatModel getHistoryListWithShopId:GLOBARMANAGER.userConfig.shopId andUserId:self.userid]];
    
//    self.dataArray add
    
    [self loadBaseViewsAndData];
    
    self.chatTableView.frame = CGRectMake(0, 0, APP_W, V_H - IFView.frame.size.height);
//    self.chatTableView.frame=CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.title = self.userName == nil?@"":self.userName;
   self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadView) name:@"reloadData" object:nil];
    
    
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
  [self addRefresh];
}
-(void)addRefresh{
    
    __weak __typeof(self) weakSelf = self;
    
    [self loadUnReadList];
    
    MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.pageNo = 1;

        [self.chatTableView.header endRefreshing];
        
    }];
    
    header.lastUpdatedTimeLabel.hidden=YES;
    header.stateLabel.hidden=YES;
    self.chatTableView.header=header;
    //    self.mjTableView.header.lastUpdatedTime
    self.chatTableView.header.automaticallyChangeAlpha = YES;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     //禁用iq键盘
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    time = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(addRefresh) userInfo:nil repeats:YES];


}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    NSDictionary*info=[notification userInfo];
    
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
 
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        IFView.frame = CGRectMake(0, V_H - IFView.frame.size.height - kbSize.height, APP_W, IFView.frame.size.height);
        self.chatTableView.frame = CGRectMake(0, 0, APP_W, V_H - kbSize.height - IFView.frame.size.height);
        
        if (self.dataArray.count != 0){
        
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1==-1?0:self.dataArray.count - 1 inSection:0];
            [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
  
}
- (void)keyboardWillHide:(NSNotification *)notification{
    
    NSDictionary*info=[notification userInfo];
//    
//    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        IFView.frame = CGRectMake(0, V_H - IFView.frame.size.height, APP_W, IFView.frame.size.height);
        self.chatTableView.frame = CGRectMake(0, 0, APP_W, V_H - IFView.frame.size.height);
        if (self.dataArray.count != 0){
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1==-1?0:self.dataArray.count - 1 inSection:0];
            [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
    [self tableViewScrollToBottom];
}


-(void)reloadView{
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //启用iq键盘
     [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [time invalidate];
    time = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadBaseViewsAndData
{
    
    
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    
    IFView.frame = CGRectMake(0, V_H - IFView.frame.size.height, APP_W, IFView.frame.size.height);
    
    IFView.delegate = self;
    [self.view addSubview:IFView];
    
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
    
    
    
}


//tableView Scroll to bottom
- (void)tableViewScrollToBottom
{
    if (self.dataArray.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1==-1?0:self.dataArray.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - InputFunctionViewDelegate
#pragma mark - 发送文字消息
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message
{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"userId":self.userid,@"content":message,@"contentType":@"TEXT"};
    
    [HttpRequest getData:[GLOBARMANAGER AppKeyTokenDic:dic] path:SendChat method:@"GET" success:^(id object) {
        
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                IFView.TextViewInput.text = @"";
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                
                if(object[@"result"] && object[@"result"][@"id"]){
                NSDictionary *Dic =  @{@"content":message, @"msgContentType":@"TEXT",@"id":object[@"result"][@"id"],@"msgUserId":self.userid,@"msgUserName":self.userName,@"sendTime":[GlobarManager NSdateToString]};
                
                [self.dataArray addObject:[ChatModel generateUUMessageFrame:Dic flag:NO]];
                    
                [self.chatTableView reloadData];
                [self tableViewScrollToBottom];
                    
                    [DataBaseManager deleteUnReadList:self.userDic[@"senderId"] Completed:^(id obj) {
                        [DataBaseManager insertUnReadListToDB:StrFromObj(self.userDic[@"senderId"]) senderName:StrFromObj(self.userDic[@"senderName"]) senderIcon:StrFromObj(self.userDic[@"senderIcon"]) content:message lastSendTime:StrFromObj(self.userDic[@"lastSendTime"])];
                    }];
                }
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"发送失败"];
            }
        }
    } fail:^(NSString *msg) {
            
    }];
}

#pragma mark - 发送图片消息
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendPicture:(UIImage *)image{
    
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"userId":self.userid,@"contentType":@"IMG",@"content":@""};
    
    [HttpRequest uploadImage:[GLOBARMANAGER AppKeyTokenDic:dic] path:SendChat image:@[image] file:@"image" success:^(id object) {
        
        if(object[@"result"] && object[@"result"][@"id"]){
            if([object[@"success"] intValue] == 1){
                
                NSDictionary *Dic =  @{@"content":object[@"result"][@"imgUrl"], @"msgContentType":@"IMG",@"id":object[@"result"][@"id"],@"msgUserId":self.userid,@"msgUserName":self.userName,@"sendTime":[GlobarManager NSdateToString]};
                
                [self.dataArray addObject:[ChatModel generateUUMessageFrame:Dic flag:NO]];
                [self.chatTableView reloadData];
                [self tableViewScrollToBottom];
                
                [DataBaseManager deleteUnReadList:self.userDic[@"senderId"] Completed:^(id obj) {
                    [DataBaseManager insertUnReadListToDB:StrFromObj(self.userDic[@"senderId"]) senderName:StrFromObj(self.userDic[@"senderName"]) senderIcon:StrFromObj(self.userDic[@"senderIcon"]) content:@"[图片]" lastSendTime:StrFromObj(self.userDic[@"lastSendTime"])];
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:@"发送失败"];
            }
        }
        
    } fail:^(NSString *msg) {
        
    }];
    
}



- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    NSDictionary *dic = @{@"voice": voice,
                          @"strVoiceTime": [NSString stringWithFormat:@"%d",(int)second],
                          @"type": @(UUMessageTypeVoice)};
    [self dealTheFunctionData:dic];
}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    NSLog(@"%lu",(unsigned long)self.chatModel.dataSource.count);
    return self.dataArray.count;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (cell == nil) {
        cell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        cell.delegate = self;
    }
    
    [cell setMessageFrame:self.dataArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataArray[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate
- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId{
    // headIamgeIcon is clicked
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.messageFrame.message.strName message:@"headImage clicked" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil];
    [alert show];
}

- (void)loadUnReadList{
    
    [ChatModel getIMList:1 userId:self.userid success:^(id obj) {
        
        [self.dataArray addObjectsFromArray:obj];
        
        [self.chatTableView reloadData];
        [self tableViewScrollToBottom];
        
    } failure:^(NSString *error) {
        
        
        
    }];
}



@end
