//
//  UIView+CornerRadius.m
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "UIView+CornerRadius.h"


@implementation UIView (CornerRadius)

/// 设置圆角（默认圆角为高度一半）
- (void)setCornerRadiusAuto {
    [self setCornerRadius: self.bounds.size.height / 2.f];
}

/// 设置圆角
- (void)setCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radius  需要设置的圆角大小
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
               withRadius:(CGFloat)radius {
    [self setRoundedCorners:corners
                  withRadii:CGSizeMake(radius, radius)];
}

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
                withRadii:(CGSize)radii {
    [self setRoundedCorners:corners
                  withRadii:radii
                   viewRect:self.bounds];
}


/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radius  需要设置的圆角大小
 *  @param rect    需要设置的圆角view的rect
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
               withRadius:(CGFloat)radius
                 viewRect:(CGRect)rect {
    [self setRoundedCorners:corners
                  withRadii:CGSizeMake(radius, radius)
                   viewRect:rect];
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    
    self.layer.mask = shape;
}

- (void)noCornerRadius {
    self.layer.mask = nil;
}

@end
