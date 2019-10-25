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

@interface LoginViewController ()

@property (nonatomic, strong) LYZTextField *userTF;

@property (nonatomic, strong) LYZTextField *pwdTF;

@property (nonatomic, strong) UIButton *showPwdBtn;

@property (nonatomic, strong) UIButton *savePwdBtn;

@property (nonatomic, strong) UIButton *forgetPwdBtn;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *seeUserNotice;

@end

@implementation LoginViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    
    [self addSubviews];
    [self adjustShowUserNoticeView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}


#pragma mark - Private Methods
- (void)adjustShowUserNoticeView {
    BOOL isUserAgreeNotice = [[NSUserDefaults standardUserDefaults] boolForKey:@"agreeUserNotice"];
    if (!isUserAgreeNotice) {
        [self showUserNoticeView];
    }
}

- (void)showUserNoticeView {
    UserNoticeView *unv = [[UserNoticeView alloc] init];
    [unv show];
}

- (void)addSubviews {
    [self addBackgroundImage];
    
    // 创建subviews
    UIImageView *logoV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    logoV.size = CGSizeMake(185.f, 71.f);
    
    LYZTextField *userTF = [[LYZTextField alloc] init];
    userTF.backgroundColor = WHITECOLOR;
    userTF.placeholder = @"请输入账号";
    userTF.textColor = kMAIN3333;
    userTF.font = LZBRegularFont(16);
    userTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    userTF.autocorrectionType = UITextAutocorrectionTypeNo;
    userTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 开始编辑前清空输入框
//    userTF.clearsOnBeginEditing = YES;
    userTF.tintColor = kMAIN3333;
    self.userTF = userTF;
    
    LYZTextField *pwdTF = [[LYZTextField alloc] init];
    pwdTF.backgroundColor = WHITECOLOR;
    pwdTF.placeholder = @"请输入密码";
    pwdTF.textColor = kMAIN3333;
    pwdTF.font = LZBRegularFont(16);
    pwdTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    pwdTF.autocorrectionType = UITextAutocorrectionTypeNo;
    pwdTF.secureTextEntry = YES;
    pwdTF.tintColor = kMAIN3333;
    self.pwdTF = pwdTF;
    
    /// 记住密码
    UIButton *savePwd = [UIButton buttonWithType:UIButtonTypeCustom];
    savePwd.backgroundColor = UIColor.clearColor;
    [savePwd setTitle:@"记住密码" forState:UIControlStateNormal];
    [savePwd setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    savePwd.titleLabel.font = LZBRegularFont(14);
    [savePwd setImage:[UIImage imageNamed:@"login_pwd_save_uncheck"] forState:UIControlStateNormal];
    [savePwd setImage:[UIImage imageNamed:@"login_pwd_save_check"] forState:UIControlStateSelected];
    savePwd.adjustsImageWhenHighlighted = NO;
    [savePwd setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [savePwd addTarget:self action:@selector(savePasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.savePwdBtn = savePwd;
    
    /// 忘记密码
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwd.backgroundColor = UIColor.clearColor;
    [forgetPwd setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPwd setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    forgetPwd.titleLabel.font = LZBRegularFont(14);
    [forgetPwd addTarget:self action:@selector(forgetPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.forgetPwdBtn = forgetPwd;
    
    /// 登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = kMAINFF7E;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    loginBtn.titleLabel.font = LZBRegularFont(18);
    [loginBtn addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn = loginBtn;
    
    /// 查看用户协议
    NSAttributedString *un1 = [[NSAttributedString alloc] initWithString:@"《" attributes:@{NSFontAttributeName: LZBRegularFont(13), NSForegroundColorAttributeName: kMAINCBE6}];
    NSAttributedString *un2 = [[NSAttributedString alloc] initWithString:@"用户服务协议" attributes:@{NSFontAttributeName: LZBRegularFont(13), NSForegroundColorAttributeName: kMAINCBE6, NSUnderlineStyleAttributeName: @(1), NSUnderlineColorAttributeName: kMAINCBE6}];
    NSAttributedString *un3 = [[NSAttributedString alloc] initWithString:@"》" attributes:@{NSFontAttributeName: LZBRegularFont(13), NSForegroundColorAttributeName: kMAINCBE6}];
    NSMutableAttributedString *unMAttStr = [[NSMutableAttributedString alloc] initWithAttributedString:un1];
    [unMAttStr appendAttributedString:un2];
    [unMAttStr appendAttributedString:un3];
    
    UIButton *seeUserNotice = [UIButton buttonWithType:UIButtonTypeCustom];
    seeUserNotice.backgroundColor = UIColor.clearColor;
    [seeUserNotice addTarget:self action:@selector(seeUserNoticeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.savePwdBtn = seeUserNotice;
    [seeUserNotice setAttributedTitle:unMAttStr forState:UIControlStateNormal];
    
    // 公司信息
    UILabel *compLb = [[UILabel alloc] init];
    compLb.text = @"北京艾博纳信息技术有限公司";
    compLb.textAlignment = NSTextAlignmentCenter;
    compLb.textColor = WHITECOLOR;
    compLb.font = LZBRegularFont(14);
    [compLb sizeToFit];
    
    // 电话
    UILabel *phoneLb = [[UILabel alloc] init];
    phoneLb.text = @"400-016-2123";
    phoneLb.textAlignment = NSTextAlignmentCenter;
    phoneLb.textColor = WHITECOLOR;
    phoneLb.font = LZBRegularFont(14);
    [phoneLb sizeToFit];
    
    
    // 添加subviews
    [self.view addSubview:logoV];
    [self.view addSubview:userTF];
    [self.view addSubview:pwdTF];
    [self.view addSubview:savePwd];
    [self.view addSubview:forgetPwd];
    [self.view addSubview:loginBtn];
    [self.view addSubview:seeUserNotice];
    [self.view addSubview:compLb];
    [self.view addSubview:phoneLb];
    
    
    // 设置约束
    [logoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(88.f);
        make.centerX.equalTo(self.view);
    }];
    [phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-14);
        make.centerX.equalTo(self.view);
    }];
    [compLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(phoneLb.mas_top).offset(-10);
        make.centerX.equalTo(self.view);
    }];
    [userTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300.f);
        make.height.mas_equalTo(48.f);
        make.centerX.equalTo(self.view);
        make.top.equalTo(logoV.mas_bottom).offset(75.f);
    }];
    [pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300.f);
        make.height.mas_equalTo(48.f);
        make.centerX.equalTo(self.view);
        make.top.equalTo(userTF.mas_bottom).offset(16.f);
    }];
    [savePwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
        make.left.equalTo(self.view).offset(30.f);
        make.top.equalTo(pwdTF.mas_bottom).offset(10.f);
    }];
    [forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100.f);
        make.height.mas_equalTo(30.f);
        make.right.equalTo(self.view).offset(-30.f);
        make.centerY.equalTo(savePwd);
    }];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300.f);
        make.height.mas_equalTo(44.f);
        make.centerX.equalTo(self.view);
        make.top.equalTo(savePwd.mas_bottom).offset(10.f);
    }];
    [seeUserNotice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(30.f);
        make.centerX.equalTo(self.view);
        make.top.equalTo(loginBtn.mas_bottom).offset(15.f);
    }];
    
    [self.view layoutIfNeeded];
    userTF.layer.cornerRadius = userTF.height / 2;
    pwdTF.layer.cornerRadius = userTF.height / 2;
    loginBtn.layer.cornerRadius = userTF.height / 2;
    
    
    
    // 设置约束过后，textfield才有正确的frame
    [self textfieldAddCustomView];
}

- (void)addBackgroundImage {
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"login_bg@3x.png" ofType:nil];
    imgV.image = [UIImage imageWithContentsOfFile:imgPath];
//    imgV.image = [UIImage imageNamed:@"login_bg"];
    [self.view addSubview:imgV];
}

- (void)textfieldAddCustomView {
    self.userTF.leftMargin = 15.f;
    self.userTF.rightMargin = 20.f;
    UIImageView *userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
    userIcon.frame = CGRectMake(0, 0, 35, 17);
    userIcon.contentMode = UIViewContentModeCenter;
    self.userTF.cusLeftView = userIcon;
    
    self.pwdTF.leftMargin = 15.f;
    self.pwdTF.rightMargin = 10.f;
    UIImageView *pwdIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_pwd"]];
    pwdIcon.frame = CGRectMake(0, 0, 35, 17);
    pwdIcon.contentMode = UIViewContentModeCenter;
    self.pwdTF.cusLeftView = pwdIcon;
    
    UIButton *showPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showPwdBtn.frame = CGRectMake(0, 0, 35, 30);
    [showPwdBtn setImage:[UIImage imageNamed:@"login_pwd_hide"] forState:UIControlStateNormal];
    [showPwdBtn setImage:[UIImage imageNamed:@"login_pwd_show"] forState:UIControlStateSelected];
    showPwdBtn.adjustsImageWhenHighlighted = NO;
    [showPwdBtn addTarget:self action:@selector(showPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.pwdTF.cusRightView = showPwdBtn;
}


#pragma mark - Event Response

- (void)showPasswordButtonClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.pwdTF.secureTextEntry = !btn.selected;
}

- (void)savePasswordButtonClick:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (void)forgetPasswordButtonClick:(UIButton *)btn {
    
}

- (void)loginButtonClick:(UIButton *)btn {
    
}

- (void)seeUserNoticeButtonClick:(UIButton *)btn {
    [self showUserNoticeView];
}

#pragma mark - Getters and Setters

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end