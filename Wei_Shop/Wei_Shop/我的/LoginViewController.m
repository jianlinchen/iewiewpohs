//
//  LoginViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/2.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "LoginViewController.h"
#import "RYRsaSign.h"
#import "RSA.h"
#import "UserConstant.h"
#import "UserRuleViewController.h"
#import "Reachability.h"
#import "AgremmentController.h"
#import "KeyboardManager.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface LoginViewController ()<UIActionSheetDelegate>{
    BOOL _wasKeyboardManagerEnabled;
}
@property (weak, nonatomic) IBOutlet UITextField *acount;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.acount.layoutGuides = NO;
    
//    self.passWord.tintColor=[UIColor redColor];
    if (IOS7)
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
        [self setExtendedLayoutIncludesOpaqueBars:NO];
    }
    self.passWord.secureTextEntry = YES;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 4.0f;
    [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];

    [self loadImage];
}
-(void) loadImage{
    NSMutableArray *photos = [NSMutableArray array];
    
    for (int i = 0 ; i < 4; i++) {
        //传递数据给浏览器
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        //            PicModelJL *browerModel=self.scanArray[i];
        
        photo.image = [UIImage imageNamed:@"Defaut.png"];
        NSLog(@"%@====%d",photo.image,i);
        
        [photos addObject:photo];
    }
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = photos;
    
    //3.设置默认显示的图片索引
//    brower.currentPhotoIndex = indexPath.row;
    
    //4.显示浏览器
    [brower show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:Account];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:Password];
    
    
    if (self.acount.text.length==0) {
        if(account && ![account isEqualToString:@""]){
        self.acount.text = account;
      }else{
        self.acount.text = @"";
      }
 
    }
    if (self.passWord.text.length==0) {
        
               if(passWord && ![passWord isEqualToString:@""]){
        self.passWord.text = passWord;
    }else{
        self.passWord.text = @"";
    }   
        
    }
     [self.navigationController setNavigationBarHidden:YES animated:NO];

}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    
//}
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
     [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //启用iq键盘
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    
}
////UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-30,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

////键盘下移
-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
    float Y = 00.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.acount resignFirstResponder];
    [self.passWord resignFirstResponder];
    [self resumeView];

    //    if (p==1 ) {
    //         [self resumeView];
    //    }
    
}

- (void)loginAction{
    
    
    if([self.acount.text isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    if([self.passWord.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    if (![reach isReachable]) {
        [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
       
        return;
    }

    
    NSString *public = [[NSUserDefaults standardUserDefaults] objectForKey:PublicKey];
    BOOL deviceRes = [[NSUserDefaults standardUserDefaults] boolForKey:ResigteDevice];
    
    if(public == nil || [public isEqualToString:@""] || !deviceRes){
        
        if(!deviceRes){
            [SVProgressHUD showErrorWithStatus:@"正在重新注册设备"];
            [GLOBARMANAGER ResigterDevice];
        }
        
        if(!public || [GLOBARMANAGER.publicKey isEqualToString:@""]){
            [SVProgressHUD showErrorWithStatus:@"正在获取PublicKey"];
            [GLOBARMANAGER requestPublicKeyCallback:^(NSString *obj) {
                
            }];
        }
        return;
        
    }else{
        [self login];
    }
    
}

#pragma mark - 登录接口调用
- (void)login{
    
//    self.loginBtn.enabled = NO;

        [GLOBARMANAGER loginHTTPAccount:self.acount.text password:self.passWord.text Success:^(id obj) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
//            self.loginBtn.enabled = YES;
        } failure:^(NSString *msg) {
//            [SVProgressHUD showErrorWithStatus:msg];
//            self.loginBtn.enabled = YES;
        }];
   
}
- (IBAction)userRule:(id)sender {
    AgremmentController *control = [[AgremmentController alloc]initWithNibName:@"AgremmentController" bundle:nil];
    control.title=@"用户协议";
    [self.navigationController pushViewController:control animated:YES];
    
  
}
- (IBAction)connectUs:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:OurTelNumber, nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",OurTelNumber]]];
    }
}

@end
