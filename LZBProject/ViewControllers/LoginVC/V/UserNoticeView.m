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
        self.backgroundColor = kUserNoticeTrans;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
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
