//
//  ScanViewController.m
//  Wei_Shop
//
//  Created by dzr on 15/11/4.
//  Copyright © 2015年 cjl. All rights reserved.
//
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#import "ScanViewController.h"
#import "AddClientController.h"
@interface ScanViewController (){
    BOOL scan;
}


@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(55, 370, 240, 50)];
    labIntroudction.font=[UIFont systemFontOfSize:13.0f];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码放入方框内，即可自动扫描";
    [self.view addSubview:labIntroudction];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 75, 240, 260)];
    imageView.image = [UIImage imageNamed:@"2_saomiao"];
    [self.view addSubview:imageView];
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (2*num == 240) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    //  [self dismissViewControllerAnimated:YES completion:^{
    [timer invalidate];
    //    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self checkAVAuthorizationStatus];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    [_session stopRunning];
}
- (void)checkAVAuthorizationStatus{
    //    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //
    //    if(status == AVAuthorizationStatusAuthorized) {
    //    authorized
    [self setupCamera];
    //
    //} else {
    //    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许微美薇商家访问你的相机。" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    //
    //    [alert1 show];
    //
    //}
}
- (void)setupCamera
{
    // Device //获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input//创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output //创建输出流
    _output = [[AVCaptureMetadataOutput alloc]init];
    
    //设置代理 在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session//初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    
    
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,KScreenWidth,KScreenHeight);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    // Start
    [_session startRunning];
    
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
     [_session stopRunning];
    
    
    NSDictionary *dic = @{@"shopId":GLOBARMANAGER.userConfig.shopId,@"authCode":stringValue};
    
    [HttpRequest getWebData:[GLOBARMANAGER AppKeyTokenDic:dic] path:ScanCustomer method:@"GET" success:^(id object) {
        if (object) {
            if ([[object objectForKey:@"success"]intValue] == 1) {
               
                AddClientController *qc = [[AddClientController alloc]initWithNibName:@"AddClientController" bundle:nil];
                [qc setHidesBottomBarWhenPushed:YES];
                qc.dic = [object objectForKey:@"result"];;
                qc.str = stringValue;
                [self.navigationController pushViewController:qc animated:YES];
                
            }else{
                UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"二维码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                   [alert1 show];
//                [SVProgressHUD showErrorWithStatus:@"二维码错误"];
            }
        }
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:@"二维码错误"];
    }];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_session startRunning];
}
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
