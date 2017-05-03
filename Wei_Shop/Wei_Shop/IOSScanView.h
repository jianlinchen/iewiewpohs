//
//  IOSScanView.h
//  APP
//
//  Created by qw on 15/2/27.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol IOSScanViewDelegate < NSObject >

- (void) IOSScanResult: (NSString*) scanCode WithType:(NSString *)type;

@end

@interface IOSScanView : UIView<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic ,weak) id<IOSScanViewDelegate>         delegate;

- (void)startRunning;
- (void)stopRunning;

@end