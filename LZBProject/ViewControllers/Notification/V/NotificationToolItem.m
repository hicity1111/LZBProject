//
//  NotificationToolItem.m
//  LZBProject
//
//  Created by liyan on 2019/11/1.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "NotificationToolItem.h"
#import "NotifyListEntry.h"

@interface NotificationToolItem()
///虚线
@property (nonatomic, strong) UIImageView *dotImageV;
///消息来源 标题
@property (nonatomic, strong) UILabel *leftTitleLab;
///消息来源 内容
@property (nonatomic, strong) UILabel *sourceLab;
///右侧arrow
@property (nonatomic, strong) UIImageView *arrowImageV;
///右侧title
@property (nonatomic, strong) UILabel *rightTitleV;

@end

@implementation NotificationToolItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mt_loadUI];
        [self mt_loadFrame];
    }
    return self;
}


///MARK:- 赋值
- (void)setModel:(NotifyListEntry *)model {
    _model = model;
    
    ///系统消息
    if (model.noticeType == 1) {
        self.sourceLab.text = @"乐知帮";
        self.rightTitleV.hidden = NO;
        self.arrowImageV.hidden = NO;
    } else {
        self.sourceLab.text = [NSString stringWithFormat:@"%@", IFISNIL(model.noticeSendname)];
        self.rightTitleV.hidden = YES;
        self.arrowImageV.hidden = YES;
    }
}


///MARK:- 点击查看 点击事件
- (void)clickEvent {
    
}


///MARK: - Private Methods
- (void)mt_loadUI {
    [self addSubview:self.leftTitleLab];
    [self addSubview:self.sourceLab];
    [self addSubview:self.arrowImageV];
    [self addSubview:self.rightTitleV];
    [self addSubview:self.dotImageV];
}


- (void)mt_loadFrame {
    MJWeakSelf
    [self.dotImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.leftTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.mas_equalTo(0);
    }];
    
    [self.sourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.leftTitleLab.mas_right);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(14, 17));
        make.right.mas_equalTo(0);
    }];
    
    [self.rightTitleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(40);
        make.right.equalTo(weakSelf.arrowImageV.mas_left);
    }];
}


///MARK:- Getter and Setter
- (UIImageView *)dotImageV {
    if(!_dotImageV) {
        _dotImageV = [UIImageView new];
        _dotImageV.image = [UIImage imageNamed:@"notify_dot_line"];
    }
    return _dotImageV;
}

- (UILabel *)leftTitleLab {
    if (!_leftTitleLab) {
        _leftTitleLab = [UILabel new];
        _leftTitleLab.text = @"消息来源: ";
        _leftTitleLab.textColor = kMAIN9696;
        _leftTitleLab.font = KMAINFONT14;
    }
    return _leftTitleLab;
}

- (UILabel *)sourceLab {
    if (!_sourceLab) {
        _sourceLab = [UILabel new];
        _sourceLab.text = @"乐知帮";
        _sourceLab.textColor = KMAIN5868;
        _sourceLab.font = KMAINFONT14;
    }
    return _sourceLab;
}

- (UIImageView *)arrowImageV {
    if (!_arrowImageV) {
        _arrowImageV = [[UIImageView alloc] init];
        _arrowImageV.image = [UIImage imageNamed:@"notify_arrow"];
        _arrowImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent)];
        [_arrowImageV addGestureRecognizer:tap];
    }
    return _arrowImageV;
}

- (UILabel *)rightTitleV {
    if (!_rightTitleV) {
        _rightTitleV = [UILabel new];
        _rightTitleV.textColor = KMAIN00A2;
        _rightTitleV.font = KMAINFONT14;
        _rightTitleV.text = @"点击查看   ";
        _rightTitleV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent)];
        [_rightTitleV addGestureRecognizer:tap];
    }
    return _rightTitleV;
}


@end
