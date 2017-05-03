//
//  AgremmentController.m
//  Wei_Shop
//
//  Created by dzr on 15/12/10.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "AgremmentController.h"

@interface AgremmentController ()<UIWebViewDelegate>

@end

@implementation AgremmentController

- (void)viewDidLoad {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-10, 0, 20, 15);
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    self.agreeWebView.delegate = self;
    
    [self.agreeWebView setScalesPageToFit:YES];
    self.agreeWebView.backgroundColor = [UIColor whiteColor];
    self.agreeWebView.opaque = NO;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:OurWebUrl]];
    [self.agreeWebView loadRequest:request];
    
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
//    
//    [SVProgressHUD showErrorWithStatus:@"加载出错！"];
//}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
};//开始加载的时候执行该方法。
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
};//加载完成的时候执行该方法。
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
- (void)loadNewData{
    
    
}
-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
