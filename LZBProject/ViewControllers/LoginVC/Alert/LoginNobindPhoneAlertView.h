//
//  LoginNobindPhoneAlertView.h
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginNobindPhoneAlertView : UIView

@property (nonatomic, copy) void (^touchAlreadyBindBlock)(UIButton *btn);

- (void)show;

@end

NS_ASSUME_NONNULL_END
