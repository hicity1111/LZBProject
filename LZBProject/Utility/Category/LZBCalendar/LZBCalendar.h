//
//  LZBCalendar.h
//  LZBProject
//
//  Created by hicity on 2019/10/14.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

typedef NS_ENUM(NSInteger, LZBCalendarDirection){
    
    LZBCalendarDirectionTop = 1,
    LZBCalendarDirectionRight,
    LZBCalendarDirectionBottom,
    LZBCalendarDirectionLeft
};


@class LZBCalendar;

@protocol LZBCalendarDelegate <NSObject>

- (void)calender:(LZBCalendar *)calendar didClickSureButtonWithDate:(NSString *)date;

@end

@interface LZBCalendar : UIView

//+ (_Nonnull instancetype)shareInstance;

@property (nonatomic, weak) id<LZBCalendarDelegate> delegate;

@property (nonatomic, assign) BOOL showTimePicker;

@property (nonatomic, assign) LZBCalendarDirection type;

//- (id)initWithFrame:(CGRect)frame andTopPoint:(CGPoint)point;

- (void)show;

- (void)dismiss;

/// 构造方法
/// @param origin calendar 的位置
/// @param width calendar的宽度（高度根据宽度自动计算）
- (instancetype)initWithFrameOrigin:(CGPoint)origin width:(CGFloat)width;

/**
*  calendar 的高度（只读属性）
*/
@property (nonatomic, assign, readonly) CGFloat calendarHeight;

/**
 *  calendar 基本颜色
 */
@property (nonatomic, strong) UIColor *calendarBasicColor;


/**
 *  日期点击回调
 *  block 的参数表示当前日期的 NSDate 对象
 */
@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler;
@end

NS_ASSUME_NONNULL_END
