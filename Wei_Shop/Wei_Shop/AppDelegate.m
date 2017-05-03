//
//  AppDelegate.m
//  Wei_Shop
//
//  Created by dzr on 15/10/29.
//  Copyright (c) 2015年 cjl. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CustomViewController.h"
#import "MyViewController.h"
#import "GlobarManager.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "IQKeyboardManager.h"
#import "MobClick.h"
@interface AppDelegate (){
    NSString *strban;
    NSString *urlurl;
    NSString *uu;//获取当前版本
    
    NSString *forcedString;
}
@property (nonatomic, strong) UITabBarController *bar;
@property (nonatomic, strong) UINavigationController *LoginNav;
@end

@implementation AppDelegate
@synthesize bar;
@synthesize LoginNav;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MobClick startWithAppkey:@"565e411de0f55a5b37004189" reportPolicy:BATCH   channelId:nil];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [GlobarManager OpenFMDataBase];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    uu = [NSString stringWithFormat:@"V%@", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];


    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:Account];
    if(account == nil || [account isEqualToString:@""]){
        
        [[GlobarManager shareInstance] ResigterDevice];
    }
    [[GlobarManager shareInstance] requestPublicKeyCallback:^(NSString *obj) {
        
    }];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,
                                [UIFont systemFontOfSize:21],
                                NSFontAttributeName,nil];
    if (IOS7) {
        [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"2_nav"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        
    }else
    {
        [[UINavigationBar appearance] setTintColor:MAIN_COLOR];
        [[UINavigationBar appearance]setBackgroundColor:MAIN_COLOR];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (mytest:) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (autoLoginFail:) name:@"LoginFail" object:nil];
  
//  [self chekVer];
    [self setupLoginView];
    return YES;
}

//-(void)chekVer{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         nil];
//    [HttpRequest getWebData:[GLOBARMANAGER AppKeyDic:dic] path:CheckVersion method:@"GET" success:^(id object) {
//        if (object) {if ([[object objectForKey:@"success"]intValue] == 1) {
//            NSDictionary * dic= [object objectForKey:@"result"];
//            
//            if (![dic isKindOfClass:[NSNull class]]) {
//                NSString *qq=dic [@"versionNO"];
//                strban=[NSString stringWithFormat:@"V%@",qq];
//                urlurl=dic[@"versionURL"];
//                forcedString=[NSString stringWithFormat:@"%@", dic[@"isForced"]];
//            }
////            NSString *qq=dic [@"versionNO"];
////            strban=[NSString stringWithFormat:@"V%@",qq];
////            urlurl=dic[@"versionURL"];
////           forcedString=[NSString stringWithFormat:@"%@", dic[@"isForced"]];
//            
//            if ([uu isEqualToString:strban]) {
//                
//                
//            }else{
//                 UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"有新版本，确定下载？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [alert1 show];
//
//            }
//            
//         }
//        }
//    } fail:^(NSString *msg) {
//        
//    }];
//}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//
//{
//    if (buttonIndex ==1) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlurl]];
////        NSLog(@"!2");
//    }else{
//        if ([forcedString  isEqualToString:@"0"]) {
//  
//        }else if([forcedString  isEqualToString:@"1"]) {
//            AppDelegate *app = [UIApplication sharedApplication].delegate;
//            UIWindow *window = app.window;
//            
//            [UIView animateWithDuration:1.0f animations:^{
//                window.alpha = 0;
//                window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//            } completion:^(BOOL finished) {
//                exit(0);
//            }];
//            //exit(0);
//        }
//      
//    }
//}

//自动登录失败全局通知调用
- (void)autoLoginFail:(id)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:Password];
    [self setupLoginView];
}

- (void)mytest:(id)sender{
    
    [self setupLoginView];
}

- (void)setupLoginView{
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    if (![reach isReachable]) {
//        [Utils alertView:@"网络异常,请检查网络连接!"];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        if(LoginNav != nil){
            self.window.rootViewController = LoginNav;
            [self.window makeKeyAndVisible];
        }else{
            LoginViewController *LoginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            LoginNav = [[UINavigationController alloc]initWithRootViewController:LoginVC];
            self.window.rootViewController = LoginNav;
            [self.window makeKeyAndVisible];
        }

        return;
    }

    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:Account];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:Password];
    
    
    if(account && ![account isEqualToString:@""] && passWord && ![passWord isEqualToString:@""]){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self setupTabbar];
        
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        if(LoginNav != nil){
            self.window.rootViewController = LoginNav;
            [self.window makeKeyAndVisible];
        }else{
            LoginViewController *LoginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            LoginNav = [[UINavigationController alloc]initWithRootViewController:LoginVC];
            self.window.rootViewController = LoginNav;
            [self.window makeKeyAndVisible];
        }
    }
}

- (void)setupTabbar{
    
    // Override point for customization after application launch.
    
    if(bar != nil){
        
        self.window.rootViewController = bar;
        bar.selectedIndex = 0;
        [self.window makeKeyAndVisible];
    
    }else{
    
    bar = [[UITabBarController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    HomeViewController *hom= [[ HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    CustomViewController *cus= [[CustomViewController alloc]initWithNibName:@"CustomViewController" bundle:nil];
    MyViewController *my =[[MyViewController alloc]initWithNibName:@"MyViewController" bundle:nil];
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:hom];
    
    UIImage *imageNormal1 = [UIImage imageNamed:@"house"];
    imageNormal1 = [imageNormal1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSelected1 = [UIImage imageNamed:@"house-selected"];
    imageSelected1 = [imageSelected1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageNormal2 = [UIImage imageNamed:@"smile"];
    imageNormal2 = [imageNormal2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSelected2 = [UIImage imageNamed:@"smile-selected"];
    imageSelected2 = [imageSelected2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageNormal3 = [UIImage imageNamed:@"me"];
    imageNormal3 = [imageNormal3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *imageSelected3 = [UIImage imageNamed:@"me-selected"];
    imageSelected3 = [imageSelected3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    nav1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:imageNormal1 selectedImage:imageSelected1];
  
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:cus];
    nav2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"客户" image:imageNormal2 selectedImage:imageSelected2];
    
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:my];
    nav3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:imageNormal3 selectedImage:imageSelected3];
    
    
    bar.viewControllers = @[nav1,nav2,nav3];
    
    
    //    bar.tabBar.tintColor = MAIN_COLOR;
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],                                                                                                            UITextAttributeTextColor,[UIFont systemFontOfSize:10.0],UITextAttributeFont, nil]
                                             forState:UIControlStateNormal];

    
    [[UITabBarItem appearance] setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor blackColor],
    UITextAttributeTextColor,[UIFont systemFontOfSize:15.0],UITextAttributeFont, nil] forState:UIControlStateSelected];
    
    self.window.rootViewController = bar;
    
    [self.window makeKeyAndVisible];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end