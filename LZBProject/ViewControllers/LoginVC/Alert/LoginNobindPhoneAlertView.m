//
//  LoginNobindPhoneAlertView.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginNobindPhoneAlertView.h"



static CGFloat containLeftMargin = 30.f, imageW = 125.f, buttonLeftMargin =  22.5, buttonH = 40.f;
static CGFloat containH = 340.f, imgTopMargin = 25.f;


@interface LoginNobindPhoneAlertView ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *phoneImgV;

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UILabel *customerPhoneLb;

@property (nonatomic, strong) UILabel *customerEmailLb;

@property (nonatomic, strong) UIButton *alreadyBindPhoneBtn;

@end

@implementation LoginNobindPhoneAlertView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kUserNoticeTrans;
        
        [self allInitMetiond];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = kUserNoticeTrans;
        
        [self allInitMetiond];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - custom Method

- (void)allInitMetiond {
    [self addGesture];
    [self addSubviews];
    [self updateSubviewsFrame];
}

- (void)addGesture {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFullView:)]];
    
    [self.containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContainerView:)]];
}

- (void)addSubviews {
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.phoneImgV];
    [self.containerView addSubview:self.titleLb];
    [self.containerView addSubview:self.customerPhoneLb];
    [self.containerView addSubview:self.customerEmailLb];
    [self.containerView addSubview:self.alreadyBindPhoneBtn];
}

- (void)updateSubviewsFrame {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(containH);
        make.left.equalTo(self).offset(containLeftMargin);
        make.right.equalTo(self).offset(-containLeftMargin);
        make.center.equalTo(self);
    }];
    
    [self.phoneImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(imgTopMargin);
        make.height.width.mas_equalTo(imageW);
        make.centerX.equalTo(self.containerView);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneImgV.mas_bottom).offset(20.f);
        make.left.equalTo(self.containerView).offset(buttonLeftMargin);
        make.right.equalTo(self.containerView).offset(-buttonLeftMargin);
    }];
    
    [self.customerPhoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.mas_bottom).offset(18.f);
        make.left.right.equalTo(self.titleLb);
    }];
    
    [self.customerEmailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customerPhoneLb.mas_bottom).offset(12.f);
        make.left.right.equalTo(self.titleLb);
    }];
    
    [self.alreadyBindPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customerEmailLb.mas_bottom).offset(20.f);
        make.left.equalTo(self.containerView).offset(buttonLeftMargin);
        make.right.equalTo(self.containerView).offset(-buttonLeftMargin);
        make.height.mas_equalTo(buttonH);
    }];
    
    [self layoutIfNeeded];
    [self.alreadyBindPhoneBtn setCornerRadiusAuto];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 0.f;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - action

- (void)tapFullView:(UITapGestureRecognizer *)tap {
    [self hide];
}

- (void)tapContainerView:(UITapGestureRecognizer *)tap {
    
}

- (void)touchAlreadyBindPhoneAction:(UIButton *)btn {
    [self hide];
    
    if (self.touchAlreadyBindBlock) {
        self.touchAlreadyBindBlock(btn);
    }
}


#pragma mark - lazy load

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = WHITECOLOR;
        [_containerView setCornerRadius:5.f];
    }
    return _containerView;
}

- (UIImageView *)phoneImgV {
    if (!_phoneImgV) {
        _phoneImgV = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"login_nobind_phone")];
    }
    return _phoneImgV;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.text = @"未绑定手机号请联系我们";
        _titleLb.textColor = kMAIN3333;
        _titleLb.font = LZBRegularFont(18.f);
    }
    return _titleLb;
}

- (UILabel *)customerPhoneLb {
    if (!_customerPhoneLb) {
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"客服电话：" attributes:@{NSForegroundColorAttributeName: kMAIN9696, NSFontAttributeName: LZBFont(14.f, NO)}];
        NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:@"400-016-2123" attributes:@{NSForegroundColorAttributeName: KMAIN5868, NSFontAttributeName: LZBFont(14.f, YES)}];
        NSMutableAttributedString *muattr = [[NSMutableAttributedString alloc] initWithAttributedString:attr1];
        [muattr appendAttributedString:attr2];
        
        _customerPhoneLb = [[UILabel alloc] init];
        _customerPhoneLb.attributedText = muattr;
    }
    return _customerPhoneLb;
}

- (UILabel *)customerEmailLb {
    if (!_customerEmailLb) {
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"客服邮箱：" attributes:@{NSForegroundColorAttributeName: kMAIN9696, NSFontAttributeName: LZBFont(14.f, NO)}];
        NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:@"admin@abnertech.com" attributes:@{NSForegroundColorAttributeName: KMAIN5868, NSFontAttributeName: LZBFont(14.f, YES)}];
        NSMutableAttributedString *muattr = [[NSMutableAttributedString alloc] initWithAttributedString:attr1];
        [muattr appendAttributedString:attr2];
        
        _customerEmailLb = [[UILabel alloc] init];
        _customerEmailLb.attributedText = muattr;
    }
    return _customerEmailLb;
}

- (UIButton *)alreadyBindPhoneBtn {
    if (!_alreadyBindPhoneBtn) {
        _alreadyBindPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alreadyBindPhoneBtn.backgroundColor = kMAIN00B5;
        [_alreadyBindPhoneBtn setTitle:@"已绑定过手机号" forState:UIControlStateNormal];
        [_alreadyBindPhoneBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _alreadyBindPhoneBtn.titleLabel.font = LZBFont(16.f, NO);
        
        _alreadyBindPhoneBtn.layer.shadowColor = kMAIN2D80.CGColor;
        _alreadyBindPhoneBtn.layer.shadowOffset = CGSizeMake(0,2);
        _alreadyBindPhoneBtn.layer.shadowOpacity = 1;
        _alreadyBindPhoneBtn.layer.shadowRadius = 3;
        _alreadyBindPhoneBtn.layer.cornerRadius = 20;
        
        [_alreadyBindPhoneBtn addTarget:self action:@selector(touchAlreadyBindPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alreadyBindPhoneBtn;
}


@end
