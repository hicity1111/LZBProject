//
//  PCenterHeaderView.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PCenterHeaderView : UIView

@property (nonatomic, strong) NSDictionary *model;

@property (nonatomic, strong) UIViewController *vc;

/// 更换头像
//@property (nonatomic, copy) void (^selectHeadImageGes)(UITapGestureRecognizer *ges);
//
///// 消息
//@property (nonatomic, copy) void (^clickSeeNoticeButton)(UIButton *btn);
//
///// 二维码
//@property (nonatomic, copy) void (^clickQRCodeButton)(UIButton *btn);
//
///// 我的资源
//@property (nonatomic, copy) void (^clickSeeMyResourceButton)(UIButton *btn);
//
///// 更改密码
//@property (nonatomic, copy) void (^clickChangePasswordButton)(UIButton *btn);
//
///// 反馈
//@property (nonatomic, copy) void (^clickFeedbackButton)(UIButton *btn);


@end

NS_ASSUME_NONNULL_END
