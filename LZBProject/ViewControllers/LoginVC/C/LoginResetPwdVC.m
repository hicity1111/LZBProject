//
//  LoginResetPwdVC.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginResetPwdVC.h"
#import "LYZTextField.h"
#import "NSObject+charValid.h"


static CGFloat leftMargin = 30.f;
static NSInteger buttonBaseTag = 999;

@interface LoginResetPwdVC () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) LYZTextField *pwdTF;
@property (nonatomic, strong) UIView *pwdTFBottomLine;
@property (nonatomic, strong) UIImageView *isPwdTureFlagImgV;

@property (nonatomic, strong) LYZTextField *repwdTF;
@property (nonatomic, strong) UIView *repwdTFBottomLine;
@property (nonatomic, strong) UIImageView *isRepwdTureFlagImgV;

/// 显示/隐藏 密码
@property (nonatomic, strong) UIButton *showPwdBtn;
@property (nonatomic, strong) UIButton *showRepwdBtn;

@property (nonatomic, strong) UILabel *pwdAnnotationLb;

@property (nonatomic, strong) JMBaseButton *submitBtn;

@end

@implementation LoginResetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mt_showNavigationTitle:@"修改密码"];
    
    [self addCustomViews];
    [self updateSubviewsFrame];
    [self textfieldAddCustomView];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



- (void)addCustomViews {
    [self.view addSubview:self.titleLb];
    
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.pwdTFBottomLine];
    [self.view addSubview:self.isPwdTureFlagImgV];
    
    [self.view addSubview:self.repwdTF];
    [self.view addSubview:self.repwdTFBottomLine];
    [self.view addSubview:self.isRepwdTureFlagImgV];
    
    [self.view addSubview:self.pwdAnnotationLb];
    
    [self.view addSubview:self.submitBtn];
}

- (void)updateSubviewsFrame {
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(42.f + kTopBarHeight);
        make.left.equalTo(self.view).offset(leftMargin);
    }];
    
    // 密码
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.mas_bottom).offset(34.f);
        make.left.equalTo(self.view).offset(leftMargin);
        make.right.equalTo(self.view).offset(-leftMargin);
        make.height.mas_equalTo(48.f);
    }];
    [self.pwdTFBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTF.mas_bottom);
        make.left.right.equalTo(self.pwdTF);
        make.height.mas_equalTo(1.f);
    }];
    [self.isPwdTureFlagImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pwdTF.mas_right);
        make.right.equalTo(self.view);
        make.centerY.equalTo(self.pwdTF);
        make.height.mas_equalTo(20.f);
    }];
    
    // 确认密码
    [self.repwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTF.mas_bottom).offset(12.f);
        make.left.right.equalTo(self.pwdTF);
        make.height.mas_equalTo(48.f);
    }];
    [self.repwdTFBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repwdTF.mas_bottom);
        make.left.right.equalTo(self.pwdTF);
        make.height.mas_equalTo(1.f);
    }];
    [self.isRepwdTureFlagImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.repwdTF.mas_right);
        make.right.equalTo(self.view);
        make.centerY.equalTo(self.repwdTF);
        make.height.mas_equalTo(20.f);
    }];
    
    [self.pwdAnnotationLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pwdTF);
        make.top.equalTo(self.repwdTF.mas_bottom).offset(12.f);
    }];
    
    // 确认按钮
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repwdTF.mas_bottom).offset(53.f);
        make.left.right.equalTo(self.pwdTF);
        make.height.mas_equalTo(44.f);
    }];
    [self.view layoutIfNeeded];
    
    [self.submitBtn setCornerRadiusAuto];
}

- (void)textfieldAddCustomView {
    self.pwdTF.cusRightView = self.showPwdBtn;
    [self.pwdTF becomeFirstResponder];
    self.repwdTF.cusRightView = self.showRepwdBtn;
}

#pragma mark - custom Method

- (void)textFieldDidChange:(LYZTextField *)textField {
    if (textField.text.length > 16) {
        textField.text = [textField.text substringToIndex:16];
        return;
    }
    
    NSString *str = textField.text;
    
    if (textField == self.pwdTF) {
        BOOL isPwdValid = (str.length >= 8 && str.length <= 16 &&
                           [str lzb_isValidPassword]);
        self.isPwdTureFlagImgV.backgroundColor = isPwdValid ? GREENCOLOR : REDCOLOR;
    }
    else if (textField == self.repwdTF) {
        BOOL isRepwdEqualPwd = str.length > 0 && [str isEqualToString:self.pwdTF.text];
        self.isRepwdTureFlagImgV.backgroundColor = isRepwdEqualPwd ? GREENCOLOR : REDCOLOR;
    }
}

#pragma mark - action

- (void)submitAction:(UIButton *)btn {
    NSString *pwd = self.pwdTF.text;
    NSString *rePwd = self.repwdTF.text;
    
    if (pwd.length == 0) {
        [self showError:@"你还没有输入密码哦~"];
        return;
    }
    else if (![pwd lzb_isValidPassword]) {
        [self showError:@"请输入数字和英文组合密码8~16位"];
        return;
    }
    else if (rePwd.length == 0) {
        [self showError:@"请输入确认密码"];
        return;
    }
    else if (![pwd isEqualToString:rePwd]) {
        [self showError:@"两次密码输入不一样哦~"];
        return;
    }
    
    // TODO: - 发送修改密码请求
    [self showSuccess:@"密码设置成功！"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/// 点击显示密码
- (void)showPasswordAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (btn.tag - buttonBaseTag == 0) {
        self.pwdTF.secureTextEntry = !btn.selected;
    }
    else if (btn.tag - buttonBaseTag == 1) {
        self.repwdTF.secureTextEntry = !btn.selected;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /// 删除键
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    const char *chars = [string cStringUsingEncoding:NSUTF8StringEncoding];
    char c = chars[0];
    
    if ([self isAlphaNumChar:c]) {
        return YES;
    }
    return NO;
}

#pragma mark - lazy load

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.text = @"重置密码";
        _titleLb.textColor = kMAIN3333;
        _titleLb.font = LZBMediumFont(24.f);
    }
    return _titleLb;
}

- (LYZTextField *)pwdTF {
    if (!_pwdTF) {
        _pwdTF = [[LYZTextField alloc] init];
        _pwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:kMAINA6A6, NSFontAttributeName: LZBFont(17.f, NO)}];
        _pwdTF.font = LZBFont(18.f, NO);
        _pwdTF.textColor = kMAIN3333;
        _pwdTF.tintColor = kMAIN6666;
        _pwdTF.keyboardType = UIKeyboardTypeAlphabet;
        _pwdTF.secureTextEntry = YES;
        _pwdTF.delegate = self;
        [_pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTF;
}

- (UIView *)pwdTFBottomLine {
    if (!_pwdTFBottomLine) {
        _pwdTFBottomLine = [[UIView alloc] init];
        _pwdTFBottomLine.backgroundColor = kMAINEEEE;
    }
    return _pwdTFBottomLine;
}

- (UIImageView *)isPwdTureFlagImgV {
    if (!_isPwdTureFlagImgV) {
        _isPwdTureFlagImgV = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"")];
        _isPwdTureFlagImgV.backgroundColor = REDCOLOR;
        _isPwdTureFlagImgV.contentMode = UIViewContentModeCenter;
    }
    return _isPwdTureFlagImgV;
}

- (LYZTextField *)repwdTF {
    if (!_repwdTF) {
        _repwdTF = [[LYZTextField alloc] init];
        _repwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入密码" attributes:@{NSForegroundColorAttributeName:kMAINA6A6, NSFontAttributeName: LZBFont(17.f, NO)}];
        _repwdTF.font = LZBFont(18.f, NO);
        _repwdTF.textColor = kMAIN3333;
        _repwdTF.tintColor = kMAIN6666;
        _repwdTF.keyboardType = UIKeyboardTypeAlphabet;
        _repwdTF.secureTextEntry = YES;
        _repwdTF.delegate = self;
        [_repwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _repwdTF;
}

- (UIView *)repwdTFBottomLine {
    if (!_repwdTFBottomLine) {
        _repwdTFBottomLine = [[UIView alloc] init];
        _repwdTFBottomLine.backgroundColor = kMAINEEEE;
    }
    return _repwdTFBottomLine;
}

- (UIImageView *)isRepwdTureFlagImgV {
    if (!_isRepwdTureFlagImgV) {
        _isRepwdTureFlagImgV = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"")];
        _isRepwdTureFlagImgV.backgroundColor = REDCOLOR;
        _isRepwdTureFlagImgV.contentMode = UIViewContentModeCenter;
    }
    return _isRepwdTureFlagImgV;
}

- (UIButton *)showPwdBtn {
    if (!_showPwdBtn) {
        _showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showPwdBtn.frame = CGRectMake(0, 0, 35, 30);
        [_showPwdBtn setImage:[UIImage imageNamed:@"login_pwd_hide"] forState:UIControlStateNormal];
        [_showPwdBtn setImage:[UIImage imageNamed:@"login_pwd_show"] forState:UIControlStateSelected];
        _showPwdBtn.adjustsImageWhenHighlighted = NO;
        [_showPwdBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
        _showPwdBtn.tag = buttonBaseTag;
    }
    return _showPwdBtn;
}

- (UIButton *)showRepwdBtn {
    if (!_showRepwdBtn) {
        _showRepwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showRepwdBtn.frame = CGRectMake(0, 0, 35, 30);
        [_showRepwdBtn setImage:[UIImage imageNamed:@"login_pwd_hide"] forState:UIControlStateNormal];
        [_showRepwdBtn setImage:[UIImage imageNamed:@"login_pwd_show"] forState:UIControlStateSelected];
        _showRepwdBtn.adjustsImageWhenHighlighted = NO;
        [_showRepwdBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
        _showRepwdBtn.tag = buttonBaseTag + 1;
    }
    return _showRepwdBtn;
}

- (UILabel *)pwdAnnotationLb {
    if (!_pwdAnnotationLb) {
        _pwdAnnotationLb = [[UILabel alloc] init];
        _pwdAnnotationLb.text = @"请输入数字和英文组合密码8-16位";
        _pwdAnnotationLb.textColor = kMAINAAAA;
        _pwdAnnotationLb.font = LZBRegularFont(14.f);
    }
    return _pwdAnnotationLb;
}

- (JMBaseButton *)submitBtn {
    if (!_submitBtn) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.backgroundColor = kMAIN00B5;
        config.title = @"确定";
        config.titleColor = WHITECOLOR;
        config.titleFont = LZBFont(18.f, NO);
        _submitBtn = [JMBaseButton buttonFrame:CGRectZero ButtonConfig:config];
        
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _submitBtn.layer.shadowOffset = CGSizeMake(0, 2.f);
        _submitBtn.layer.shadowOpacity = 1.f;
        _submitBtn.layer.shadowRadius = 2.f;
        _submitBtn.layer.cornerRadius = 22.f;
    }
    return _submitBtn;
}


@end
