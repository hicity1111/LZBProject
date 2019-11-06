//
//  LZBAlertViewController.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/4.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBAlertViewController.h"
#import "HWPop.h"


@implementation LZBAlertConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kMineAlertBgColor;
        self.containerViewColor = WHITECOLOR;
        
        self.titleColor = kMAIN3333;
        self.titleFont = LZBMediumFont(20);
        
        self.messageColor = kMAIN6666;
        self.messageFont = LZBRegularFont(16);
        
        self.sureBtnColor = kMAIN0098;
        self.sureBtnFont = LZBMediumFont(19);
        
        self.cancelBtnColor = kMAIN9999;
        self.cancelBtnFont = LZBMediumFont(19);
        
        self.sepLineColor = kMAINCCCC;
        
        self.container_height = 175.f;
        self.container_left_margin = 30.f;
        self.corner_radius = 10.f;
        self.sepline_height = 1.f;
        self.button_height = 50.f;
        self.centerYPersent = 0.5;
        
        self.title = @"提示";
        self.sureText = @"";
        self.cancelText = @"";
    }
    return self;
}

@end



@interface LZBAlertViewController ()

@property (nonatomic, strong) UIView    *containerView;

@property (nonatomic, strong) UILabel   *titleLab;

@property (nonatomic, strong) UILabel   *messageLab;

@property (nonatomic, strong) UIButton  *sureBtn;

@property (nonatomic, strong) UIButton  *cancelBtn;

@property (nonatomic, strong) UILabel   *sepLine_H;

@property (nonatomic, strong) UILabel   *sepLine_V;


@property (nonatomic, copy) void (^sureButtonAction)(UIButton *btn);
@property (nonatomic, copy) void (^cancelButtonAction)(UIButton *btn);

@end

@implementation LZBAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverFullScreen;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.config = [[LZBAlertConfig alloc] init];
        self.view.backgroundColor = self.config.backgroundColor;
        self.view.frame = [UIApplication sharedApplication].keyWindow.bounds;
    }
    return self;
}

- (instancetype)initWithConfig:(LZBAlertConfig *)config {
    self = [super init];
    if (self) {
        self.config = config;
        self.view.frame = [UIApplication sharedApplication].keyWindow.bounds;
        self.view.backgroundColor = config.backgroundColor;
    }
    return self;
}

- (void)alertWithViewController:(UIViewController *)vc
                     AgreeBlock:(void (^)(UIButton *btn))agreeBlock
                    cancelBlock:(void (^ _Nullable)(UIButton *btn))cancelBlock {
    self.sureButtonAction = agreeBlock;
    self.cancelButtonAction = cancelBlock;
    
    [self addSubviews];
    [self updateSubviewsFrame];
    
    HWPopController *popController = [[HWPopController alloc] initWithViewController:self];
    popController.popPosition = HWPopPositionCenter;
    popController.popType = HWPopTypeFadeIn;
    popController.dismissType = HWDismissTypeFadeOut;
    popController.shouldDismissOnBackgroundTouch = NO;
    [popController presentInViewController:vc completion:^{
        
    }];
    
//    [vc presentViewController:self animated:YES completion:^{
//
//    }];
}


#pragma mark - Private Method
- (void)addSubviews {
    [self.view addSubview:self.containerView];
    
    [self.containerView addSubview:self.titleLab];
    
    NSInteger msgLen = self.config.message.length;
    if (msgLen > 0) {
        [self.containerView addSubview:self.messageLab];
    }
    
    NSInteger ctLen = self.config.cancelText.length;
    NSInteger stLen = self.config.sureText.length;
    if (ctLen != 0 && stLen != 0) {
        [self.containerView addSubview:self.sepLine_H];
        [self.containerView addSubview:self.cancelBtn];
        [self.containerView addSubview:self.sepLine_V];
        [self.containerView addSubview:self.sureBtn];
    }
    else if (ctLen == 0 && stLen != 0) {
        [self.containerView addSubview:self.sepLine_H];
        [self.containerView addSubview:self.sureBtn];
    }
    else if (ctLen != 0 && stLen == 0) {
        [self.containerView addSubview:self.sepLine_H];
        [self.containerView addSubview:self.cancelBtn];
    }
    else if (ctLen == 0 && stLen == 0) {
        
    }
}

- (void)updateSubviewsFrame {
    CGFloat margin = self.config.container_left_margin;
    CGFloat con_w = self.view.width - 2 * margin;
    CGFloat lb_w = con_w - 2 * margin;
    
    CGSize titleS = [self.titleLab sizeThatFits:CGSizeMake(lb_w, INTMAX_MAX)];
    self.titleLab.frame = CGRectMake(margin, margin + 5.f, lb_w, titleS.height);
    
    CGFloat sepLineTop = self.titleLab.bottom;
    NSInteger msgLen = self.config.message.length;
    if (msgLen > 0) {
        CGSize msgS = [self.messageLab sizeThatFits:CGSizeMake(lb_w, INTMAX_MAX)];
        self.messageLab.frame = CGRectMake(margin, self.titleLab.bottom + margin - 10.f, lb_w, msgS.height);
        sepLineTop = self.messageLab.bottom;
    }
    
    NSInteger ctLen = self.config.cancelText.length;
    NSInteger stLen = self.config.sureText.length;
    if (ctLen != 0 && stLen != 0) {
        self.sepLine_H.frame = CGRectMake(0, sepLineTop + margin, con_w, self.config.sepline_height);
        self.cancelBtn.frame = CGRectMake(0, self.sepLine_H.bottom, con_w / 2.f, self.config.button_height);
        self.sureBtn.frame = CGRectMake(con_w / 2.f, self.cancelBtn.top, con_w / 2.f, self.config.button_height);
        self.sepLine_V.frame = CGRectMake(self.cancelBtn.right, self.cancelBtn.top, self.config.sepline_height, self.cancelBtn.height);
    }
    else if (ctLen == 0 && stLen != 0) {
        self.sepLine_H.frame = CGRectMake(0, sepLineTop + margin, con_w, self.config.sepline_height);
        self.sureBtn.frame = CGRectMake(0, self.sepLine_H.top, con_w, self.config.button_height);
    }
    else if (ctLen != 0 && stLen == 0) {
        self.sepLine_H.frame = CGRectMake(0, sepLineTop + margin, con_w, self.config.sepline_height);
        self.cancelBtn.frame = CGRectMake(0, self.sepLine_H.bottom, con_w, self.config.button_height);
    }
    else if (ctLen == 0 && stLen == 0) {
        
    }
    
    CGFloat conH = ctLen || stLen ? (self.sepLine_H.bottom + self.config.button_height) : (sepLineTop + self.config.container_left_margin);
    self.containerView.size = CGSizeMake(con_w, conH);
    self.containerView.center = CGPointMake(self.view.centerX, self.view.height * self.config.centerYPersent);
    
    self.contentSizeInPop = [UIScreen mainScreen].bounds.size;
}

- (void)hideAlert {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - Action Method
- (void)sureAction:(UIButton *)btn {
    if (self.sureButtonAction) {
        self.sureButtonAction(btn);
    }
    [self hideAlert];
}

- (void)cancelAction:(UIButton *)btn {
    if (self.cancelButtonAction) {
        self.cancelButtonAction(btn);
    } else {
        [self hideAlert];
    }
}


#pragma mark - 懒加载

- (LZBAlertConfig *)config {
    if (!_config) {
        _config = [[LZBAlertConfig alloc] init];
    }
    return _config;
}

- (UIView *)containerView {
    if (!_containerView) {
        CGFloat width = kScreenWidth - 2 * self.config.container_left_margin;
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.config.container_height)];
        _containerView.backgroundColor = self.config.containerViewColor;
        _containerView.layer.cornerRadius = self.config.corner_radius;
        _containerView.clipsToBounds = YES;
    }
    return _containerView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = self.config.titleColor;
        _titleLab.font = self.config.titleFont;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
        _titleLab.text = self.config.title;
    }
    return _titleLab;
}

- (UILabel *)messageLab {
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] init];
        _messageLab.textColor = self.config.messageColor;
        _messageLab.font = self.config.messageFont;
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.numberOfLines = 0;
        _messageLab.text = self.config.message;
    }
    return _messageLab;
}

- (UILabel *)sepLine_H {
    if (!_sepLine_H) {
        _sepLine_H = [[UILabel alloc] init];
        _sepLine_H.backgroundColor = self.config.sepLineColor;
    }
    return _sepLine_H;
}

- (UILabel *)sepLine_V {
    if (!_sepLine_V) {
        _sepLine_V = [[UILabel alloc] init];
        _sepLine_V.backgroundColor = self.config.sepLineColor;
    }
    return _sepLine_V;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:self.config.sureText forState:UIControlStateNormal];
        [_sureBtn setTitleColor:self.config.sureBtnColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = self.config.sureBtnFont;
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:self.config.cancelText forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:self.config.cancelBtnColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = self.config.cancelBtnFont;
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


@end
