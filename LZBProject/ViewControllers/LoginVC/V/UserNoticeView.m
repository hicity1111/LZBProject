//
//  UserNoticeView.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UserNoticeView.h"
#import "AppDelegate.h"

#define kAnimationDuration  0.25

@interface UserNoticeView ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *knowBtn;

@end

@implementation UserNoticeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kUserNoticeTrans;
        [self addSubviews];
        [self adjustIsAgreeUserNotice];
    }
    return self;
}

- (void)addSubviews {
    CGFloat centerW = 315.f;
    CGFloat centerH = 390.f;
    UIView *centerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, centerW, centerH)];
    centerV.center = self.center;
    centerV.backgroundColor = WHITECOLOR;
    centerV.layer.cornerRadius = 5.f;
    [self addSubview:centerV];
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.text = @"用户须知";
    titleLb.textColor = kMAIN3333;
    titleLb.font = LZBFont(22, YES);
    [titleLb sizeToFit];
    
    UILabel *btmLine = [[UILabel alloc] init];
    btmLine.backgroundColor = kMAIN00B5;
    
    UITextView *tv = [[UITextView alloc] init];
    tv.text = @"    在您下载、安装或使用快对作业APP产品及任何随附的文档（如有），包括提供给您的更新或升级版本（依据本协议之外的其他协议提供给您的更新或升级版本除外）（下文统称“快对作业”）之前，请您务必仔细阅读本协议中约定的下述条款。\n\
    除非您与北京智美智学科技有限公司（以下简称“公司”）就快对作业的使用另外签署了其他协议，否则您对快对作业的使用受本《快对作业用户服务协议》（以下简称“本协议”）中各项条款的约束。\n\
    请您仔细阅读以下条款，在您同意并接受本协议全部条款的前提下，公司将快对作业的合法使用授权授予您。如果您为未成年人，则您应在法定监护人陪同下审阅并遵守本协议，未成年人使用快对作业的行为视为其已获得了法定监护人的认可。如果您不同意接受本协议的全部条款，则您不得使用快对作业，您下载、安装、使用快对作业，则意味着您将自愿遵守本协议及快对作业的其他有关规则，并完全服从于快对作业的统一管理。快对作业有权根据业务需要对本协议不定时进行调整，并将调整后的协议公布于公司官网或者快对作业APP中，如果您不同意调整后的本协议的，您应当停止使用快对作业，否则，如果在公司调整本协议并公布后，您继续使用快对作业的，则视为您同意遵守调整后的本协议。\n\
    一、用户的权利与义务\n\
    1.    用户须通过合法渠道（包括但不仅限于各大应用市场、快对作业官网）下载、安装并使用快对作业，这是您获得快对作业使用授权的前提。\n\
    2.    用户一经注册或登录使用快对作业，即视为用户同意公司及/或其关联公司的客服人员与其进行电话联系。\n\
    3.    用户在快对作业内享有的服务内容由公司根据实际提供，并有权不时进行增加、删除、修改、或调整，包括但不限于：\n\
    扫码搜答案（扫码搜索、文字搜索）：用户通过搜索（条码、书名）根据题库反馈解析。\n\
    4.    使用快对作业时产生的通讯流量费用、上网费用由用户自行承担。\n\
    5.    用户应妥善保管自己的账号、密码，不得转让、出借、出租、出售或分享予他人使用。否则快对作业有权根据实际情况暂时封停或永久查封此账号，当用户的账号或密码遭到未经授权的使用时，用户应当立即通知快对作业，否则未经授权的使用行为均视为用户本人行为。\n\
    6.    公司有权随时对快对作业提供的服务内容等进行调整，包括但不限于增加、删除、修改快对作业服务内容，一旦快对作业的服务内容发生增加、删除、修改，快对作业将在相关页面上进行提示；如果用户不同意相关变更和修改，可以取消已经获取的服务并停止使用；如果用户继续使用快对作业提供的服务，则视为用户已经接受全部变更、修改。除非另有明确约定，否则用户使用快对作业内新增的服务内容将同样受本协议各项条款的约束。\n\
    7.    公司禁止以任何形式倒卖、贩售、出租、出借、转让用户账号的行为，一经查明，公司将采取包括但不限于封号、封禁IP、追究相关责任人法律责任的处理措施。";
    tv.textColor = kMAIN9696;
    tv.font = LZBRegularFont(15);
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"user_notice_check_none"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"user_notice_check"] forState:UIControlStateSelected];
    selectBtn.adjustsImageWhenHighlighted = NO;
    [selectBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.selected = NO;
    self.selectBtn = selectBtn;
    NSAttributedString *attStr1 = [[NSAttributedString alloc] initWithString:@"已阅读并同意" attributes:@{NSFontAttributeName: LZBRegularFont(14), NSForegroundColorAttributeName: kMAIN9696}];
    NSAttributedString *attStr2 = [[NSAttributedString alloc] initWithString:@"《用户服务协议》" attributes:@{NSFontAttributeName: LZBRegularFont(14), NSForegroundColorAttributeName: KMAIN5868}];
    NSMutableAttributedString *mAttStr = [[NSMutableAttributedString alloc] initWithAttributedString:attStr1];
    [mAttStr appendAttributedString:attStr2];
    [selectBtn setAttributedTitle:mAttStr forState:UIControlStateNormal];
    [selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    UIButton *knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    knowBtn.backgroundColor = UIColor.lightGrayColor;
    [knowBtn setTitle:@"知道了" forState:UIControlStateNormal];
    [knowBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    knowBtn.titleLabel.font = LZBRegularFont(16.f);
    [knowBtn addTarget:self action:@selector(knowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.knowBtn = knowBtn;

    [centerV addSubview:btmLine];
    [centerV addSubview:titleLb];
    [centerV addSubview:tv];
    [centerV addSubview:selectBtn];
    [centerV addSubview:knowBtn];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerV).offset(10);
        make.centerX.equalTo(centerV);
    }];
    [btmLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLb).offset(-2);
        make.right.equalTo(titleLb).offset(2);
        make.height.mas_equalTo(3.5);
        make.bottom.equalTo(titleLb).offset(-3.5);
    }];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLb.mas_bottom).offset(20.f);
        make.left.equalTo(centerV).offset(22.f);
        make.right.equalTo(centerV).offset(-22.f);
        make.height.mas_equalTo(200.f);
    }];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240.f);
        make.height.mas_equalTo(36.f);
        make.top.equalTo(tv.mas_bottom).offset(20.f);
        make.left.equalTo(centerV).offset(20.f);
    }];
    [knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.height.mas_equalTo(36.f);
        make.top.equalTo(selectBtn.mas_bottom).offset(20.f);
        make.centerX.equalTo(centerV.mas_centerX);
    }];
    
    [self layoutIfNeeded];
    btmLine.clipsToBounds = YES;
    btmLine.layer.cornerRadius = btmLine.height / 2.f;
    knowBtn.layer.cornerRadius = knowBtn.height / 2.f;
}

#pragma mark - Action
- (void)selectButtonClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    SETUSER_BOOL(AGREE_USER_NOTICE, btn.selected);
    [SDUserDefaults synchronize];
    if (btn.selected) {
        self.knowBtn.backgroundColor = kMAIN00B5;
    } else {
        self.knowBtn.backgroundColor = UIColor.lightGrayColor;
    }
}

- (void)knowButtonClick:(UIButton *)btn {
    if (self.selectBtn.selected) {
        SETUSER_BOOL(AGREE_USER_NOTICE, YES);
        [SDUserDefaults synchronize];
        [self hide];
    } else {
        [MBProgressHUD showMessage:@"请勾选“同意用户服务协议”" inView:self];
    }
}


#pragma mark - Method

- (void)adjustIsAgreeUserNotice {
    BOOL isAgree = GETUSER_BOOL(AGREE_USER_NOTICE);
    self.selectBtn.selected = isAgree;
    if (isAgree) {
        self.knowBtn.backgroundColor = kMAIN00B5;
    } else {
        self.knowBtn.backgroundColor = UIColor.lightGrayColor;
    }
}

- (void)show {
    self.alpha = 0.f;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 1.f;
    }];
}

- (void)hide {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
