//
//  LZBProgressView.h
//  LZBProject
//
//  Created by hicity on 2019/11/5.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, LZBProgressViewStyle) {
    LZBProgressViewStyleDefault,     // 默认
    LZBProgressViewStyleTrackFillet ,  // 轨道圆角(默认半圆)
    LZBProgressViewStyleAllFillet,  //进度与轨道都圆角
};

@interface LZBProgressView : UIView

@property(nonatomic) float progress;                        // 0.0 .. 1.0, 默认0 超出为1.
@property(nonatomic) LZBProgressViewStyle progressViewStyle;
@property(nonatomic,assign) BOOL isTile;  //背景图片是平铺填充 默认NO拉伸填充 设置为YES时图片复制平铺填充
@property(nonatomic, strong, nullable) UIColor* progressTintColor;
@property(nonatomic, strong, nullable) UIColor* trackTintColor;
@property(nonatomic, strong, nullable) UIImage* progressImage;  //进度条背景图片,默认拉伸填充  优先级大于背景色
@property(nonatomic, strong, nullable) UIImage* trackImage;     //轨道填充图片
@property (nonatomic, strong) NSString *progressTitle;
@property (nonatomic, strong) NSString *countString;

- (void)progressViewStyle:(LZBProgressViewStyle)style;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame progressViewStyle:(LZBProgressViewStyle)style;
@end

NS_ASSUME_NONNULL_END
