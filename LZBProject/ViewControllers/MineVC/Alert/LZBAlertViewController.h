//
//  LZBAlertViewController.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIViewControllerTransitioning.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, LZBAlertViewStyle) {
    LZBAlertViewStyleSuccess,
    LZBAlertViewStyleError,
    LZBAlertViewStyleNotice,
    LZBAlertViewStyleWarning,
    LZBAlertViewStyleInfo,
    LZBAlertViewStyleEdit,
    LZBAlertViewStyleWaiting,
    LZBAlertViewStyleQuestion,
    LZBAlertViewStyleCustom
};

/** Alert background styles
 *
 * Set LZBAlertView background type.
 */
typedef NS_ENUM(NSInteger, LZBAlertViewBackground) {
    LZBAlertViewBackgroundShadow,
    LZBAlertViewBackgroundBlur,
    LZBAlertViewBackgroundTransparent
};

/** Alert show animation styles
 *
 * Set LZBAlertView show animation type.
 */
typedef NS_ENUM(NSInteger, LZBAlertViewShowAnimation) {
    LZBAlertViewShowAnimationFadeIn,
    LZBAlertViewShowAnimationSlideInFromBottom,
    LZBAlertViewShowAnimationSlideInFromTop,
    LZBAlertViewShowAnimationSlideInFromLeft,
    LZBAlertViewShowAnimationSlideInFromRight,
    LZBAlertViewShowAnimationSlideInFromCenter,
    LZBAlertViewShowAnimationSlideInToCenter,
    LZBAlertViewShowAnimationSimplyAppear
};

/** Alert hide animation styles
 *
 * Set LZBAlertView hide animation type.
 */
typedef NS_ENUM(NSInteger, LZBAlertViewHideAnimation) {
    LZBAlertViewHideAnimationFadeOut,
    LZBAlertViewHideAnimationSlideOutToBottom,
    LZBAlertViewHideAnimationSlideOutToTop,
    LZBAlertViewHideAnimationSlideOutToLeft,
    LZBAlertViewHideAnimationSlideOutToRight,
    LZBAlertViewHideAnimationSlideOutToCenter,
    LZBAlertViewHideAnimationSlideOutFromCenter,
    LZBAlertViewHideAnimationSimplyDisappear
};




@interface LZBAlertConfig : NSObject

/// 大背景色
@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *containerViewColor;

/// 标题颜色
@property (nonatomic, strong) UIColor   *titleColor;
/// 标题大小
@property (nonatomic, strong) UIFont    *titleFont;
/// 附加内容颜色
@property (nonatomic, strong) UIColor   *messageColor;
/// 附加内容大小
@property (nonatomic, strong) UIFont    *messageFont;
/// 确定按钮文字 颜色
@property (nonatomic, strong) UIColor   *sureBtnColor;
/// 确定按钮文字 大小
@property (nonatomic, strong) UIFont    *sureBtnFont;
/// 取消按钮文字 颜色
@property (nonatomic, strong) UIColor   *cancelBtnColor;
/// 取消按钮文字 大小
@property (nonatomic, strong) UIFont    *cancelBtnFont;
/// 分割线颜色
@property (nonatomic, strong) UIColor   *sepLineColor;

/// 默认 10.f
@property (nonatomic, assign) CGFloat corner_radius;
/// 容器左右边距 默认 30.f
@property (nonatomic, assign) CGFloat container_left_margin;
/// 默认 175.f
@property (nonatomic, assign) CGFloat container_height;
/// 默认 1.f
@property (nonatomic, assign) CGFloat sepline_height;
/// 默认 50.f
@property (nonatomic, assign) CGFloat button_height;


/// 默认 “提示”
@property (nonatomic, strong) NSString *title;
/// 默认 nil
@property (nonatomic, strong) NSString *message;
/// 默认 “确定”
@property (nonatomic, strong) NSString *sureText;
/// 默认 “取消”
@property (nonatomic, strong) NSString *cancelText;


- (instancetype)init;


@end

@interface LZBAlertViewController : UIViewController

@property (nonatomic, strong) LZBAlertConfig *config;


- (instancetype)initWithConfig:(LZBAlertConfig *)config;

- (void)alertWithViewController:(UIViewController *)vc
                     AgreeBlock:(void (^)(UIButton *btn))agreeBlock
                    cancelBlock:(void (^ _Nullable)(UIButton *btn))cancelBlock;

@end

NS_ASSUME_NONNULL_END
