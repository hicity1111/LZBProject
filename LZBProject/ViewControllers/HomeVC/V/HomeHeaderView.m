//
//  HomeHeaderView.m
//  LZBProject
//
//  Created by hicity on 2019/10/28.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "HomeHeaderView.h"



@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kMAIN31AC;
        [self configSelf:frame];
    }
    return self;
}

- (void)configSelf:(CGRect)frame{
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = IMAGE_NAMED(@"ic_topbar_logo");
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = KMAINFONT14;
    _titleLabel.textColor = KMAINFFFF;
    [self addSubview:_titleLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15.5);
        make.bottom.equalTo(self.mas_bottom).offset(-11);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).offset(6);
        make.bottom.equalTo(_imageView);
        make.right.mas_equalTo(self).offset(42);
        make.height.mas_equalTo(14);
    }];
    
    JMBaseButtonConfig *buttonConfig = [JMBaseButtonConfig buttonConfig];
    buttonConfig.titleFont = LZBFont(9.5f, NO);
    buttonConfig.backgroundColor = [UIColor clearColor];
    buttonConfig.backgroundImage = IMAGE_NAMED(@"ic_message");
    
    _messageButton = [[JMButton alloc] initWithFrame:CGRectMake(kScreenWidth - 30, self.height - 31, 17, 17) ButtonConfig:buttonConfig];
    _messageButton.badgeTextFont = LZBFont(9.5, NO);
    _messageButton.badgeBackgroundColor = kMAINFCOD;
    _messageButton.badgeOffset = CGPointMake(0, -10);
    [_messageButton addTarget:self action:@selector(messageAct) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_messageButton];
    
    
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = _titleString;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue {
    
    [_messageButton showNumberBadgeValue:badgeValue];
}

- (void)removeBadgValue{
    [_messageButton removeBadgeValue];
}

- (void)messageAct{

    if ([self.delegate respondsToSelector:@selector(messageAct)]) {
        [self.delegate messageAct];
    }
}

@end
