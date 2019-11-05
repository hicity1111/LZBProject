//
//  NSObject+LZBExtension.h
//  LZBProject
//
//  Created by liyan on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LZBExtension)

/**
 弹出alertController，并且有两个个action按钮，分别有处理事件
 
 @param title title
 @param message Message
 @param confirmTitle 右边按钮的title
 @param cancelTitle 左边按钮的title
 @param confirmAction 右边按钮的点击事件
 @param cancelAction 左边按钮的点击事件
 */
+ (void)mt_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 confirmTitle:(NSString *)confirmTitle
                  cancleTitle:(NSString *)cancelTitle
                confirmAction:(void(^)(void))confirmAction
                 cancleAction:(void(^)(void))cancelAction;



/** 找到当前试图控制器 */
+ (UIViewController *)mt_currentViewController;


@end

NS_ASSUME_NONNULL_END
