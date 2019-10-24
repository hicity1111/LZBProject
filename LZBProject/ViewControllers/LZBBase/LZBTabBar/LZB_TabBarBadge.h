//
//  LZB_TabBarBadge.h
//  LZBProject
//
//  Created by hicity on 2019/10/24.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZB_TabBarBadge : UILabel

/// 文字或者数字
@property (nonatomic, strong) NSString *badgeText;

/// 为0 是否自动影藏
@property (nonatomic, assign) BOOL automaticHidden;

/// 气泡高度 默认15
@property (nonatomic, assign) CGFloat badgeHeight;

/// 气泡宽度 默认0 设置宽度后自己决定要多宽
@property (nonatomic, assign) CGFloat badgeWidth;
@end

NS_ASSUME_NONNULL_END
