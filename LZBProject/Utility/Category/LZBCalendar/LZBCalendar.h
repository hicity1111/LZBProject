//
//  LZBCalendar.h
//  LZBProject
//
//  Created by hicity on 2019/10/14.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DidSelectDayHandler)(NSInteger year, NSInteger month, NSInteger day);

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

@property (nonatomic, assign) LZBCalendarDirection type;


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

/*
 * 当前月的title颜色
 */
@property(nonatomic,strong)UIColor *currentMonthTitleColor;
/*
 * 上月的title颜色
 */
@property(nonatomic,strong)UIColor *lastMonthTitleColor;
/*
 * 下月的title颜色
 */
@property(nonatomic,strong)UIColor *nextMonthTitleColor;

/*
 * 选中的背景颜色
 */
@property(nonatomic,strong)UIColor *selectBackColor;

/*
 * 今日的title颜色
 */
@property(nonatomic,strong)UIColor *todayTitleColor;

/*
 * 选中的是否动画效果
 */
@property(nonatomic,assign)BOOL     isHaveAnimation;



/*
 * 是否禁止手势滚动
 */
@property(nonatomic,assign)BOOL     isCanScroll;

/*
 * 是否显示上月，下月的按钮
 */
@property(nonatomic,assign)BOOL     isShowLastAndNextBtn;

/*
 * 是否显示上月，下月的的数据
 */
@property(nonatomic,assign)BOOL     isShowLastAndNextDate;

/*
 * 在配置好上面的属性之后执行
 */
-(void)dealData;

//选中的回调
@property(nonatomic,copy)DidSelectDayHandler selectBlock;
@end

NS_ASSUME_NONNULL_END
