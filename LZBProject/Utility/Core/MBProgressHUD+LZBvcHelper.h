//
//  MBProgressHUD+LZBvcHelper.h
//  LZBProject
//
//  Created by hicity on 2019/10/23.
//  Copyright © 2019 hicity. All rights reserved.
//


#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (LZBvcHelper)
/**
 警告图片

 @return 警告图片
 */
+ (UIImage *)warningImage;


/**
 成功图片

 @return 成功图片
 */
+ (UIImage *)sucessImage;


/**
 展示成功的信息
 
 @param message 要展示的字
 @param view 展示view所在的视图
 */
+ (void)showSucessMessage:(NSString *)message inView:(UIView *)view;


/**
 展示警告的信息

 @param message 展示的文字
 @param view 展示view所在的视图
 */
+ (void)showWarningMessage:(NSString *)message inView:(UIView *)view;


/**
 展示信息

 @param message 信息
 @param view 展示view所在的视图
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view;

/**
 一直展示信息
 
 @param message 信息
 @param view 展示view所在的视图
 */
+ (MBProgressHUD *)showMessage:(NSString *)message alwaysInView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
