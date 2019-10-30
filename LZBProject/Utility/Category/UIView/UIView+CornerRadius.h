//
//  UIView+CornerRadius.h
//  LZBProject
//
//  Created by 刘义增 on 2019/10/30.
//  Copyright © 2019 hicity. All rights reserved.
//

    
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, LYZRectCorner) {
    LYZRectCornerTopLeft        = 1 << 0,
    LYZRectCornerTopRight       = 1 << 1,
    LYZRectCornerBottomLeft     = 1 << 2,
    LYZRectCornerBottomRight    = 1 << 3,
    LYZRectCornerAllCorners     = ~0UL,
    
    LYZRectCornerTop            = LYZRectCornerTopLeft      | LYZRectCornerTopRight,
    LYZRectCornerBottom         = LYZRectCornerBottomLeft   | LYZRectCornerBottomRight,
    LYZRectCornerLeft           = LYZRectCornerTopLeft      | LYZRectCornerBottomLeft,
    LYZRectCornerRight          = LYZRectCornerTopRight     | LYZRectCornerBottomRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CornerRadius)

/// 设置圆角（默认圆角为高度一半）
- (void)setCornerRadiusAuto;

/// 设置圆角
- (void)setCornerRadius:(CGFloat)radius;

#pragma mark - 设置部分圆角

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radius  需要设置的圆角大小
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
               withRadius:(CGFloat)radius;

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
                withRadii:(CGSize)radii;

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radius  需要设置的圆角大小
 *  @param rect    需要设置的圆角view的rect
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
               withRadius:(CGFloat)radius
                 viewRect:(CGRect)rect;

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)setRoundedCorners:(LYZRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

- (void)noCornerRadius;


@end

NS_ASSUME_NONNULL_END
