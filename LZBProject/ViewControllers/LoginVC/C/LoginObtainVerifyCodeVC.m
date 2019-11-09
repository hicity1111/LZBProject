//
//  LoginObtainVerifyCodeVC.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginObtainVerifyCodeVC.h"
#import "LYZTextField.h"
#import "LoginResetPwdVC.h"


static CGFloat leftMargin = 30.f;

@interface LoginObtainVerifyCodeVC ()


@property (nonatomic, strong) UILabel *hintLb;

@property (nonatomic, strong) UILabel *numberLb;

@property (nonatomic, strong) UILabel *verifyLb;

@property (nonatomic, strong) LYZTextField *verifyTF;

@property (nonatomic, strong) UIView *phoneNumTFBottomLine;

@property (nonatomic, strong) JMBaseButton *sendCodeBtn;

@property (nonatomic, strong) JMBaseButton *nextStepBtn;

@end

@implementation LoginObtainVerifyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mt_showNavigationTitle:@"忘记密码"];
    
    [self addCustomViews];
    [self updateSubviewsFrame];
    [self.verifyTF becomeFirstResponder];
    [self.sendCodeBtn startCountDown:60 Detail:@"s"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.verifyTF.text = @"";
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}



- (void)addCustomViews {
    [self.view addSubview:self.hintLb];
    [self.view addSubview:self.numberLb];
    [self.view addSubview:self.verifyLb];
    [self.view addSubview:self.verifyTF];
    [self.view addSubview:self.phoneNumTFBottomLine];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.nextStepBtn];
}

- (void)updateSubviewsFrame {
    [self.hintLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(42.f + kTopBarHeight);
        make.left.equalTo(self.view).offset(leftMargin);
        make.right.equalTo(self.view).offset(-leftMargin);
    }];
    [self.numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintLb.mas_bottom).offset(30.f);
        make.left.right.equalTo(self.hintLb);
    }];
    [self.verifyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLb).offset(30.f);
        make.left.right.equalTo(self.view).offset(leftMargin);
    }];
    [self.verifyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyLb.mas_bottom).offset(24.f);
        make.left.equalTo(self.view).offset(leftMargin);
        make.right.equalTo(self.view).offset(-leftMargin);
        make.height.mas_equalTo(48.f);
    }];
    [self.phoneNumTFBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyTF.mas_bottom);
        make.left.right.equalTo(self.verifyTF);
        make.height.mas_equalTo(1.f);
    }];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyTF.mas_bottom).offset(10.f);
        make.right.equalTo(self.verifyTF);
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(36.f);
    }];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyTF.mas_bottom).offset(64.f);
        make.left.equalTo(self.view).offset(leftMargin);
        make.right.equalTo(self.view).offset(-leftMargin);
        make.height.mas_equalTo(44.f);
    }];
    [self.view layoutIfNeeded];
    
    [self.nextStepBtn setCornerRadiusAuto];
}

#pragma mark - custom Method

- (void)textFieldDidChange:(LYZTextField *)textField {
    if (textField == self.verifyTF) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}

#pragma mark - action

- (void)nextAction:(UIButton *)btn {
    NSString *verifyCode = self.verifyTF.text;
    
    if (verifyCode.length == 0) {
        [self showError:@"请输入验证码"];
        return;
    }
    
    /// 验证 短信验证码，发送成功推入下一个界面
    // TODO: - 验证 短信验证码
    LoginResetPwdVC *vc = [[LoginResetPwdVC alloc] init];
    vc.phoneNum = self.phoneNum;
    [self.navigationController pushViewController:vc animated:YES];
    [self.view endEditing:YES];
}

- (void)sendVerifyCodeAction:(UIButton *)btn {
    [self showError:@"发送验证码"];
}

#pragma mark - lazy load

- (UILabel *)hintLb {
    if (!_hintLb) {
        _hintLb = [[UILabel alloc] init];
        _hintLb.textAlignment = NSTextAlignmentCenter;
        _hintLb.text = @"已发送验证码至手机号：";
        _hintLb.textColor = kMAINA6A6;
        _hintLb.font = LZBRegularFont(17.f);
    }
    return _hintLb;
}

- (UILabel *)numberLb {
    if (!_numberLb) {
        _numberLb = [[UILabel alloc] init];
        _numberLb.textAlignment = NSTextAlignmentCenter;
        _numberLb.text = self.phoneNum;
        _numberLb.textColor = kMAIN3333;
        _numberLb.font = LZBMediumFont(22.f);
    }
    return _numberLb;
}

- (UILabel *)verifyLb {
    if (!_verifyLb) {
        _verifyLb = [[UILabel alloc] init];
        _verifyLb.text = @"验证码";
        _verifyLb.textColor = kMAIN3333;
        _verifyLb.font = LZBMediumFont(24.f);
    }
    return _verifyLb;
}

- (LYZTextField *)verifyTF {
    if (!_verifyTF) {
        _verifyTF = [[LYZTextField alloc] init];
        _verifyTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:kMAINA6A6, NSFontAttributeName: LZBFont(17.f, NO)}];
        _verifyTF.font = LZBFont(18.f, NO);
        _verifyTF.textColor = kMAIN3333;
        _verifyTF.tintColor = kMAIN6666;
        _verifyTF.keyboardType = UIKeyboardTypePhonePad;
//        _verifyTF.delegate = self;
        [_verifyTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verifyTF;
}

- (UIView *)phoneNumTFBottomLine {
    if (!_phoneNumTFBottomLine) {
        _phoneNumTFBottomLine = [[UIView alloc] init];
        _phoneNumTFBottomLine.backgroundColor = kMAINEEEE;
    }
    return _phoneNumTFBottomLine;
}

- (JMBaseButton *)sendCodeBtn {
    if (!_sendCodeBtn) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.backgroundColor = UIColor.clearColor;
        config.title = @"发送验证码";
        config.titleColor = BLUECOLOR;
        config.titleFont = LZBFont(18.f, NO);
        _sendCodeBtn = [JMBaseButton buttonFrame:CGRectZero ButtonConfig:config];
        
        [_sendCodeBtn addTarget:self action:@selector(sendVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeBtn;
}

- (JMBaseButton *)nextStepBtn {
    if (!_nextStepBtn) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.backgroundColor = kMAIN00B5;
        config.title = @"下一步";
        config.titleColor = WHITECOLOR;
        config.titleFont = LZBFont(18.f, NO);
        _nextStepBtn = [JMBaseButton buttonFrame:CGRectZero ButtonConfig:config];
        
        [_nextStepBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _nextStepBtn.layer.shadowOffset = CGSizeMake(0, 2.f);
        _nextStepBtn.layer.shadowOpacity = 1.f;
        _nextStepBtn.layer.shadowRadius = 2.f;
        _nextStepBtn.layer.cornerRadius = 22.f;
    }
    return _nextStepBtn;
}

@end
