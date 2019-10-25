//
//  LZB_TabBarBadge.m
//  LZBProject
//
//  Created by hicity on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZB_TabBarBadge.h"

@implementation LZB_TabBarBadge

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSelf];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.layer.cornerRadius = self.frame.size.height/2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)configSelf{
    self.backgroundColor = kMAINFCOD;
    self.textColor = KMAINFFFF;
    self.font = KMAINFONT10;
    self.textAlignment = NSTextAlignmentCenter;
    self.clipsToBounds = YES;
    self.automaticHidden = YES;
    self.badgeHeight = 15;
    self.layer.borderColor = KMAINFFFF.CGColor;
    self.layer.borderWidth = 1;
}

- (void)setBadgeText:(NSString *)badgeText{
    _badgeText = badgeText;
    self.text = _badgeText;
    
    CGFloat widths = _badgeText.length*9<20?20:_badgeText.length*9;
    if (self.badgeWidth) {
        widths = self.badgeWidth;
    }
    if (_badgeText.integerValue) {// 是数字 或者不为0
        self.hidden = NO;
        if (_badgeText.integerValue > 99) {
            self.text = @"99+";
        }
    }else{
        if (!_badgeText.length) {// 长度为0的空串
            self.hidden = self.automaticHidden;
        }
    }
    CGRect frame      = self.frame;
    frame.size.width  = widths;
    frame.size.height = self.badgeHeight;
    self.frame = frame;
}
@end
