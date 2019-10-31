//
//  UIView+Empty.h
//  LZBProject
//
//  Created by hicity on 2019/10/31.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LZBEmptyView;


@interface UIView (Empty)

/**
 空页面占位图控件
 */
@property (nonatomic, strong) LZBEmptyView *lzbemptyView;


//使用下面的四个方法请将EmptyView的autoShowEmptyView值置为NO，关闭自动显隐，以保证不受自动显隐的影响


/**
 一般用于开始请求网络时调用，lzbstartLoading调用时会暂时隐藏emptyView
 当调用lzbendLoading方法时，lzbendLoading方法内部会根据当前的tableView/collectionView的
 DataSource来自动判断是否显示emptyView
 */
- (void)lzbstartLoading;

/**
 在想要刷新emptyView状态时调用
 注意:lzbendLoading 的调用时机，有刷新UI的地方一定要等到刷新UI的方法之后调用，
 因为只有刷新了UI，view的DataSource才会更新，故调用此方法才能正确判断是否有内容。
 */
- (void)lzbendLoading;


//调用下面两个手动显隐的方法，不受DataSource的影响，单独设置显示与隐藏（前提是关闭autoShowEmptyView）

/**
 手动调用显示emptyView
 */
- (void)lzbshowEmptyView;

/**
 手动调用隐藏emptyView
 */
- (void)lzbhideEmptyView;

@end

NS_ASSUME_NONNULL_END
