//
//  UIImage+CompressImage.m
//  LZBProject
//
//  Created by hicity on 2019/10/12.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UIImage+CompressImage.h"


@implementation UIImage (CompressImage)
+(JPEGImage *)needCompressImage:(UIImage *)image size:(CGSize )size scale:(CGFloat )scale
{
    JPEGImage *newImage = nil;
    //创建画板
    UIGraphicsBeginImageContext(size);
    
    //写入图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //得到新的图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //释放画板
    UIGraphicsEndImageContext();
    
    //比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];
    
    return newImage;
}

+(JPEGImage *)needCompressImageData:(NSData *)imageData size:(CGSize )size scale:(CGFloat )scale
{
    PNGImage *image = [UIImage imageWithData:imageData];
    return [UIImage needCompressImage:image size:size scale:scale];
}

+ (JPEGImage *)needCenterImage:(UIImage *)image size:(CGSize )size scale:(CGFloat )scale
{
    /* 想切中间部分,待解决 */
//#warning area of center image
    JPEGImage *newImage = nil;
    //创建画板
    UIGraphicsBeginImageContext(size);
    
    //写入图片,在中间
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //得到新的图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //释放画板
    UIGraphicsEndImageContext();
    
    //比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];

    return newImage;
}

+(JPEGImage *)jpegImageWithPNGImage:(PNGImage *)pngImage
{
    return [UIImage needCompressImage:pngImage size:pngImage.size scale:1.0];
}

+(JPEGImage *)jpegImageWithPNGData:(PNGData *)pngData
{
    PNGImage *pngImage = [UIImage imageWithData:pngData];
    return [UIImage needCompressImage:pngImage size:pngImage.size scale:1.0];
}

+(JPEGData *)jpegDataWithPNGData:(PNGData *)pngData
{
    return UIImageJPEGRepresentation([UIImage jpegImageWithPNGData:pngData], 1.0);
}

+(JPEGData *)jpegDataWithPNGImage:(PNGImage *)pngImage
{
    return UIImageJPEGRepresentation([UIImage jpegImageWithPNGImage:pngImage], 1.0);
}


///  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color withSize:CGSizeMake(10.f, 10.f)];
}

///  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
     
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
     
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     
    return image;
}



@end
