//
//  IOSScanView.m
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "IOSScanView.h"

@interface IOSScanView()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong)AVCaptureDevice *               device;
@property (nonatomic,strong)AVCaptureDeviceInput *          input;
@property (nonatomic,strong)AVCaptureMetadataOutput *       output;
@property (nonatomic,strong)AVCaptureSession *              session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *    preview;
@property (nonatomic,assign)BOOL                            running;

@property (nonatomic,assign)BOOL                            codeing;

@end

@implementation IOSScanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setupCaptureSession];
    }
    return self;
}

- (void)setupCaptureSession {
    
    if (_session) return;
    
    _device = [AVCaptureDevice
                    defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!_device) {
        NSLog(@"No video camera on this device!");
        return;
    }
    
    _input = [[AVCaptureDeviceInput alloc]
                   initWithDevice:_device error:nil];

    // capture and process the metadata
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat scanWidth = self.frame.size.width/2+100;
    
    [ _output setRectOfInterest : CGRectMake ((self.frame.size.height-scanWidth-80)/(2*self.frame.size.height),(self.frame.size.width - scanWidth )/(2*self.frame.size.width) , scanWidth / self.frame.size.height , scanWidth / self.frame.size.width )];
    
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    
    _preview = [[AVCaptureVideoPreviewLayer alloc]
                initWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _preview.frame = self.frame;
    
    [self.layer insertSublayer:self.preview atIndex:0];
    
    [self startRunning];
}

- (void)startRunning {
    _codeing = YES;
    if (_running) return;
    
    _output.metadataObjectTypes = @[AVMetadataObjectTypeCode39Code,
                                  AVMetadataObjectTypeCode128Code,
                                  AVMetadataObjectTypeCode39Mod43Code,
                                  AVMetadataObjectTypeEAN13Code,
                                  AVMetadataObjectTypeEAN8Code,
                                  AVMetadataObjectTypeCode93Code,
                                  AVMetadataObjectTypeQRCode];
    
    [_session startRunning];
    _running = YES;
}

- (void)stopRunning {
    _codeing = NO;
    if (!_running) return;
    [_session stopRunning];
    _running = NO;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (!_codeing) return;
    
    [metadataObjects
     enumerateObjectsUsingBlock:^(AVMetadataObject *obj,
                                  NSUInteger idx,
                                  BOOL *stop)
     {
         if ([obj isKindOfClass:
              [AVMetadataMachineReadableCodeObject class]])
         {
            AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
            NSString *stringValue = metadataObject.stringValue;

             //判断回传的数据类型
             //EAN-13是13位的  UPC-A是12位的 有些UPC-A前加0就是EAN-13(默认隐藏一个0)
             //UPC-A条码与前置码为“0”的EAN-13码兼容
             if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeEAN13Code]) {
                 if([[stringValue substringToIndex:1] isEqualToString:@"0"])
                 {
                     stringValue = [stringValue substringFromIndex:1];
                 }
             }
             
            if (self.delegate) {
                _codeing = NO;
                [self.delegate IOSScanResult:stringValue WithType:[metadataObject type]];
            }
         }
     }];
}

@end