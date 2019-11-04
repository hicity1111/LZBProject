//
//  UIImage+QRCode.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UIImage+QRCode.h"


// inputCorrectionLevel对应四个容错率（如下），容错率越大，允许二维码污损的面积越大；
static NSString *QiInputCorrectionLevelL = @"L";    // L: 7%
static NSString *QiInputCorrectionLevelM = @"M";    // M: 15%
static NSString *QiInputCorrectionLevelQ = @"Q";    // Q: 25%
static NSString *QiInputCorrectionLevelH = @"H";    // H: 30%


@implementation UIImage (QRCode)

/// 生成二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)codeStr withSize:(CGSize)size {
    NSData *codeData = [codeStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *inputPara = @{@"inputMessage": codeData,
                                @"inputCorrectionLevel": QiInputCorrectionLevelH};
    // 使用 CIQRCodeGenerator 创建 filter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"
                            withInputParameters:inputPara];
    // 由 filter.outputImage 直接转成的UIImage不太清楚，需要做高清处理
    
    UIImage *codeImage = [UIImage scaleImage:filter.outputImage
                                      toSize:size];
    
    return codeImage;
}

/// 生成条形码
+ (UIImage *)generateCode128:(NSString *)code size:(CGSize)size {
    
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    // inputMessage: 要生成的条形码数据
    // inputQuietSpace: 条形码留白距离
    // inputBarcodeHeight: 条形码高度；
    NSDictionary *inputPara = @{@"inputMessage": codeData,
                                @"inputQuietSpace": @.0};
    //  使用CICode128BarcodeGenerator创建filter
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"
                            withInputParameters:inputPara];
    // 由filter.outputImage直接转成的UIImage不太清楚，需要做高清处理
    UIImage *codeImage = [UIImage scaleImage:filter.outputImage
                                      toSize:size];
    
    return codeImage;
}



/// 缩放图片(生成高质量图片）
+ (UIImage *)scaleImage:(CIImage *)image
                 toSize:(CGSize)size {
    
    //! 将CIImage转成CGImageRef
    CGRect integralRect = image.extent;
    // CGRectIntegral(image.extent); // 将rect取整后返回，origin取舍，size取入
    CGImageRef imageRef = [[CIContext context] createCGImage:image fromRect:integralRect];
    
    //! 创建上下文
    // 计算需要缩放的比例
    CGFloat sideScale = fminf(size.width / integralRect.size.width, size.width / integralRect.size.height) * [UIScreen mainScreen].scale;
    size_t contextRefWidth = ceilf(integralRect.size.width * sideScale);
    size_t contextRefHeight = ceilf(integralRect.size.height * sideScale);
    // 灰度、不透明
    CGContextRef contextRef = CGBitmapContextCreate(nil, contextRefWidth, contextRefHeight, 8, 0, CGColorSpaceCreateDeviceGray(), (CGBitmapInfo)kCGImageAlphaNone);
    // 设置上下文无插值
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    // 设置上下文缩放
    CGContextScaleCTM(contextRef, sideScale, sideScale);
    // 在上下文中的integralRect中绘制imageRef
    CGContextDrawImage(contextRef, integralRect, imageRef);
    
    //! 从上下文中获取CGImageRef
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
    
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    
    //! 将CGImageRefc转成UIImage
    UIImage *scaledImage = [UIImage imageWithCGImage:scaledImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    return scaledImage;
}


/// 合成图片--中间加 logo
+ (UIImage *)combinateCodeImage:(UIImage *)codeImage andLogo:(UIImage *)logo {
    
    UIGraphicsBeginImageContextWithOptions(codeImage.size, YES, [UIScreen mainScreen].scale);
    
    // 将codeImage画到上下文中
    [codeImage drawInRect:(CGRect){.0, .0, codeImage.size.width, codeImage.size.height}];
    
    // 定义logo的绘制参数
    CGFloat logoSide = fminf(codeImage.size.width, codeImage.size.height) / 4;
    CGFloat logoX = (codeImage.size.width - logoSide) / 2;
    CGFloat logoY = (codeImage.size.height - logoSide) / 2;
    CGRect logoRect = (CGRect){logoX, logoY, logoSide, logoSide};
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:logoRect cornerRadius:logoSide / 5];
    [cornerPath setLineWidth:2.0];
    [[UIColor whiteColor] set];
    [cornerPath stroke];
    [cornerPath addClip];
    
    // 将logo画到上下文中
    [logo drawInRect:logoRect];
    
    // 从上下文中读取image
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return codeImage;
}

@end
