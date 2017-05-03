//
//  ScanReaderViewController.m
//  PickVIew(省市选择）
//
//  Created by 李坚 on 15/10/30.
//  Copyright © 2015年 cjl. All rights reserved.
//

#import "ScanReaderViewController.h"
#import "IOSScanView.h"
#import "CouponDetailViewController.h"
#import "AddClientController.h"

/**
 *  选用条码扫描工具(注意放入公用头文件中，方便修改）
 */
//#define USE_ZBAR    //启用Zbar
#define USE_ZIOS    //启用源生


@interface ScanReaderViewController ()<IOSScanViewDelegate>{
    
    IOSScanView     *iosScanView;
    
    NSTimer         *timer;
    BOOL            torchIsOn;//闪光灯开关
    UIButton *lightBtn;
}

@end

@implementation ScanReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    //默认关闭闪光灯
    torchIsOn = NO;
    CGRect rect = CGRectMake(0, 0, APP_W, APP_H + 20);
    
    if(iOSv7)
    {
        iosScanView = [[IOSScanView alloc] initWithFrame:rect];
        iosScanView.delegate = self;
        [self.view addSubview:iosScanView];
    }else{
        
        
//#ifdef USE_ZBAR
//        zBarScanView = [[ZBarScanView alloc] initWithFrame:rect];
//        zBarScanView.delegate = self;
//        [self.view addSubview:zBarScanView];
//#endif
        
#ifdef USE_ZIOS
        iosScanView = [[IOSScanView alloc] initWithFrame:rect];
        iosScanView.delegate = self;
        [self.view addSubview:iosScanView];
#endif
    }
    
    [self configureReadView];
    [self setupTorchBarButton];
    [self setupDynamicScanFrame];
}

- (void)configureReadView
{
    UILabel *desrciption = [[UILabel alloc] initWithFrame:CGRectMake(60, 380, APP_W, 35)];
//    CGPoint point = CGPointMake(APP_W/2, self.view.center.y - 180);
    CGPoint point = CGPointMake(APP_W/2, 70);
    desrciption.center = point;
    desrciption.textColor = [UIColor yellowColor];
    desrciption.textAlignment = NSTextAlignmentCenter;
    if ([self.fromcouSto isEqualToString:@"111"]) {
          desrciption.text = @"请扫描微美薇用户端二维码";
    }else{
          desrciption.text = @"请扫描微美薇端二维码";
    }
    [self.view addSubview:desrciption];
}

- (void)setupTorchBarButton
{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"闪电-原"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleTorch:)];

    lightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 19, 47)];
    [lightBtn setImage:[UIImage imageNamed:@"闪电-原"] forState:UIControlStateNormal];
    [lightBtn addTarget:self action:@selector(toggleTorch:) forControlEvents:UIControlEventTouchUpInside];
    
    rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:lightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)toggleTorch:(id)sender
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!torchIsOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [lightBtn setImage:[UIImage imageNamed:@"闪电-开"] forState:UIControlStateNormal];
                torchIsOn = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                torchIsOn = NO;
                [lightBtn setImage:[UIImage imageNamed:@"闪电-原"] forState:UIControlStateNormal];
            }
            [device unlockForConfiguration];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (iosScanView) {
        [iosScanView startRunning];
    }
   
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    if (iosScanView) {
        [iosScanView stopRunning];
    }
 
}

- (void)setupDynamicScanFrame
{
    float backalpha = 0.0;
    
    CGFloat scanWidth = APP_W/2+100;
    
    CGRect viewRect1 = CGRectMake(0,0, (APP_W - scanWidth )/ 2, APP_H);
    UIView* view1 = [[UIView alloc] initWithFrame:viewRect1];
    [view1 setBackgroundColor:[UIColor blackColor]];
    view1.alpha = backalpha;
    [self.view addSubview:view1];
    
    CGRect viewRect2 = CGRectMake((APP_W - scanWidth )/ 2,0, scanWidth, 124);
    UIView* view2 = [[UIView alloc] initWithFrame:viewRect2];
    [view2 setBackgroundColor:[UIColor blackColor]];
    view2.alpha = backalpha;
    [self.view addSubview:view2];
    
    CGRect viewRect3 = CGRectMake((APP_W - scanWidth )/2+scanWidth,0, (APP_W - 220 )/ 2, APP_H);
    UIView* view3 = [[UIView alloc] initWithFrame:viewRect3];
    [view3 setBackgroundColor:[UIColor blackColor]];
    view3.alpha = backalpha;
    [self.view addSubview:view3];
    
    CGRect viewRect4 = CGRectMake((APP_W - scanWidth )/ 2,124+scanWidth, scanWidth, APP_H-124-220);
    UIView* view4 = [[UIView alloc] initWithFrame:viewRect4];
    [view4 setBackgroundColor:[UIColor blackColor]];
    view4.alpha = backalpha;
    [self.view addSubview:view4];
    
    
    CGRect scanMaskRect = CGRectMake((APP_W - scanWidth )/ 2,124, scanWidth, scanWidth);
    UIImageView *scanImage = [[UIImageView alloc] initWithFrame:scanMaskRect];
    [scanImage setImage:[UIImage imageNamed:@"扫描框"]];
    [self.view addSubview:scanImage];
    
    UIImageView *scanLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanWidth, 6)];
    [scanLineImage setImage:[UIImage imageNamed:@"扫描线"]];
    scanLineImage.center = CGPointMake(APP_W/2, scanImage.frame.origin.y);
    [self.view addSubview:scanLineImage];
    
    [self runSpinAnimationOnView:scanLineImage duration:3 positionY:scanWidth repeat:CGFLOAT_MAX];
}

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration positionY:(CGFloat)positionY repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: positionY];
    rotationAnimation.duration = duration;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    rotationAnimation.autoreverses = YES;
    [view.layer addAnimation:rotationAnimation forKey:@"position"];
}

#pragma mark - 源生扫码结果回调
- (void) IOSScanResult: (NSString*) scanCode WithType:(NSString *)type{
    [self confirmConsumptionWithCode:scanCode];
}
#pragma mark - ZBar扫码结果回调
- (void) ZBarScanResult: (NSString*) scanCode{
    [self confirmConsumptionWithCode:scanCode];
}


#pragma mark - 具体业务逻辑处理
- (void)confirmConsumptionWithCode:(NSString *)scanCode
{
    
    // Do any additional setup after scan code
    NSLog(@"扫到的条码 ===>%@",scanCode);
    if ([self.fromcouSto isEqualToString:@"111"]) {
        
        [self addClient:scanCode];
    }else{
//        [self CouponQuanInfo:scanCode];
         [self deternClienOrCoupon:scanCode];
        
    }
}

-(void)deternClienOrCoupon:(NSString *)scanCode{
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"scanData":scanCode};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyDic:dic] path:ScanOr method:@"GET" success:^(id object) {
        if (object) {
            if ([[object objectForKey:@"success"]intValue] == 1) {
               NSDictionary *dic= [object objectForKey:@"result"];;
                NSString *orStr=[dic objectForKey:@"type"];
                if ([orStr isEqualToString:@"USERCODE"]) {
                    [self addClient:scanCode];
                }else{
                     [self CouponQuanInfo:scanCode];
                }
            }else{
                
                [SVProgressHUD showErrorWithStatus:object[@"error"][@"extDesc"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:@"二维码错误"];
    }];

    
}
//扫用户二维码

-(void)addClient:(NSString *)clientStr{
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"authCode":clientStr};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:ScanCustomer method:@"GET" success:^(id object) {
        if (object) {
            if ([[object objectForKey:@"success"]intValue] == 1) {
                
                AddClientController *qc = [[AddClientController alloc]initWithNibName:@"AddClientController" bundle:nil];
                [qc setHidesBottomBarWhenPushed:YES];
                qc.dic = [object objectForKey:@"result"];;
                qc.str = clientStr;
                [self.navigationController pushViewController:qc animated:YES];
                
            }else{
             
                [SVProgressHUD showErrorWithStatus:object[@"error"][@"extDesc"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:@"二维码错误"];
    }];
 
}



//扫码/输入兑换码
- (void)CouponQuanInfo:(NSString *)couponStr{
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"verifyCode":couponStr};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:Verifyinfo method:@"GET" success:^(id object) {
        if(object && [object isKindOfClass:[NSDictionary class]]){
            
            if([[object objectForKey:@"success"] intValue] == 1){
                
                CouponDetailViewController *VC = [[CouponDetailViewController alloc]initWithNibName:@"CouponDetailViewController" bundle:nil];
                VC.couponDetail = [object objectForKey:@"result"];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                 [iosScanView stopRunning];
                [SVProgressHUD showErrorWithStatus:object[@"error"][@"extDesc"]];
                [self.navigationController popViewControllerAnimated:YES];
//                UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:object[@"error"][@"extDesc"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                
//                [alert1 show];

            }
        }
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [iosScanView startRunning];
}

@end
