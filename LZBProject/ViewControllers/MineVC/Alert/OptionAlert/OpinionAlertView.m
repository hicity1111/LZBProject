//
//  OpinionAlertView.m
//  LZBProject
//
//  Created by hicity on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "OpinionAlertView.h"

#define kOptionTitle  @"意见反馈"
#define kBackWidth 315

@interface OpinionAlertView ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIView *containerView;

@end

@implementation OpinionAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        self.frame = kScreenBounds;
        self.backgroundColor = kMineAlertTrans;
        [self addSubviews];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - Custom Method

- (void)showAlert {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 0.f;
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideAlert {
    self.alpha = 1.f;
    MJWeakSelf
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
//        weakSelf.didHide();
    }];
}

#pragma mark - Private Method

- (void)addSubviews {
    
    CGFloat leftPadding = 19*kWidthScale;
    CGFloat width = kBackWidth * kWidthScale;
    
    self.containerView = [[UIView alloc] initWithFrame:({
        CGRect rect = {30*kWidthScale, self.center.y - 200*kWidthScale, kBackWidth*kWidthScale, 1};
        rect;
    })];
    self.containerView.layer.cornerRadius = 10;
    self.containerView.backgroundColor = KMAINFFFF;
    [self addSubview:self.containerView];
    
    //标题
    _optionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 24.5*kWidthScale, self.containerView.width, 21*kWidthScale)];
    _optionTitle.text = kOptionTitle;
    _optionTitle.font = LZBSemiboldFont(22*kWidthScale);
    _optionTitle.textColor = kMAIN3333;
    _optionTitle.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:_optionTitle];
    
    _customBottonView = [[CustomBottonView alloc]initWithFrame:CGRectMake(9*kWidthScale, _optionTitle.bottom + 8.5*kWidthScale, self.containerView.width - 18*kWidthScale, 0)];
    _customBottonView.backColor = [UIColor whiteColor];
    _customBottonView.cornerRadiu = 5.0;
    _customBottonView.rowNum = @"3";
    _customBottonView.selectColor = [UIColor colorWithHexString:@"#CCF0E5"];
    _customBottonView.nomorlColor = [UIColor colorWithHex:@"#F5F5F5"];
    _customBottonView.selectIndex = @"2";
    _customBottonView.selectTitleColor = [UIColor colorWithHex:@"#00985B"];
    _customBottonView.isMuli = NO;
    self.customBottonView.titleArr = @[@"功能异常",@"资源错误",@"显示问题",@"其它意见"];
    [self.containerView addSubview:_customBottonView];
    
    LZBWeak;
    _customBottonView.buttonAction = ^(JMBaseButton * _Nullable sender) {
        NSLog(@"customBottonView.selectedMarkArray=== %@",weakSelf.customBottonView.selectedMarkArray);
    };
    
    _textView = [[XSDTextView alloc] initWithFrame:CGRectMake(leftPadding, _customBottonView.bottom + 5*kWidthScale, width - leftPadding*2, 165*kWidthScale)];
    _textView.placeholder = @"请填写您的意见";
    _textView.font = LZBFont(15*kWidthScale, NO);
    _textView.textColor = [UIColor colorWithHex:@"#AAAAAA"];
    _textView.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
    CGFloat xMargin =15*kWidthScale, yMargin = 14*kWidthScale;
    _textView.textContainerInset = UIEdgeInsetsMake(yMargin, xMargin, 0, xMargin);
    _textView.contentInset = UIEdgeInsetsMake(0, 0, yMargin, 0);
    _textView.layoutManager.allowsNonContiguousLayout=NO;
    _textView.delegate = self;
    [self.containerView addSubview:_textView];
    
    _sendBUutton = [[UIButton alloc] initWithFrame:CGRectMake(0, _textView.bottom + 15*kWidthScale, 140*kWidthScale, 40*kWidthScale)];
    _sendBUutton.centerX = self.containerView.width/2;

    _sendBUutton.backgroundColor = kMAIN00B5;
    [_sendBUutton setTitle:@"发送" forState:UIControlStateNormal];
    _sendBUutton.titleLabel.font = LZBFont(18*kWidthScale, NO);
    
    self.containerView.height = self.sendBUutton.bottom + 25*kWidthScale;
}

@end
