//
//  LZBCalendarMonth.m
//  LZBProject
//
//  Created by hicity on 2019/10/17.
//  Copyright © 2019 hicity. All rights reserved.
//

#import "LZBCalendarMonth.h"
#import "NSDate+LZBCalendar.h"

@implementation LZBCalendarMonth

- (instancetype)initWithDate:(NSDate *)date{
    if (self = [super init]) {
        _monthDate = date;
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        
    }
    return self;
}

- (NSInteger)setupTotalDays {
    return [_monthDate totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday {
    return [_monthDate firstWeekDayInMonth];
}

- (NSInteger)setupYear {
    return [_monthDate dateYear];
}

- (NSInteger)setupMonth {
    return [_monthDate dateMonth];
}

@end
