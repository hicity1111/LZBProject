//
//  LZBCalenderScrollView.h
//  LZBProject
//
//  Created by hicity on 2019/10/17.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

@interface LZBCalenderScrollView : UIScrollView

@property (nonatomic, strong) UIColor *calendarBasicColor; // 基本颜色
@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调

- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份

@end

NS_ASSUME_NONNULL_END
