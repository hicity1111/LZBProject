//
//  LZBCalendar.h
//  LZBProject
//
//  Created by hicity on 2019/10/14.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LZBCalendar;

@protocol LZBCalendarDelegate <NSObject>

- (void)calender:(LZBCalendar *)calendar didClickSureButtonWithDate:(NSString *)date;

@end

@interface LZBCalendar : UIView

+ (_Nonnull instancetype)shareInstance;

@property (nonatomic, weak) id<LZBCalendarDelegate> delegate;

@property (nonatomic, assign) BOOL showTimePicker;

- (id)initWithFrame:(CGRect)frame andTopPoint:(CGPoint)point;

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
