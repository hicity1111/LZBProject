//
//  LoginObtainPhoneNumVC.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginObtainPhoneNumVC.h"
#import "LYZTextField.h"
#import "LoginObtainVerifyCodeVC.h"


static CGFloat leftMargin = 30.f;

@interface LoginObtainPhoneNumVC () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *bindPhoneLb;

@property (nonatomic, strong) LYZTextField *phoneNumTF;

@property (nonatomic, strong) UIView *phoneNumTFBottomLine;

@property (nonatomic, strong) JMBaseButton *nextStepBtn;

@end

@implementation LoginObtainPhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mt_showNavigationTitle:@"绑定手机号"];
    
    [self addCustomViews];
    [self updateSubviewsFrame];
    [self.phoneNumTF becomeFirstResponder];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}


- (void)addCustomViews {
    [self.view addSubview:self.bindPhoneLb];
    [self.view addSubview:self.phoneNumTF];
    [self.view addSubview:self.phoneNumTFBottomLine];
    [self.view addSubview:self.nextStepBtn];
}

- (void)updateSubviewsFrame {
    [self.bindPhoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(42.f + kTopBarHeight);
        make.left.equalTo(self.view).offset(leftMargin);
    }];
    [self.phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bindPhoneLb.mas_bottom).offset(24.f);
        make.left.equalTo(self.view).offset(leftMargin);
        make.right.equalTo(self.view).offset(-leftMargin);
        make.height.mas_equalTo(48.f);
    }];
    [self.phoneNumTFBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumTF.mas_bottom);
        make.left.right.equalTo(self.phoneNumTF);
        make.height.mas_equalTo(1.f);
    }];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumTF.mas_bottom).offset(46.f);
        make.left.equalTo(self.view).offset(leftMargin);
        make.right.equalTo(self.view).offset(-leftMargin);
        make.height.mas_equalTo(44.f);
    }];
    [self.view layoutIfNeeded];
    
    [self.nextStepBtn setCornerRadiusAuto];
}

#pragma mark - custom Method

- (void)textFieldDidChange:(LYZTextField *)textField {
    if (textField == self.phoneNumTF) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

#pragma mark - action

- (void)nextAction:(UIButton *)btn {
    NSString *num = self.phoneNumTF.text;
    
    if (num.length == 0) {
        [self showError:@"请输入手机号"];
        return;
    }
    else if (![num mh_isValidMobile]) {
        [self showError:@"请输入正确的手机号"];
        return;
    }
    
    /// 发送验证码，发送成功推入下一个界面
    // TODO: - 发送验证码
    LoginObtainVerifyCodeVC *vc = [[LoginObtainVerifyCodeVC alloc] init];
    vc.phoneNum = num;
    [self.navigationController pushViewController:vc animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - lazy load

- (UILabel *)bindPhoneLb {
    if (!_bindPhoneLb) {
        _bindPhoneLb = [[UILabel alloc] init];
        _bindPhoneLb.text = @"忘记密码";
        _bindPhoneLb.textColor = kMAIN3333;
        _bindPhoneLb.font = LZBMediumFont(24.f);
    }
    return _bindPhoneLb;
}

- (LYZTextField *)phoneNumTF {
    if (!_phoneNumTF) {
        _phoneNumTF = [[LYZTextField alloc] init];
        _phoneNumTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:kMAINA6A6, NSFontAttributeName: LZBFont(17.f, NO)}];
        _phoneNumTF.font = LZBFont(18.f, NO);
        _phoneNumTF.textColor = kMAIN3333;
        _phoneNumTF.tintColor = kMAIN6666;
        _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTF.delegate = self;
        [_phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneNumTF;
}

- (UIView *)phoneNumTFBottomLine {
    if (!_phoneNumTFBottomLine) {
        _phoneNumTFBottomLine = [[UIView alloc] init];
        _phoneNumTFBottomLine.backgroundColor = kMAINEEEE;
    }
    return _phoneNumTFBottomLine;
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
//        [_loginBtn setBackgroundImage:[UIImage imageWithColor:kMAINFF7E] forState:UIControlStateNormal];
//        [_loginBtn setBackgroundImage:[UIImage imageWithColor:kMAINDDDD] forState:UIControlStateDisabled];
        
        _nextStepBtn.layer.shadowOffset = CGSizeMake(0, 2.f);
        _nextStepBtn.layer.shadowOpacity = 1.f;
        _nextStepBtn.layer.shadowRadius = 2.f;
        _nextStepBtn.layer.cornerRadius = 22.f;
    }
    return _nextStepBtn;
}


@end
