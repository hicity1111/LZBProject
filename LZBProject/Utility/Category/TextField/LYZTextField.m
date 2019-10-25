//
//  LYZTextField.m
//  zhixinContest
//
//  Created by zhixin on 16/6/17.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "LYZTextField.h"

#define Margin 42
#define ClearW 14

@implementation LYZTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark - Systom Private Method

// 重置编辑区域
- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (!self.leftMargin) {
        self.leftMargin = 0.1;
    }
    CGFloat leftV_W = 0.f;
    if (self.cusLeftView) {
        leftV_W = self.cusLeftView.bounds.size.width;
    }
    
    if (!self.rightMargin) {
        self.rightMargin = 0.f;
    }
    CGFloat rightV_W = 0.f;
    if (self.cusRightView) {
        rightV_W = self.cusRightView.bounds.size.width;
    }
    
    CGFloat leftS = self.leftMargin + leftV_W;
    CGFloat rightS = self.rightMargin + rightV_W;
    CGFloat width = bounds.size.width - leftS - rightS;
    
    return CGRectMake(leftS, 0, width, bounds.size.height);
}

// 重置文字区域
- (CGRect)textRectForBounds:(CGRect)bounds {
    if (!self.leftMargin) {
        self.leftMargin = 0.1;
    }
    CGFloat leftV_W = 0.f;
    if (self.cusLeftView) {
        leftV_W = self.cusLeftView.bounds.size.width;
    }
    
    if (!self.rightMargin) {
        self.rightMargin = 0.f;
    }
    CGFloat rightV_W = 0.f;
    if (self.cusRightView) {
        rightV_W = self.cusRightView.bounds.size.width;
    }
    
    CGFloat leftS = self.leftMargin + leftV_W;
    CGFloat rightS = self.rightMargin + rightV_W;
    CGFloat width = bounds.size.width - leftS - rightS;
    
    return CGRectMake(leftS, 0, width, bounds.size.height);
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
}


// 重置占位符区域
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if (!self.leftMargin) {
        self.leftMargin = 0.1;
    }
    CGFloat leftV_W = 0.f;
    if (self.cusLeftView) {
        leftV_W = self.cusLeftView.bounds.size.width;
    }
    
    if (!self.rightMargin) {
        self.rightMargin = 0.f;
    }
    CGFloat rightV_W = 0.f;
    if (self.cusRightView) {
        rightV_W = self.cusRightView.bounds.size.width;
    }
    
    CGFloat leftS = self.leftMargin + leftV_W;
    CGFloat rightS = self.rightMargin + rightV_W;
    CGFloat width = bounds.size.width - leftS - rightS;
    
    return CGRectMake(leftS, 0, width, bounds.size.height);
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [super drawPlaceholderInRect:rect];
}

// 重置clearButton位置
- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.size.width - ClearW - self.rightMargin,
                      (bounds.size.height - ClearW) / 2,
                      ClearW, ClearW);
}


#pragma mark - Custom Method
- (void)setCusLeftView:(UIView *)cusLeftView {
    CGRect oriRect = cusLeftView.bounds;
    CGFloat y = (self.bounds.size.height - oriRect.size.height) / 2.f;
    oriRect.origin.y = y;
    oriRect.origin.x = self.leftMargin;
    
    cusLeftView.frame = oriRect;
    _cusLeftView = cusLeftView;
    [self addSubview:cusLeftView];
}

- (void)setCusRightView:(UIView *)cusRightView {
    CGRect oriRect = cusRightView.bounds;
    CGFloat y = (self.bounds.size.height - oriRect.size.height) / 2.f;
    CGFloat x = self.bounds.size.width - self.rightMargin - oriRect.size.width;
    oriRect.origin.x = x;
    oriRect.origin.y = y;
    
    cusRightView.frame = oriRect;
    _cusRightView = cusRightView;
    [self addSubview:cusRightView];
}


@end
