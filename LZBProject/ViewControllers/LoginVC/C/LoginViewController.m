//
//  LoginViewController.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginViewController.h"
#import "UserNoticeView.h"
#import "LYZTextField.h"
#import "LZBNetworkURL.h"
#import "LoginDataService.h"
#import "UIImage+CompressImage.h"
#import "LoginNobindPhoneAlertView.h"
#import "LoginObtainPhoneNumVC.h"
#import "NSObject+charValid.h"

#import "AppDelegate.h"

static CGFloat bigViewW = 300.f;
//static CGFloat bigViewLeftSpace = 37.5;
static CGFloat userH = 48.f, pwdH = 48.f, saveH = 30.f, upSpace = 16.f, psSpace = 10.f;
static CGFloat phoheH = 48.f, verH = 48.f, pvSpace = 16.f, vsSpace = 15.f;

@interface LoginViewController () <UITextFieldDelegate>
{
    NSString *_username;
    NSString *_password;
    
    CGFloat pwdConH;
    CGFloat verConH;
}

@property (nonatomic, strong) LoginDataService  *dataService;

/// backgroundImage
@property (nonatomic, strong) UIImageView       *backImgV;
/// logo
@property (nonatomic, strong) UIImageView       *logoV;

/// 密码登录容器（用户名、密码、记住密码、忘记密码）
@property (nonatomic, strong) UIView            *pwdContainerV;
/// 验证码登录容器（手机号、验证码）
@property (nonatomic, strong) UIView            *verifyCodeContainerV;


/// 用户名 输入框
@property (nonatomic, strong) LYZTextField      *userTF;
/// 密码 输入框
@property (nonatomic, strong) LYZTextField      *pwdTF;
/// 显示/隐藏 密码
@property (nonatomic, strong) UIButton          *showPwdBtn;
/// 记住密码
@property (nonatomic, strong) UIButton          *savePwdBtn;
/// 忘记密码
@property (nonatomic, strong) UIButton          *forgetPwdBtn;


/// 手机号
@property (nonatomic, strong) LYZTextField      *phoneTF;
/// 验证码
@property (nonatomic, strong) LYZTextField      *verifyCodeTF;
/// 发送验证码按钮
@property (nonatomic, strong) JMBaseButton      *sendVerifyCodeBtn;


/// 登录
@property (nonatomic, strong) UIButton          *loginBtn;
/// 密码登录/验证码登录切换按钮
@property (nonatomic, strong) UIButton          *swichBtn;

/// 查看用户服务协议
@property (nonatomic, strong) UIButton          *seeUserNotice;
/// 公司信息
@property (nonatomic, strong) UILabel           *compLb;
/// 公司电话
@property (nonatomic, strong) UILabel           *phoneLb;

@end

@implementation LoginViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pwdConH = userH + upSpace + pwdH + psSpace + saveH;
    verConH = phoheH + verH + pvSpace + vsSpace;
    
    [self addSubviews];
    [self adjustShowUserNoticeView];
    
    BOOL isSavePwd = GETUSER_BOOL(IS_SELECT_SAVEPWD);
    self.savePwdBtn.selected = isSavePwd;
    
    [self fillTextField];
    [self updateLoginButtonState];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


#pragma mark - Private Methods
- (void)adjustShowUserNoticeView {
    BOOL isUserAgreeNotice = GETUSER_BOOL(AGREE_USER_NOTICE);
    
    if (!isUserAgreeNotice) {
        [self showUserNoticeView];
    } else {
//        [self.userTF becomeFirstResponder];
    }
}

// 从plish文件取出用户名和密码 并 填充到用户名和密码输入框
- (void) fillTextField {
    NSString *userName = GETUSER_STRING(USER_NAME);
    if (userName && userName.length > 0) {
        self.userTF.text = userName;
    }
    NSString *pwd = GETUSER_STRING(USER_PASSWORD);
    if (pwd && pwd.length > 0) {
        self.pwdTF.text = pwd;
    }
}

// 更新 登录按钮 是否可用的状态
- (void)updateLoginButtonState {
    /// 验证码登录
    if (self.swichBtn.selected) {
        if (self.phoneTF.text.length > 0 && self.verifyCodeTF.text.length > 0) {
            self.loginBtn.enabled = YES;
            _loginBtn.layer.shadowColor = kMAIN4759.CGColor;
        } else {
            self.loginBtn.enabled = NO;
            _loginBtn.layer.shadowColor = kMAINDDDD.CGColor;
        }
    }
    /// 密码登录
    else {
        if (self.pwdTF.text.length > 0 && self.userTF.text.length > 0) {
            self.loginBtn.enabled = YES;
            _loginBtn.layer.shadowColor = kMAIN4759.CGColor;
        } else {
            self.loginBtn.enabled = NO;
            _loginBtn.layer.shadowColor = kMAINDDDD.CGColor;
        }
    }
}

// 显示 用户服务协议 弹窗
- (void)showUserNoticeView {
    UserNoticeView *unv = [[UserNoticeView alloc] init];
    [unv show];
}

// 显示 未绑定手机号 弹窗
- (void)showUnbindingPhoneAlertView {
    LoginNobindPhoneAlertView *alert = [[LoginNobindPhoneAlertView alloc] init];
    [alert setTouchAlreadyBindBlock:^(UIButton * _Nonnull btn) {
//        [self showSuccess:@"已绑定手机号跳转"];
        LoginObtainPhoneNumVC *fillNumVC = [[LoginObtainPhoneNumVC alloc] init];
        [self.navigationController pushViewController:fillNumVC animated:YES];
    }];
    [alert show];
}

// 添加subviews
- (void)addSubviews {
    [self.view addSubview:self.backImgV];
    [self.view addSubview:self.logoV];
    
    [self.view addSubview:self.pwdContainerV];
    [self.view addSubview:self.verifyCodeContainerV];
    self.verifyCodeContainerV.hidden = YES;
    
    [self.view addSubview:self.loginBtn];
    self.loginBtn.enabled = NO;
    
    [self.view addSubview:self.swichBtn];
    [self.view addSubview:self.seeUserNotice];
    [self.view addSubview:self.compLb];
    [self.view addSubview:self.phoneLb];
    
    [self updateSubviewsFrame];
}

/// 更新frame
- (void)updateSubviewsFrame {
    CGFloat topMargin = 88.f;
    if (kScreenHeight > 667.f) {
        topMargin = (kScreenHeight - 480.f) / 2.f;
    }
    // 设置约束
    [self.logoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(topMargin);
        make.centerX.equalTo(self.view);
    }];
    
    [self.phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-14);
        make.centerX.equalTo(self.view);
    }];
    [self.compLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.phoneLb.mas_top).offset(-10);
        make.centerX.equalTo(self.view);
    }];
    [self.seeUserNotice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(30.f);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.compLb.mas_top).offset(-10.f);
    }];

    [self.pwdContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(bigViewW);
        make.height.mas_equalTo(pwdConH);
        make.top.equalTo(self.logoV.mas_bottom).offset(75.f);
        make.centerX.equalTo(self.view);
    }];
    [self.userTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.pwdContainerV);
        make.height.mas_equalTo(userH);
    }];
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.pwdContainerV);
        make.height.mas_equalTo(pwdH);
        make.top.equalTo(self.userTF.mas_bottom).offset(upSpace);
    }];
    [self.savePwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(saveH);
        make.left.equalTo(self.pwdTF);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(psSpace);
    }];
    [self.forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100.f);
        make.top.bottom.equalTo(self.savePwdBtn);
        make.right.equalTo(self.pwdTF);
    }];
    
    [self.verifyCodeContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(bigViewW);
        make.height.mas_equalTo(verConH);
        make.top.equalTo(self.logoV.mas_bottom).offset(75.f);
        make.centerX.equalTo(self.view);
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.verifyCodeContainerV);
        make.height.mas_equalTo(phoheH);
    }];
    [self.verifyCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.verifyCodeContainerV);
        make.height.mas_equalTo(verH);
        make.top.equalTo(self.userTF.mas_bottom).offset(pvSpace);
    }];

    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(bigViewW);
        make.height.mas_equalTo(44.f);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.pwdContainerV.mas_bottom).offset(10.f);
    }];
    
    [self.swichBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(30.f);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(22.f);
    }];

    [self.view layoutIfNeeded];
    
    [self.userTF setCornerRadiusAuto];
    [self.pwdTF setCornerRadiusAuto];
    [self.phoneTF setCornerRadiusAuto];
    [self.verifyCodeTF setCornerRadiusAuto];
    [self.loginBtn setCornerRadiusAuto];

    // 设置约束过后，textfield才有正确的frame
    [self textfieldAddCustomView];
}

// 输入框添加 自定义 左右view
- (void)textfieldAddCustomView {
    CGFloat leftMargin = 15.f;
    CGRect iconRect = CGRectMake(0, 0, 35, 17);
    
    self.userTF.leftMargin = leftMargin;
    self.userTF.rightMargin = 20.f;
    UIImageView *userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
    userIcon.frame = iconRect;
    userIcon.contentMode = UIViewContentModeCenter;
    self.userTF.cusLeftView = userIcon;
    
    self.pwdTF.leftMargin = leftMargin;
    self.pwdTF.rightMargin = 10.f;
    UIImageView *pwdIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_pwd"]];
    pwdIcon.frame = iconRect;
    pwdIcon.contentMode = UIViewContentModeCenter;
    self.pwdTF.cusLeftView = pwdIcon;
    self.pwdTF.cusRightView = self.showPwdBtn;
    
    self.phoneTF.leftMargin = leftMargin;
    self.phoneTF.rightMargin = 20.f;
    UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"login_phoneNum")];
    phoneIcon.frame = iconRect;
    phoneIcon.contentMode = UIViewContentModeCenter;
    self.phoneTF.cusLeftView = phoneIcon;
    
    self.verifyCodeTF.leftMargin = leftMargin;
    self.verifyCodeTF.rightMargin = 20.f;
    UIImageView *verifyIcon = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"login_verifyCode")];
    verifyIcon.frame = iconRect;
    verifyIcon.contentMode = UIViewContentModeCenter;
    self.verifyCodeTF.cusLeftView = verifyIcon;
    self.verifyCodeTF.cusRightView = self.sendVerifyCodeBtn;
}

- (void)loginWithUsernameAndPassword {
    LZBWeak;
    NSString *name = self.userTF.text;
    NSString *pwd = self.pwdTF.text;
    
    [self.dataService loginWithUsername:name password:pwd success:^(UserModel *userModel) {
        XLDLog(@"请求成功");
        
        NSDictionary *userInfoDic = [userModel mj_keyValues];
        [Utils saveUserInfo:userInfoDic];
        
        ///持久化用户信息
        [UserModel save:userModel resBlock:^(BOOL res) {}];
        
        SETUSER_OBJ(USER_NAME, name);
        if (weakSelf.savePwdBtn.selected) {
            SETUSER_OBJ(USER_PASSWORD, pwd);
        } else {
            REMOVEUSER_OBJ(USER_PASSWORD);
        }
        SETUSER_OBJ(ACCESS_TOKEN, userModel.token);
        SETUSER_BOOL(IS_USER_LOGIN, YES);
        SDUserDefaultsSync;
        
        [weakSelf showSuccess:@"登录成功"];
        [weakSelf.view endEditing:YES];
        AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appd entryDoor];
        
    } failure:^(NSError * _Nonnull error) {
        NSInteger code = error.code;
        switch (code) {
            case NSURLErrorTimedOut:
                [weakSelf showError:@"网络不给力，请稍后再试"];
                break;
            case NSURLErrorUnknown:
            case NSURLErrorBadURL:
                [weakSelf showError:@"无效的URL地址"];
                break;
            case NSURLErrorCancelled:
                [weakSelf showError:@"请求被取消"];
                break;
                
            default:
                [weakSelf showError:@"未知错误"];
                break;
        }
    }];

}

- (void)loginWithPhoneNumAndVerifyCode {
    NSString *phone = self.phoneTF.text;
    NSString *veriCode = self.verifyCodeTF.text;
    
    [self showSuccess:[NSString stringWithFormat:@"%@ + %@", phone, veriCode]];
}


/// 整页翻转
- (void)switchLoginWay_trans:(BOOL)sel {
    UIViewAnimationOptions animationOptions = sel ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionFromView:(sel ? self.pwdContainerV : self.verifyCodeContainerV)
                        toView:(sel ? self.verifyCodeContainerV : self.pwdContainerV)
                      duration:1.f
                       options:(animationOptions | UIViewAnimationOptionShowHideTransitionViews)
                    completion:nil];
    
    if (sel) {
        [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(bigViewW);
            make.height.mas_equalTo(44.f);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.pwdContainerV.mas_bottom).offset(10.f);
        }];
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(bigViewW);
                make.height.mas_equalTo(44.f);
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.verifyCodeContainerV.mas_bottom).offset(10.f);
            }];
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(bigViewW);
            make.height.mas_equalTo(44.f);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.verifyCodeContainerV.mas_bottom).offset(10.f);
        }];
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(bigViewW);
                make.height.mas_equalTo(44.f);
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.pwdContainerV.mas_bottom).offset(10.f);
            }];
            [self.view layoutIfNeeded];
        }];
    }
}
/// 卡片式
- (void)switchLoginWay_sysAni:(BOOL)sel {
    if (sel) {
        self.verifyCodeContainerV.hidden = NO;
        self.verifyCodeContainerV.width = 0.f;
        self.verifyCodeContainerV.alpha = 0.f;
        
        self.pwdContainerV.alpha = 1.f;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.verifyCodeContainerV.width = bigViewW;
            self.verifyCodeContainerV.alpha = 1.f;
            
            self.pwdContainerV.width = 0.f;
            self.pwdContainerV.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            self.pwdContainerV.hidden = YES;
        }];
        
        [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(bigViewW);
            make.height.mas_equalTo(44.f);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.pwdContainerV.mas_bottom).offset(10.f);
        }];
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(bigViewW);
                make.height.mas_equalTo(44.f);
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.verifyCodeContainerV.mas_bottom).offset(10.f);
            }];
            [self.view layoutIfNeeded];
        }];
    }
    else {
        self.pwdContainerV.hidden = NO;
        self.pwdContainerV.alpha = 0.f;
        self.pwdContainerV.width = 0.f;
        
        self.verifyCodeContainerV.alpha = 1.f;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.pwdContainerV.width = bigViewW;
            self.pwdContainerV.alpha = 1.f;
            
            self.verifyCodeContainerV.width = 0;
            self.verifyCodeContainerV.alpha = 0.f;
            
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(bigViewW);
                make.height.mas_equalTo(44.f);
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.pwdContainerV.mas_bottom).offset(10.f);
            }];
        } completion:^(BOOL finished) {
            self.verifyCodeContainerV.hidden = YES;
        }];
        
        [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(bigViewW);
            make.height.mas_equalTo(44.f);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.verifyCodeContainerV.mas_bottom).offset(10.f);
        }];
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(bigViewW);
                make.height.mas_equalTo(44.f);
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.pwdContainerV.mas_bottom).offset(10.f);
            }];
            [self.view layoutIfNeeded];
        }];
    }
}


#pragma mark - Event Response

/// 点击显示密码
- (void)showPasswordAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.pwdTF.secureTextEntry = !btn.selected;
}

/// 点击 记住密码
- (void)savePasswordAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    SETUSER_BOOL(IS_SELECT_SAVEPWD, btn.selected);
    SDUserDefaultsSync;
}

/// 点击 忘记密码？
- (void)forgetPasswordAction:(UIButton *)btn {
//    [self showMessage:@"重设密码" afterDelay:0.5];
    
    // 有效手机号 - 沟通后台查看是否已注册
    if ([self.userTF.text mh_isValidMobile]) {
        
    }
    // 直接进入 未绑定手机号弹窗
    else {
        [self showUnbindingPhoneAlertView];
    }
}

/// 点击 获取验证码按钮
- (void)sendVerifyCodeAction:(JMBaseButton *)btn {
    [btn startCountDown:60 Detail:@"s"];
}

/// 点击 登录按钮
- (void)loginAction:(UIButton *)btn {
    /// 验证码登录
    if (self.swichBtn.selected) {
        NSString *phone = self.phoneTF.text;
        BOOL isValidPhone = [IFISNIL(phone) mh_isValidMobile];
        if (!isValidPhone) {
            [self showError:@"请输入正确的手机号"];
            return;
        }
        
        [self loginWithPhoneNumAndVerifyCode];
    }
    /// 密码登录
    else {
        NSString *user = self.userTF.text;
        if (user.length < 3) {
            [self showError:@"请输入正确的用户名"];
            return;
        }
        
        NSString *pwd = self.pwdTF.text;
        // 密码为空时，登录按钮不可用
//        if (pwd.length == 0) {
//            [self showError:@"请输入密码"];
//            return;
//        }
        if (![pwd lzb_isValidPassword]) {
            [self showError:@"请输入8-16位数字字母组合"];
            return;
        }
        
        [self loginWithUsernameAndPassword];
    }
}

/// 点击 验证码登录按钮
- (void)switchLoginWayAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateLoginButtonState];
    self.verifyCodeTF.text = @"";
    
//    [self switchLoginWay_trans:btn.selected];
    [self switchLoginWay_sysAni:btn.selected];
}

- (void)seeUserNoticeAction:(UIButton *)btn {
    [self showUserNoticeView];
}

#pragma mark - UITextfield Delegate

/**
 0-9     48-57
 A-Z     65-90
 a-z     97-122
 */
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    /// 删除键
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    const char *chars = [string cStringUsingEncoding:NSUTF8StringEncoding];
    char c = chars[0];
    
    if (textField == self.userTF || textField == self.pwdTF) {
        if ([self isAlphaNumChar:c]) {
            return YES;
        }
        return NO;
    }
    else if (textField == self.phoneTF || textField == self.verifyCodeTF) {
        if ([self isNumberChar:c]) {
            return YES;
        }
        return NO;
    }
    return YES;
}


- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == self.userTF) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
    else if (textField == self.pwdTF) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    else if (textField == self.phoneTF) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    else if (textField == self.verifyCodeTF) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    [self updateLoginButtonState];
}


#pragma mark - LazyLoad

- (LoginDataService *)dataService{
    _dataService = [LoginDataService shareData];
    return _dataService;
}

- (UIImageView *)backImgV {
    if (!_backImgV) {
        _backImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"login_bg@3x.png" ofType:nil];
        _backImgV.image = [UIImage imageWithContentsOfFile:imgPath];
    }
    return _backImgV;
}

- (UIImageView *)logoV {
    if (!_logoV) {
        _logoV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
        _logoV.size = CGSizeMake(185.f, 71.f);
    }
    return _logoV;
}

- (UIView *)pwdContainerV {
    if (!_pwdContainerV) {
        _pwdContainerV = [[UIView alloc] init];
        _pwdContainerV.backgroundColor = UIColor.clearColor;
        [_pwdContainerV addSubview:self.userTF];
        [_pwdContainerV addSubview:self.pwdTF];
        [_pwdContainerV addSubview:self.savePwdBtn];
        [_pwdContainerV addSubview:self.forgetPwdBtn];
    }
    return _pwdContainerV;
}

- (UIView *)verifyCodeContainerV {
    if (!_verifyCodeContainerV) {
        _verifyCodeContainerV = [[UIView alloc] init];
        _verifyCodeContainerV.backgroundColor = UIColor.clearColor;
        [_verifyCodeContainerV addSubview:self.phoneTF];
        [_verifyCodeContainerV addSubview:self.verifyCodeTF];
    }
    return _verifyCodeContainerV;
}

- (LYZTextField *)userTF {
    if (!_userTF) {
        _userTF = [[LYZTextField alloc] init];
        _userTF.backgroundColor = WHITECOLOR;
        _userTF.placeholder = @"请输入账号";
        _userTF.textColor = kMAIN3333;
        _userTF.font = LZBRegularFont(16);
        _userTF.keyboardType = UIKeyboardTypeNamePhonePad;
        _userTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userTF.tintColor = kMAIN3333;
        _userTF.delegate = self;
        [_userTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userTF;
}

- (LYZTextField *)pwdTF {
    if (!_pwdTF) {
        _pwdTF = [[LYZTextField alloc] init];
        _pwdTF.backgroundColor = WHITECOLOR;
        _pwdTF.placeholder = @"请输入密码";
        _pwdTF.textColor = kMAIN3333;
        _pwdTF.font = LZBRegularFont(16);
        _pwdTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _pwdTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _pwdTF.secureTextEntry = YES;
        _pwdTF.tintColor = kMAIN3333;
        _pwdTF.delegate = self;
        [_pwdTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTF;
}

- (UIButton *)showPwdBtn {
    if (!_showPwdBtn) {
        _showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showPwdBtn.frame = CGRectMake(0, 0, 35, 30);
        [_showPwdBtn setImage:[UIImage imageNamed:@"login_pwd_hide"] forState:UIControlStateNormal];
        [_showPwdBtn setImage:[UIImage imageNamed:@"login_pwd_show"] forState:UIControlStateSelected];
        _showPwdBtn.adjustsImageWhenHighlighted = NO;
        [_showPwdBtn addTarget:self action:@selector(showPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPwdBtn;
}

- (UIButton *)savePwdBtn {
    if (!_savePwdBtn) {
        _savePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _savePwdBtn.backgroundColor = UIColor.clearColor;
        [_savePwdBtn setTitle:@"记住密码" forState:UIControlStateNormal];
        [_savePwdBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _savePwdBtn.titleLabel.font = LZBRegularFont(14);
        [_savePwdBtn setImage:[UIImage imageNamed:@"login_pwd_save_uncheck"] forState:UIControlStateNormal];
        [_savePwdBtn setImage:[UIImage imageNamed:@"login_pwd_save_check"] forState:UIControlStateSelected];
        _savePwdBtn.adjustsImageWhenHighlighted = NO;
        [_savePwdBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [_savePwdBtn addTarget:self action:@selector(savePasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _savePwdBtn;
}

- (UIButton *)forgetPwdBtn {
    if (!_forgetPwdBtn) {
        _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetPwdBtn.backgroundColor = UIColor.clearColor;
        [_forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPwdBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _forgetPwdBtn.titleLabel.font = LZBRegularFont(14);
        [_forgetPwdBtn addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdBtn;
}

- (LYZTextField *)phoneTF {
    if (!_phoneTF) {
        _phoneTF = [[LYZTextField alloc] init];
        _phoneTF.backgroundColor = WHITECOLOR;
        _phoneTF.placeholder = @"请输入手机号";
        _phoneTF.textColor = kMAIN3333;
        _phoneTF.font = LZBRegularFont(16);
        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
        _phoneTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.tintColor = kMAIN3333;
        _phoneTF.delegate = self;
        [_phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTF;
}

- (LYZTextField *)verifyCodeTF {
    if (!_verifyCodeTF) {
        _verifyCodeTF = [[LYZTextField alloc] init];
        _verifyCodeTF.backgroundColor = WHITECOLOR;
        _verifyCodeTF.placeholder = @"请输入验证码";
        _verifyCodeTF.textColor = kMAIN3333;
        _verifyCodeTF.font = LZBRegularFont(16);
        _verifyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _verifyCodeTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _verifyCodeTF.tintColor = kMAIN3333;
        _verifyCodeTF.delegate = self;
        [_verifyCodeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _verifyCodeTF;
}

- (JMBaseButton *)sendVerifyCodeBtn {
    if (!_sendVerifyCodeBtn) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.title = @"获取验证码";
        config.titleColor = kMAIN0098;
        config.titleFont = LZBFont(16.f, NO);
        _sendVerifyCodeBtn = [JMBaseButton buttonFrame:CGRectMake(0, 0, 90, 30) ButtonConfig:config];
        _sendVerifyCodeBtn.backgroundColor = UIColor.clearColor;
        [_sendVerifyCodeBtn addTarget:self action:@selector(sendVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendVerifyCodeBtn;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = LZBRegularFont(18);
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:kMAINFF7E] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:kMAINDDDD] forState:UIControlStateDisabled];
        
        _loginBtn.layer.shadowOffset = CGSizeMake(0, 2.f);
        _loginBtn.layer.shadowOpacity = 1.f;
        _loginBtn.layer.shadowRadius = 2.f;
        _loginBtn.layer.cornerRadius = 22.f;
    }
    return _loginBtn;
}

- (UIButton *)swichBtn {
    if (!_swichBtn) {
        _swichBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _swichBtn.backgroundColor = UIColor.clearColor;
        [_swichBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [_swichBtn setTitle:@"密码登录" forState:UIControlStateSelected];
        [_swichBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _swichBtn.titleLabel.font = LZBFont(14.f, NO);
        [_swichBtn addTarget:self action:@selector(switchLoginWayAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _swichBtn;
}

- (UIButton *)seeUserNotice {
    if (!_seeUserNotice) {
        NSAttributedString *un1 = [[NSAttributedString alloc] initWithString:@"《" attributes:@{NSFontAttributeName: LZBRegularFont(13), NSForegroundColorAttributeName: kMAINCBE6}];
        NSAttributedString *un2 = [[NSAttributedString alloc] initWithString:@"用户服务协议" attributes:@{NSFontAttributeName: LZBRegularFont(13), NSForegroundColorAttributeName: kMAINCBE6, NSUnderlineStyleAttributeName: @(1), NSUnderlineColorAttributeName: kMAINCBE6}];
        NSAttributedString *un3 = [[NSAttributedString alloc] initWithString:@"》" attributes:@{NSFontAttributeName: LZBRegularFont(13), NSForegroundColorAttributeName: kMAINCBE6}];
        NSMutableAttributedString *unMAttStr = [[NSMutableAttributedString alloc] initWithAttributedString:un1];
        [unMAttStr appendAttributedString:un2];
        [unMAttStr appendAttributedString:un3];
        
        _seeUserNotice = [UIButton buttonWithType:UIButtonTypeCustom];
        _seeUserNotice.backgroundColor = UIColor.clearColor;
        [_seeUserNotice addTarget:self action:@selector(seeUserNoticeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_seeUserNotice setAttributedTitle:unMAttStr forState:UIControlStateNormal];
    }
    return _seeUserNotice;
}

- (UILabel *)compLb {
    if (!_compLb) {
        _compLb = [[UILabel alloc] init];
        _compLb.text = @"北京艾博纳信息技术有限公司";
        _compLb.textAlignment = NSTextAlignmentCenter;
        _compLb.textColor = WHITECOLOR;
        _compLb.font = LZBRegularFont(14);
        [_compLb sizeToFit];
    }
    return _compLb;
}

- (UILabel *)phoneLb {
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc] init];
        _phoneLb.text = @"400-016-2123";
        _phoneLb.textAlignment = NSTextAlignmentCenter;
        _phoneLb.textColor = WHITECOLOR;
        _phoneLb.font = LZBRegularFont(14);
        [_phoneLb sizeToFit];
    }
    return _phoneLb;
}

@end
