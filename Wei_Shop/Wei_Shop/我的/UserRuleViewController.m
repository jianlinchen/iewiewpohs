//
//  UserRuleViewController.m
//  Wei_Shop
//
//  Created by Geniune on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "UserRuleViewController.h"

@interface UserRuleViewController ()<UIWebViewDelegate>

@end

@implementation UserRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.title = @"用户协议";
    
    //    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-60)];
    webView.delegate = self;
    
    [webView setScalesPageToFit:YES];
    webView.backgroundColor = [UIColor whiteColor];
    webView.opaque = NO;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    
}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//    
//    [SVProgressHUD showErrorWithStatus:@"加载出错！"];
//}

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

