//
//  Utils.m
//  UPayProject
//
//  Created by ding wei on 13-8-14.
//  Copyright (c) 2013年 wt-vrs. All rights reserved.
//

#import "Utils.h"
#import "CommonCrypto/CommonDigest.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>

@implementation Utils
+ (NSString *)RSAencryptWithString:(NSString *)content
{
    NSData *publicKey = [NSData dataFromBase64String:@"MIICjjCCAfegAwIBAgIJAN6Tuhf3as6eMA0GCSqGSIb3DQEBBQUAMGAxCzAJBgNVBAYTAkNOMRAwDgYDVQQIDAdqaWFuZ3N1MQ8wDQYDVQQHDAZzdXpob3UxDjAMBgNVBAoMBXJhaXlpMQ4wDAYDVQQLDAVyYWl5aTEOMAwGA1UEAwwFcmFpeWkwHhcNMTQwNjEwMDY1NzA0WhcNMTQwNzEwMDY1NzA0WjBgMQswCQYDVQQGEwJDTjEQMA4GA1UECAwHamlhbmdzdTEPMA0GA1UEBwwGc3V6aG91MQ4wDAYDVQQKDAVyYWl5aTEOMAwGA1UECwwFcmFpeWkxDjAMBgNVBAMMBXJhaXlpMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIeSsK0EBnu31UYxQhx8x2AEFqyEwSudXuxHd+Xz+pwc3f4USrMtyhA7MyfQws0m0bW1vbDx4Yaz97e9l0+4iWpeebI/sk1f5lxEu6tN6E1nw9NaHLQDrXb3El0MQAwIYlTZk65h0fGmEDHILCACDq3/J8c/wWRLAeWyPqaKyymwIDAQABo1AwTjAdBgNVHQ4EFgQUfGNJcCu+xsGZWNSq95ixs9TCjwEwHwYDVR0jBBgwFoAUfGNJcCu+xsGZWNSq95ixs9TCjwEwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQUFAAOBgQBCuinKcqPxVphJ3nvmodhFXKrye4wxLNepM3LtOJX+nQVJgHj0rnJ6bribTc0mq78+VjqdIh+wIo04In3ASicZFGdR1YguBYqXgJmQ2xrRMl2oo9iyaKCyZdgPTZoBncWTkFXHgz+vDkWCUi/x7nqDdLLTm5Uwcft4rUHGTcla5w=="];
    
    Byte tmpByte[8];
    int idx,jdx;
    for (idx = 0,jdx = 0; idx+2 <= content.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [content substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        //[usernamm appendBytes:intValue length:1];
        tmpByte[jdx++]=intValue;
    }
    NSData *usernamm =[NSData dataWithBytes:tmpByte length:8];
    //[[SecKeyWrapper alloc] init];
    NSData *newKey= [SecKeyWrapper encrypt:usernamm publicKey:publicKey];
    NSLog(@"$$$$$$$$$$$newKey:%@",newKey);
    Byte *bytes = (Byte *)[newKey bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[newKey length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"###########encrypted result:%@",hexStr);
    
    return hexStr;
}

+(NSString*)getCurrentTimeMillSeconds{
    NSTimeInterval time = ([[NSDate date] timeIntervalSince1970]);
    long long dTime = [[NSNumber numberWithLongLong:time*1000] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",dTime];
    return curTime;
}
+(NSString *) md5: (NSString *) inPutText{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
    
}

+(NSDate *)getDateFromServerByMSecond:(long long)time{
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSTimeInterval lv = (NSTimeInterval)time/1000;
    NSDate *newDate=[NSDate dateWithTimeIntervalSince1970:lv];
    NSTimeInterval times = [zone secondsFromGMTForDate:newDate];
    NSDate *localeDate = [newDate dateByAddingTimeInterval:times] ;
    return localeDate;
}

+(NSDate*)getDateFromString:(NSString*)ds{
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMdd"];
    return [format dateFromString:ds];
}
+(NSDate*)getDateFromNumber:(NSNumber*)ds{
    
    return [NSDate dateWithTimeIntervalSince1970:[ds longLongValue]/1000];
}



+(UIImage *)rnImage:(UIImage*)sourceImg boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = sourceImg.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    // create unchanged copy of the area inside the exclusionPath
    UIImage *unblurredImage = nil;
    if (exclusionPath != nil) {
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.frame = (CGRect){CGPointZero, sourceImg.size};
        maskLayer.backgroundColor = [UIColor blackColor].CGColor;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        maskLayer.path = exclusionPath.CGPath;
        
        // create grayscale image to mask context
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(nil, maskLayer.bounds.size.width, maskLayer.bounds.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        CGContextTranslateCTM(context, 0, maskLayer.bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        [maskLayer renderInContext:context];
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        UIImage *maskImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        
        UIGraphicsBeginImageContext(sourceImg.size);
        context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, maskLayer.bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        CGContextClipToMask(context, maskLayer.bounds, maskImage.CGImage);
        CGContextDrawImage(context, maskLayer.bounds, sourceImg.CGImage);
        unblurredImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // overlay images?
    if (unblurredImage != nil) {
        UIGraphicsBeginImageContext(returnImage.size);
        [returnImage drawAtPoint:CGPointZero];
        [unblurredImage drawAtPoint:CGPointZero];
        
        returnImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
    

}
+(BOOL)is4Screen{
    return [[UIScreen mainScreen] bounds].size.height>500;
}

+(NSString*)generateFilenameByType:(NSString*)type
{
    //设置文件名
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    NSDate *date = [NSDate date];
    NSString * s = [dateFormatter stringFromDate:date];
    int x = arc4random() % 10;
    s = [NSString stringWithFormat:@"%@%d",s,x];
    NSString* name = [s stringByAppendingPathExtension:type];
    return name;
}


+(NSString *)imagePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath=[paths objectAtIndex:0];
    
    return documentPath;
}

+(NSString *)avatarPath
{

    
    return [Utils avatarPathWithUserID:@"avatar"];
}

+(NSString *)avatarPathWithUserID:(NSString *)userID
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath=[paths objectAtIndex:0];
    documentPath = [documentPath stringByAppendingPathComponent:@"avatars"];
    NSFileManager* manager = [NSFileManager defaultManager];
    BOOL isd;
    BOOL isEx = [manager fileExistsAtPath:documentPath isDirectory:&isd];
    if (!isEx) {
        [manager createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:Nil error:nil];
    }
    documentPath = [documentPath stringByAppendingFormat:@"/%@.jpg",userID];
    return documentPath;
}


+(CLLocationCoordinate2D)coordinateFronString:(NSString *)string
{
    NSArray* array = [string componentsSeparatedByString:@","];
    
    return CLLocationCoordinate2DMake([array[0] doubleValue], [array[1] doubleValue]);
}



+(id)ifNullToNil:(id)objc
{
    if ([objc isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return objc;
}


+(BOOL)isValidEmail:(NSString*)email{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3|7[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+(void)addBack2Navigationitem:(UINavigationItem*)item sel:(SEL)sel res:(id)res andimage:(NSString*)imageStr{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 80, 40)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 11, 20)];
    image.image = [UIImage imageNamed:@"navbacknew"];
    [leftView addSubview:image];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [leftBtn addTarget:res action:sel forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    item.leftBarButtonItem = left;
    
}

+(void)alertView:(NSString *)title{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
}

+(UIView *)getScoreView:(float)score hight:(CGRect)frame havelable:(BOOL)have{
    int h = frame.size.height;
    
    if (score == 0) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, h*(4 + 1)+5+40, h)];
        for (int a = 0; a < 5; a++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5+h*a, 2, h-4, h-4)];
            image.image = [UIImage imageNamed:@"nosore"];
            [v addSubview:image];
        }
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake( h*(4 + 1)+5, 0, 40, h)];
        lable.font = [UIFont systemFontOfSize:10.0];
        lable.text = @"-分";
        if (have) {
            [v addSubview:lable];
        }
        
        
        return v;
    }
    
    
    NSString *s = [NSString stringWithFormat:@"%f",score];
    int ss = [s intValue];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, h*(ss + 1)+5+40, h)];
    
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake( h*(ss + 1)+5, 0, 40, h)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake( h*6+5, 0, 40, h)];
    lable.font = [UIFont systemFontOfSize:10.0];
    lable.text = [NSString stringWithFormat:@"%.1f分",score];
    if (have) {
        [view addSubview:lable];
    }
    
    
    for (int a = 0; a < ss; a++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5+h*a, 2, h-4, h-4)];
        image.image = [UIImage imageNamed:@"havesore"];
        [view addSubview:image];
    }
    if (score == ss) {
        
        for (int a = ss; a < 5;  a ++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5+h*a, 2, h-4, h-4)];
            image.image = [UIImage imageNamed:@"nosore"];
            [view addSubview:image];
        }
        
        
    }else{
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5+h*ss, 2, h-4, h-4)];
        image.image = [UIImage imageNamed:@"nosore_1"];
        [view addSubview:image];
        
        
        for (int a = ss + 1; a < 5;  a ++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(5+h*a, 2, h-4, h-4)];
            image.image = [UIImage imageNamed:@"nosore"];
            [view addSubview:image];
        }
        
    }
    
    
    
    return view;
    
}


- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3|7[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
