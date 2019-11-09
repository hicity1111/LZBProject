//
//  LoginObtainPhoneNumVC.m
//  LZBProject
//
//  Created by 刘义增 on 2019/11/9.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LoginObtainPhoneNumVC.h"
#import "LYZTextField.h"

@interface LoginObtainPhoneNumVC ()

@property (nonatomic, strong) UILabel *bindPhoneLb;

@property (nonatomic, strong) LYZTextField *phoneNumTF;

@property (nonatomic, strong) JMBaseButton *nextStepBtn;

@end

@implementation LoginObtainPhoneNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mt_showNavigationTitle:@"绑定手机号"];
}



#pragma mark - custom Method

- (void)textFieldDidChange:(LYZTextField *)textField {
    
}

#pragma mark - lazy load

- (UILabel *)bindPhoneLb {
    if (!_bindPhoneLb) {
        _bindPhoneLb = [[UILabel alloc] init];
        _bindPhoneLb.text = @"绑定手机号";
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
        _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneNumTF;
}

- (JMBaseButton *)nextStepBtn {
    if (!_nextStepBtn) {
        JMBaseButtonConfig *config = [JMBaseButtonConfig buttonConfig];
        config.backgroundColor = kMAIN00B5;
        config.title = @"下一步";
        config.titleColor = WHITECOLOR;
        config.titleFont = LZBFont(18.f, NO);
        _nextStepBtn = [JMBaseButton buttonFrame:CGRectZero ButtonConfig:config];
        
        [_nextStepBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
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
