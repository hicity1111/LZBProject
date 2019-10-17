//
//  LZBCalendarMonth.h
//  LZBProject
//
//  Created by hicity on 2019/10/17.
//  Copyright © 2019 hicity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBCalendarMonth : NSObject

/// !<传入的NSDate 对象 该NSDate 对象代表当前月的某一天，根据它来获得其他数据
@property (nonatomic, strong) NSDate *monthDate;

/// !< 当前月的天数
@property (nonatomic, assign) NSInteger totalDays;

/// !< 标示第一天是星期几（0代表周日，1代表周一，以此类推）
@property (nonatomic, assign) NSInteger firstWeekday;

/// !< 所属年份
@property (nonatomic, assign) NSInteger year;

/// !< 当前月份
@property (nonatomic, assign) NSInteger month;

- (instancetype)initWithDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
