//
//  PCenterHeaderView.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/29.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "PCenterHeaderView.h"
#import "QRCodeAlertView.h"

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


@property (nonatomic, strong) QRCodeAlertView *codeManager;

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
    self.userHeadImageView.layer.cornerRadius = self.userHeadImageView.width / 2.f;
    self.userHeadImageView.clipsToBounds = YES;
    self.userHeadImageView.layer.borderWidth = 2.f;
    self.userHeadImageView.layer.borderColor = WHITECOLOR.CGColor;
    
    self.userHeadImageView.userInteractionEnabled = YES;
    [self.userHeadImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHeadImage:)]];
    
    self.bottomContainerView.layer.cornerRadius = 15.f;
    
    JMBaseButtonConfig *buttonConfig = [JMBaseButtonConfig buttonConfig];
    buttonConfig.titleFont = LZBFont(9.5f, NO);
    buttonConfig.backgroundColor = [UIColor clearColor];
    buttonConfig.image = IMAGE_NAMED(@"ic_message");
    
    CGFloat notice_w = 30.f;
    CGFloat notice_y =  kStatusBar_Height + (kNavBar_Height - notice_w) / 2.f;
    JMButton *nBtn = [[JMButton alloc] initWithFrame:CGRectMake(kScreenWidth - notice_w - 10, notice_y, notice_w, notice_w) ButtonConfig:buttonConfig];
    nBtn.contentMode = UIViewContentModeCenter;
    nBtn.badgeTextFont = LZBFont(9.5, NO);
    nBtn.badgeBackgroundColor = kMAINFCOD;
    nBtn.badgeOffset = CGPointMake(0, -10);
    [nBtn addTarget:self action:@selector(seeNoticeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nBtn];
    self.noticeBtn = nBtn;
}


#pragma mark - private Method

- (IBAction)seeNoticeAction:(UIButton *)sender {
    NSLog(@"通知消息");
//    if (self.clickSeeNoticeButton) {
//        self.clickSeeNoticeButton(sender);
//    }
    
    NotificationViewController *msgVC = [[NotificationViewController alloc] init];
    [self.vc.navigationController pushViewController:msgVC animated:YES];
}

- (void)selectHeadImage:(UITapGestureRecognizer *)tap {
    NSLog(@"更换头像");
//    if (self.selectHeadImageGes) {
//        self.selectHeadImageGes(tap);
//    }
}

- (IBAction)seeMyQRCodeAction:(UIButton *)sender {
    NSLog(@"二维码");
//    if (self.clickQRCodeButton) {
//        self.clickQRCodeButton(sender);
//    }
    
    QRCodeConfig *config = [[QRCodeConfig alloc] init];
    config.avatarImg = [UIImage imageNamed:@"user_touxiang_girl"];
    config.studentName = self.model.studentName;
    config.sex = [self.model.studentSex integerValue];
    config.schoolName = self.model.schoolName;
    config.className = self.model.className;
    // https://sit-wechat.abnertech.com/lochi/&studentId=1651&gradeClassId=154&studentName=同学2
    MJWeakSelf
    self.codeManager = [[QRCodeAlertView alloc] init];
    self.codeManager.config = config;
    [self.codeManager showAlert];
    [self.codeManager setDidHide:^{
        weakSelf.codeManager = nil;
    }];
}


- (IBAction)seeMyResourceAction:(UIButton *)sender {
    NSLog(@"我的资源");
//    if (self.clickSeeMyResourceButton) {
//        self.clickSeeMyResourceButton(sender);
//    }
}

- (IBAction)changePasswordAction:(UIButton *)sender {
    NSLog(@"更改密码");
//    if (self.clickChangePasswordButton) {
//        self.clickChangePasswordButton(sender);
//    }
}

- (IBAction)feedbackAction:(UIButton *)sender {
    NSLog(@"反馈");
//    if (self.clickFeedbackButton) {
//        self.clickFeedbackButton(sender);
//    }
}


- (void)setModel:(UserModel *)model {
    _model = model;

    self.userNameLb.text = model.studentName;
    
    switch ([model.studentSex integerValue]) {
        case LZBStudentSex_Boy:
            [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573020981836&di=02f321bb5313023f255e25324d895a86&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201810%2F18%2F20181018165026_sovtt.jpeg"] placeholderImage:IMAGE_NAMED(@"user_touxiang_boy")];
            self.userGenderImgV.hidden = NO;
            self.userGenderImgV.image = IMAGE_NAMED(@"user_boy");
            break;
            
        case LZBStudentSex_Girl:
            [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573020981836&di=02f321bb5313023f255e25324d895a86&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201810%2F18%2F20181018165026_sovtt.jpeg"] placeholderImage:IMAGE_NAMED(@"user_touxiang_girl")];
            self.userGenderImgV.hidden = NO;
            self.userGenderImgV.image = IMAGE_NAMED(@"user_girl");
            break;
            
        case LZBStudentSex_Secret:
            [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573020981836&di=02f321bb5313023f255e25324d895a86&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201810%2F18%2F20181018165026_sovtt.jpeg"] placeholderImage:IMAGE_NAMED(@"user_touxiang_girl")];
            self.userGenderImgV.hidden = YES;
            break;
            
        default:
            break;
    }
    
    self.userAccountLb.text = model.studentCode;
    self.userSchoolLb.text = model.schoolName;
    self.userClassLb.text = model.className;
}

@end
