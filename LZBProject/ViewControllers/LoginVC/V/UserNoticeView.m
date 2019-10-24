//
//  UserNoticeView.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UserNoticeView.h"
#import "AppDelegate.h"

#define kAnimationDuration 0.25

@implementation UserNoticeView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = kUserNoticeTrans;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    CGFloat centerW = 315.f;
    CGFloat centerH = 390.f;
    UIView *centerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, centerW, centerH)];
    centerV.center = self.center;
    centerV.backgroundColor = WHITECOLOR;
    
    [self addSubview:centerV];
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
