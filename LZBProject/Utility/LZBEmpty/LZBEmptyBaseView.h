//
//  LZBEmptyBaseView.h
//  LZBProject
//
//  Created by hicity on 2019/10/31.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LZBActionTapBlock) (void);

@interface LZBEmptyBaseView : UIView

/// 站位图片
@property (nonatomic, strong) UIImage *image;
/// 站位图片名称
@property (nonatomic, copy) NSString  *imageStr;
/// 站位标题
@property (nonatomic, copy) NSString  *titleStr;
/// 详细信息描述
@property (nonatomic, copy) NSString  *detailStr;
/// 按钮标题
@property (nonatomic, copy) NSString  *btnTitleStr;

/*只读*/
@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, weak  , readonly) id  actionBtnTarget;

@property (nonatomic, assign, readonly) SEL actionBtnAction;

@property (nonatomic, copy, readonly)   LZBActionTapBlock btnClickBlock;

@property (nonatomic, strong, readonly) UIView *customView;


/*enptyView 点击事件*/
@property (nonatomic, copy) LZBActionTapBlock tapEmptyViewBlock;

/// 初始化设置
- (void)prepare;

/// 重置subViews
- (void)setupSubviews;

/// 创建emptyView 返回一个emptyView
/// @param image 站位图片
/// @param titleStr 标题
/// @param detailStr 详细描述
/// @param btnTitleStr 按钮名称
/// @param target 响应对象
/// @param action 按钮点击事件
+ (instancetype)emptyActionViewWithImage:(UIImage *)image titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action;

/// 创建emptyView 返回一个emptyView
/// @param image 站位图片
/// @param titleStr 标题
/// @param detailStr 详细描述
/// @param btnTitleStr 按钮名称
/// @param btnClickBlock 按钮点击事件回调
+ (instancetype)emptyActionViewWithImage:(UIImage *)image titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr btnClickBlock:(LZBActionTapBlock)btnClickBlock;

/// 创建emptyView 返回一个emptyView
/// @param imageStr 站位图片名称
/// @param titleStr 标题
/// @param detailStr 详细描述
/// @param btnTitleStr 按钮名称
/// @param target 响应对象
/// @param action 按钮点击事件
+ (instancetype)emptyActionViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr target:(id)target action:(SEL)action;

/// 创建emptyView 返回一个emptyView
/// @param imageStr 站位图片名称
/// @param titleStr 站位描述
/// @param detailStr 详细描述
/// @param btnTitleStr 按钮名称
/// @param btnClickBlock 按钮点击事件
+ (instancetype)emptyActionViewWithImageStr:(NSString *)imageStr titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr btnTitleStr:(NSString *)btnTitleStr btnClickBlock:(LZBActionTapBlock)btnClickBlock;


/// 创建emptyView 返回一个emptyView
/// @param image 站位图片
/// @param titleStr 站位描述
/// @param detailStr 详细信息
+ (instancetype)emptyViewWithImage:(UIImage *)image titleStr:(NSString *)titleStr detailStr:(NSString *)detailStr;

/// 创建emptyView 返回一个emptyView
/// @param customView 返回一个自定义内容的emptyView
+ (instancetype)emptyViewWithCustomView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
