//
//  UIImage+QRCode.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QRCode)

/// 生成二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)codeStr
                             withSize:(CGSize)size;

/// 生成条形码
+ (UIImage *)generateCode128:(NSString *)code
                        size:(CGSize)size;

/// 缩放图片(生成高质量图片）
+ (UIImage *)scaleImage:(CIImage *)image
                 toSize:(CGSize)size;

/// 合成图片--中间加 logo
+ (UIImage *)combinateCodeImage:(UIImage *)codeImage
                        andLogo:(UIImage *)logo;

@end

NS_ASSUME_NONNULL_END
