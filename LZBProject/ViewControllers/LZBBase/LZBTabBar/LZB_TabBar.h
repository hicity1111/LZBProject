//
//  LZB_TabBar.h
//  LZBProject
//
//  Created by hicity on 2019/10/25.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZB_TabBarBadge.h"
#import "LZB_TabBarItem.h"

NS_ASSUME_NONNULL_BEGIN
@class LZB_TabBar;
@class LZB_TabBarConfigModel;


@protocol LZB_TabBarDelegate <NSObject >

- (void)LZB_TabBar:(LZB_TabBar *)tabbar selectIndex:(NSInteger)index;

@end

@interface LZB_TabBar : UIView

#pragma mark - 主动属性
// 重载构造创建方法
- (instancetype)initWithTabBarConfig:(NSArray <LZB_TabBarConfigModel *> *)tabBarConfig;

// 直接设置/SET方法
@property(nonatomic, strong)NSArray <LZB_TabBarConfigModel *>*tabBarConfig;

// 进行item子视图重新布局 最好推荐在TabBarVC中的 -viewDidLayoutSubviews 中执行，可以达到自动布局的效果
- (void)viewDidLayoutItems;

// TabBar背景图
@property(nonatomic, strong)UIImageView *backgroundImageView;

// 当前选中的 TabBar
@property (nonatomic, strong) LZB_TabBarItem *currentSelectItem;

// 设置角标
- (void)setBadge:(NSString *)Badge index:(NSUInteger)index;

// 是否开启毛玻璃模糊效果 默认NO不开启
@property(nonatomic, assign)BOOL translucent;

// 模糊效果的构造Style
@property(nonatomic, strong)UIBlurEffect* effect;

// 模糊效果的视图
@property(nonatomic, strong)UIVisualEffectView* effectView;

#pragma mark - 存储/获取属性
// 使/获取 当前选中下标
@property (nonatomic, assign) NSInteger selectIndex;

// 是否触发设置的动画效果
- (void)setSelectIndex:(NSInteger)selectIndex WithAnimation:(BOOL )animation;

// TabbarItems集合
@property (nonatomic, readonly, strong) NSArray <LZB_TabBarItem *> *tabBarItems;

// 代理
@property (nonatomic, weak) id <LZB_TabBarDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
