//
//  QRCodeAlertManager.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "QRCodeAlertView.h"
#import "UIImage+QRCode.h"

#define kContView_width     315.f
#define kContView_height    431.f

#define kQRCode_view_width  250.f
#define kQRCode_width       230.f

#define kAvatar_width       64.f
#define kSex_width          15.f
#define kConnectLine_height 30.f
#define kCancel_width       32.f


/**
 字号 对应 sizeToFit后的height
 13     18.33
 14     19.67
 15     21.00
 16     22.67
 17     24.00
 18     25.33
 19     26.67
 20     28.00
 21     29.67
 22     31.00
 23     32.33
 24     33.67
 */


@implementation QRCodeConfig



@end





@interface QRCodeAlertView ()

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) UILabel *nameLb;

@property (nonatomic, strong) UIImageView *sexImgV;

@property (nonatomic, strong) UILabel *schoolLb;

@property (nonatomic, strong) UILabel *classLb;

@property (nonatomic, strong) UIImageView *QRCodeView;

@property (nonatomic, strong) UILabel *hintLb;

@property (nonatomic, strong) UILabel *connectLine;

@property (nonatomic, strong) UIButton *cancelBtn;


@end

@implementation QRCodeAlertView

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
        weakSelf.didHide();
    }];
}

#pragma mark - Private Method

- (void)addSubviews {
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.avatarView];
    [self.containerView addSubview:self.nameLb];
    [self.containerView addSubview:self.sexImgV];
    [self.containerView addSubview:self.schoolLb];
    [self.containerView addSubview:self.classLb];
    [self.containerView addSubview:self.QRCodeView];
    [self.containerView addSubview:self.hintLb];
    
    [self addSubview:self.connectLine];
    [self addSubview:self.cancelBtn];
}

- (void)updateFrame {
    CGFloat avatarTopMargin     = 20.f;
    CGFloat avatarLeftMargin    = 15.f;
    CGFloat avatarRightMargin   = 10.f;
    CGFloat sexLeftMargin       = 8.f;
    CGFloat schoolTopMargin     = 5.5;  // 12 - 4 - 2.5
    CGFloat classTopMargin      = 3.f;  // 8 - 2.5 - 2.5
    CGFloat qrcodeTopMargin     = 17.f;
    CGFloat hintTopMargin       = 17.5;
    
    self.avatarView.frame = CGRectMake(avatarLeftMargin, avatarTopMargin, kAvatar_width, kAvatar_width);
    self.nameLb.frame = CGRectMake(self.avatarView.right + avatarRightMargin, self.avatarView.top - 4, _nameLb.width, _nameLb.height);
    self.sexImgV.frame = CGRectMake(self.nameLb.right + sexLeftMargin, 0, kSex_width, kSex_width);
    self.sexImgV.centerY = self.nameLb.centerY;
    self.schoolLb.frame = CGRectMake(self.nameLb.left, self.nameLb.bottom + schoolTopMargin, _schoolLb.width, _schoolLb.height);
    self.classLb.frame = CGRectMake(self.nameLb.left, self.schoolLb.bottom + classTopMargin, _classLb.width, _classLb.height);
    
    self.QRCodeView.frame = CGRectMake((kContView_width - kQRCode_view_width) / 2.f, self.avatarView.bottom + qrcodeTopMargin, kQRCode_view_width, kQRCode_view_width);
    
    self.hintLb.frame = CGRectMake(self.QRCodeView.left, self.QRCodeView.bottom + hintTopMargin, kQRCode_view_width, 40);
    
    self.connectLine.size = CGSizeMake(1.f, kConnectLine_height);
    self.connectLine.top = self.containerView.bottom;
    self.connectLine.centerX = self.containerView.centerX;
    
    self.cancelBtn.frame = CGRectMake(0, self.connectLine.bottom, kCancel_width, kCancel_width);
    self.cancelBtn.centerX = self.containerView.centerX;
}

- (void)setViewValue {
    self.avatarView.image = self.config.avatarImg;
    self.nameLb.text = self.config.studentName;
    [self.nameLb sizeToFit];
    self.sexImgV.image = self.config.isGirl ? IMAGE_NAMED(@"user_girl") : IMAGE_NAMED(@"user_boy");
    self.schoolLb.text = self.config.schoolName;
    [self.schoolLb sizeToFit];
    self.classLb.text = self.config.className;
    [self.classLb sizeToFit];
    
    NSString *codeStr = [NSString stringWithFormat:@"https://sit-wechat.abnertech.com/lochi/&studentId=1651&gradeClassId=154&studentName=同学2"];
    UIImage *oriQR = [UIImage generateQRCodeWithString:codeStr withSize:CGSizeMake(kQRCode_width, kQRCode_width)];
    UIImage *afterImg = [UIImage combinateCodeImage:oriQR andLogo:self.config.avatarImg];
    self.QRCodeView.image = afterImg;
}

#pragma mark - Setter

- (void)setConfig:(QRCodeConfig *)config {
    _config = config;
    
    [self setViewValue];
    [self updateFrame];
}

#pragma mark - lazy load

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kContView_width, kContView_height)];
        _containerView.center = CGPointMake(kScreenWidth / 2.f, kScreenHeight / 2.f);
        _containerView.backgroundColor = WHITECOLOR;
        [_containerView setCornerRadius:10.f];
    }
    return _containerView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        [_avatarView setCornerRadius:10.f];
    }
    return _avatarView;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.textColor = kMAIN3333;
        _nameLb.font = LZBRegularFont(20.f);
    }
    return _nameLb;
}

- (UIImageView *)sexImgV {
    if (!_sexImgV) {
        _sexImgV = [[UIImageView alloc] init];
    }
    return _sexImgV;
}

- (UILabel *)schoolLb {
    if (!_schoolLb) {
        _schoolLb = [[UILabel alloc] init];
        _schoolLb.textColor = KMAIN5868;
        _schoolLb.font = LZBRegularFont(13.f);
    }
    return _schoolLb;
}

- (UILabel *)classLb {
    if (!_classLb) {
        _classLb = [[UILabel alloc] init];
        _classLb.textColor = KMAIN5868;
        _classLb.font = LZBRegularFont(13.f);
    }
    return _classLb;
}

- (UIImageView *)QRCodeView {
    if (!_QRCodeView) {
        _QRCodeView = [[UIImageView alloc] init];
        
        _QRCodeView.backgroundColor = kMAINEEEE;
        _QRCodeView.contentMode = UIViewContentModeCenter;
    }
    return _QRCodeView;
}

- (UILabel *)hintLb {
    if (!_hintLb) {
        _hintLb = [[UILabel alloc] init];
        _hintLb.textColor = kMAIN9696;
        _hintLb.font = LZBRegularFont(13.f);
        _hintLb.textAlignment = NSTextAlignmentCenter;
        _hintLb.numberOfLines = 0;
        _hintLb.text = @"微信扫描上面二维码，进入小程序\n绑定学生账号";
    }
    return _hintLb;
}

- (UILabel *)connectLine {
    if (!_connectLine) {
        _connectLine = [[UILabel alloc] init];
        _connectLine.backgroundColor = WHITECOLOR;
    }
    return _connectLine;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _cancelBtn.backgroundColor = BLACKCOLOR;
        [_cancelBtn setImage:IMAGE_NAMED(@"user_popup_close") forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(hideAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
