//
//  UIAlertController+LZBExtension.h
//  LZBProject
//
//  Created by liyan on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (LZBExtension)

/// 统一按钮样式 不写系统默认的蓝色
@property (nonatomic , readwrite, strong) UIColor *tintColor;
/// 标题的颜色
@property (nonatomic , readwrite, strong) UIColor *titleColor;
/// 信息的颜色
@property (nonatomic , readwrite, strong) UIColor *messageColor;

@end


@interface UIAlertAction (LZBColor)

/**< 按钮title字体颜色 */
@property (nonatomic , readwrite, strong) UIColor *textColor;

@end

NS_ASSUME_NONNULL_END
