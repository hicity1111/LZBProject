//
//  UserNoticeView.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UserNoticeView.h"
#import "AppDelegate.h"

#define kAnimationDuration  0.25

@interface UserNoticeView ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *knowBtn;

@end

@implementation UserNoticeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kUserNoticeTrans;
        [self addSubviews];
        [self adjustIsAgreeUserNotice];
    }
    return self;
}

- (void)addSubviews {
    CGFloat centerW = 315.f;
    CGFloat centerH = 390.f;
    UIView *centerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, centerW, centerH)];
    centerV.center = self.center;
    centerV.backgroundColor = WHITECOLOR;
    centerV.layer.cornerRadius = 5.f;
    [self addSubview:centerV];
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.text = @"用户须知";
    titleLb.textColor = kMAIN3333;
    titleLb.font = LZBFont(22, YES);
    [titleLb sizeToFit];
    
    UILabel *btmLine = [[UILabel alloc] init];
    btmLine.backgroundColor = kMAIN00B5;
    
    UITextView *tv = [[UITextView alloc] init];
    tv.text = @"<p style=\"white-space: normal;\">烦烦烦说法方式方<span style=\"background: url(&quot;data:image/svg+xml,%3Csvg xmlns=&#39;http://www.w3.org/2000/svg&#39; viewBox=&#39;0 0 20 4&#39;%3E%3Cpath fill=&#39;none&#39; stroke=&#39;%23333&#39; d=&#39;M0 3.5c5 0 5-3 10-3s5 3 10 3 5-3 10-3 5 3 10 3&#39;/%3E%3C/svg%3E&quot;) 0px 100% / 20px repeat-x; padding: 3px 0px;\">法方式是否石帆胜丰石帆</span>胜丰石帆胜丰沙发上</p>\
    <p style=\"white-space: normal;\">对我说分为氛围分<span style=\"background: url(&quot;data:image/svg+xml,%3Csvg xmlns=&#39;http://www.w3.org/2000/svg&#39; viewBox=&#39;0 0 20 4&#39;%3E%3Ccircle cx=&#39;10&#39;  cy=&#39;2&#39; r=&#39;1.5&#39;/%3E%3C/svg%3E&quot;) 0px 100% / 1em repeat-x; padding: 3px 0px;\">为氛围分为氛</span>围分为氛围</p>";
    tv.textColor = kMAIN9696;
    tv.font = LZBRegularFont(15);
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"user_notice_check_none"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"user_notice_check"] forState:UIControlStateSelected];
    selectBtn.adjustsImageWhenHighlighted = NO;
    [selectBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.selected = NO;
    self.selectBtn = selectBtn;
    NSAttributedString *attStr1 = [[NSAttributedString alloc] initWithString:@"已阅读并同意" attributes:@{NSFontAttributeName: LZBRegularFont(14), NSForegroundColorAttributeName: kMAIN9696}];
    NSAttributedString *attStr2 = [[NSAttributedString alloc] initWithString:@"《用户服务协议》" attributes:@{NSFontAttributeName: LZBRegularFont(14), NSForegroundColorAttributeName: KMAIN5868}];
    NSMutableAttributedString *mAttStr = [[NSMutableAttributedString alloc] initWithAttributedString:attStr1];
    [mAttStr appendAttributedString:attStr2];
    [selectBtn setAttributedTitle:mAttStr forState:UIControlStateNormal];
    [selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    UIButton *knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    knowBtn.backgroundColor = UIColor.lightGrayColor;
    [knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [knowBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    knowBtn.titleLabel.font = LZBRegularFont(16.f);
    [knowBtn addTarget:self action:@selector(knowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.knowBtn = knowBtn;

    [centerV addSubview:btmLine];
    [centerV addSubview:titleLb];
    [centerV addSubview:tv];
    [centerV addSubview:selectBtn];
    [centerV addSubview:knowBtn];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerV).offset(10);
        make.centerX.equalTo(centerV);
    }];
    [btmLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLb).offset(-2);
        make.right.equalTo(titleLb).offset(2);
        make.height.mas_equalTo(3.5);
        make.bottom.equalTo(titleLb).offset(-3.5);
    }];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(20.f);
        make.left.equalTo(centerV).offset(22.f);
        make.right.equalTo(centerV).offset(-22.f);
        make.height.mas_equalTo(200.f);
    }];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240.f);
        make.height.mas_equalTo(36.f);
        make.top.equalTo(tv.mas_bottom).offset(20.f);
        make.left.equalTo(centerV).offset(20.f);
    }];
    [knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(36.f);
        make.top.equalTo(selectBtn.mas_bottom).offset(20.f);
        make.centerX.equalTo(centerV.mas_centerX);
    }];
    
    [self layoutIfNeeded];
    btmLine.clipsToBounds = YES;
    btmLine.layer.cornerRadius = btmLine.height / 2.f;
    knowBtn.layer.cornerRadius = knowBtn.height / 2.f;
}

#pragma mark - Action
- (void)selectButtonClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    SETUSER_BOOL(AGREE_USER_NOTICE, btn.selected);
    [SDUserDefaults synchronize];
    if (btn.selected) {
        self.knowBtn.backgroundColor = kMAIN00B5;
    } else {
        self.knowBtn.backgroundColor = UIColor.lightGrayColor;
    }
}

- (void)knowButtonClick:(UIButton *)btn {
    if (self.selectBtn.selected) {
        SETUSER_BOOL(AGREE_USER_NOTICE, YES);
        [SDUserDefaults synchronize];
        [self hide];
    } else {
        [MBProgressHUD showMessage:@"请勾选“同意用户服务协议”" inView:self];
    }
}


#pragma mark - Method

- (void)adjustIsAgreeUserNotice {
    BOOL isAgree = GETUSER_BOOL(AGREE_USER_NOTICE);
    self.selectBtn.selected = isAgree;
    if (isAgree) {
        self.knowBtn.backgroundColor = kMAIN00B5;
    } else {
        self.knowBtn.backgroundColor = UIColor.lightGrayColor;
    }
}

- (void)show {
    self.alpha = 0.f;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 1.f;
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
