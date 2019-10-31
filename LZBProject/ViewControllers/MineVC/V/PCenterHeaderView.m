//
//  PCenterHeaderView.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "PCenterHeaderView.h"

@interface PCenterHeaderView ()

/// 头像
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
/// 姓名
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
/// 性别
@property (weak, nonatomic) IBOutlet UIImageView *userGenderImgV;
/// 账号
@property (weak, nonatomic) IBOutlet UILabel *userAccountLb;
/// 学校
@property (weak, nonatomic) IBOutlet UILabel *userSchoolLb;
/// 班级
@property (weak, nonatomic) IBOutlet UILabel *userClassLb;
/// 二维码
@property (weak, nonatomic) IBOutlet UIButton *userQRCodeBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomContainerView;
/// 我的资源
@property (weak, nonatomic) IBOutlet UIButton *myResourceBtn;
/// 更改密码
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;
/// 反馈意见
@property (weak, nonatomic) IBOutlet UIButton *feedbackBtn;
/// 通知消息
@property (weak, nonatomic) IBOutlet UIButton *noticeBtn;

/// 消息按钮距离顶部距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *noticeBtnTopConstraint;


@end

@implementation PCenterHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self customSetup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self customSetup];
}

- (void)customSetup {
    self.noticeBtnTopConstraint.constant = kStatusBar_Height + (kNavBar_Height - self.noticeBtn.height) / 2.f;
    
    self.userHeadImageView.layer.cornerRadius = self.userHeadImageView.width / 2.f;
    self.userHeadImageView.clipsToBounds = YES;
    self.userHeadImageView.layer.borderWidth = 2.f;
    self.userHeadImageView.layer.borderColor = WHITECOLOR.CGColor;
    
    self.userHeadImageView.userInteractionEnabled = YES;
    [self.userHeadImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHeadImage:)]];
    
    self.bottomContainerView.layer.cornerRadius = 15.f;
}


#pragma mark - private Method

- (IBAction)seeNoticeAction:(UIButton *)sender {
    NSLog(@"通知消息");
    if (self.clickSeeNoticeButton) {
        self.clickSeeNoticeButton(sender);
    }
}

- (void)selectHeadImage:(UITapGestureRecognizer *)tap {
    NSLog(@"更换头像");
    if (self.selectHeadImageGes) {
        self.selectHeadImageGes(tap);
    }
}

- (IBAction)seeMyQRCodeAction:(UIButton *)sender {
    NSLog(@"二维码");
    if (self.clickQRCodeButton) {
        self.clickQRCodeButton(sender);
    }
}


- (IBAction)seeMyResourceAction:(UIButton *)sender {
    NSLog(@"我的资源");
    if (self.clickSeeMyResourceButton) {
        self.clickSeeMyResourceButton(sender);
    }
}

- (IBAction)changePasswordAction:(UIButton *)sender {
    NSLog(@"更改密码");
    if (self.clickChangePasswordButton) {
        self.clickChangePasswordButton(sender);
    }
}

- (IBAction)feedbackAction:(UIButton *)sender {
    NSLog(@"反馈");
    if (self.clickFeedbackButton) {
        self.clickFeedbackButton(sender);
    }
}


@end
