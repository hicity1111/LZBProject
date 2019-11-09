//
//  NSDate+MTExtension.m
//  iOSWheels
//
//  Created by liyan on 2018/10/24.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import "NSDate+MTExtension.h"

#define MT_D_MINUTE    60
#define MT_D_HOUR    3600
#define MT_D_DAY     86400
#define MT_D_WEEK    604800
#define MT_D_YEAR    31556926

@implementation NSDate (MTExtension)


//内存优化 单例
+ (NSDateFormatter *)mt_formatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    
    return formatter;
}




/**
 * 获取日、月、年、小时、分钟、秒
 */

- (NSUInteger)mt_day {
    return [NSDate mt_day:self];
}


- (NSUInteger)mt_month {
    return [NSDate mt_month:self];
}


- (NSUInteger)mt_year {
    return [NSDate mt_year:self];
}


- (NSUInteger)mt_hour {
    return [NSDate mt_hour:self];
}


- (NSUInteger)mt_minute {
    return [NSDate mt_minute:self];
}



- (NSUInteger)mt_second {
    return [NSDate mt_second:self];
}


+ (NSUInteger)mt_day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}


+ (NSUInteger)mt_month:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
    
}



+ (NSUInteger)mt_year:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
    
}


+ (NSUInteger)mt_hour:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
    
}



+ (NSUInteger)mt_minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}



+ (NSUInteger)mt_second:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}





/**
 * 获取当前月份的天数
 */
- (NSUInteger)mt_daysInMonth {
    return [NSDate mt_daysInMonth:[NSDate date] month:[[NSDate date] mt_month]];
}




+ (NSUInteger)mt_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date mt_isLeapYear] ? 29 : 28;
    }
    return 30;
}


/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)mt_isLeapYear {
    return [NSDate mt_isLeapYear:self];
}

+ (BOOL)mt_isLeapYear:(NSDate *)date {
    NSUInteger year = [date mt_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}





/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)mt_timeInfoWithDate:(NSDate *)date {
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = -[date timeIntervalSinceDate:currentDate];
    
    int year = (int)([currentDate mt_year] - [date mt_year]);
    int month = (int)([currentDate mt_month] - [date mt_month]);
    int day = (int)([currentDate mt_day] - [date mt_day]);
    
    NSTimeInterval retTime = 1.0;
    //小于一小时判定
    if (timeInterval < 3600) {
        retTime = timeInterval / 60;
        retTime = timeInterval <= 0.0 ? 1.0 : retTime;
        return retTime < 1.0 ? @"刚刚" : [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    //小于一天 大于等于一小时 也就是今天
    else if (timeInterval < 3600 * 24) {
        retTime = timeInterval / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    //昨天
    else if (timeInterval < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1) ||
             (abs(year) == 1 && [currentDate mt_month] == 1 && [date mt_month] == 12)) {
        
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[NSDate mt_daysInMonth:date month:[date mt_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[currentDate mt_day] + (totalDays - (int)[date mt_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    }
    
    else {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[currentDate mt_month];
            int preMonth = (int)[date mt_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    
    return @"1小时前";
}




/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */

+ (NSInteger)mt_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)mt_dayFromWeekday {
    return [NSDate mt_dayFromWeekday:self];
}

+ (NSString *)mt_dayFromWeekday:(NSDate *)date {
    NSInteger weekday = [NSDate mt_weekday:date];
    switch(weekday) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"未定义";
}




///给定format格式化时间
- (NSString *)mt_stringWithFormate:(NSString *)formate {
    
    NSDateFormatter *dateFormatter = [NSDate mt_formatter];
    dateFormatter.dateFormat = formate;
    return [dateFormatter stringFromDate:self];
    
}



/**
 *  NSDate --> 时间戳字符串
 */
- (NSString *)mt_timeStamp {
    
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    return [timeString copy];
    
}


/**
 时间戳转字符串
 @param timeStamp 时间戳
 @param formate 序列化格式
 */
+ (NSString *)mt_timeStamp:(NSString *)timeStamp formate:(NSString *)formate {
    NSDate *confromTimesp = [NSDate timeStampToDate:timeStamp];
    NSDateFormatter *dateFormatter = [NSDate mt_formatter];
    dateFormatter.dateFormat = formate;
    NSString *string = [dateFormatter stringFromDate:confromTimesp];
    return string;
}


///时间戳转NSDate
+ (NSDate *)timeStampToDate:(NSString *)timeStamp {
    ///java后台返回的时间戳是毫秒级 需要手动除以1000
    long long num = (long long)([IFISNIL(timeStamp) longLongValue] / 1000);
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    return confromTimesp;
}


///字符串转时间戳
+ (NSString *)mt_ymdStringFormaterToTimeStampString:(NSString *)ymdString {
    NSDateFormatter *dateFormatter = [NSDate mt_formatter];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *tempDate = [dateFormatter dateFromString:ymdString];
    
    NSTimeInterval timeStamp = [tempDate timeIntervalSince1970];
    ///精确到毫秒级
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeStamp * 1000];

    return timeString;
}


///比aDate晚多少分钟
- (NSInteger)mt_minutesAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / MT_D_MINUTE);
}
///比aDate早多少分钟
- (NSInteger)mt_minutesBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / MT_D_MINUTE);
}

///比aDate晚多少小时
- (NSInteger)mt_hoursAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / MT_D_HOUR);
}
///比aDate早多少小时
- (NSInteger)mt_hoursBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / MT_D_HOUR);
}


///比aDate晚多少天
- (NSInteger)mt_daysAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / MT_D_DAY);
}
///比aDate早多少天
- (NSInteger)mt_daysBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / MT_D_DAY);
}

//将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr {
    
    NSDate *date = [self timeStrToDate:timeStr];
    NSTimeInterval stamp = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

//将时间字符串转换为时间
+ (NSDate *)timeStrToDate:(NSString *)timeStr {
    
    NSDate *date = [[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] dateFromString:timeStr];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    return localeDate;
}

//获取日期格式化器
+(NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}

//将时间转换为时间字符串
+ (NSString *)dateToTimeStr:(NSDate *)date {
    
    NSString *timeStr = [[self dateFormatWith:@"YYYY-MM-dd HH:mm:ss"] stringFromDate:date];
    
    return timeStr;
}

//获取当前时间戳
+(NSString *)getNowTimestamp {
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    return [self dateToTimestamp:date];
}
//将时间转换为时间戳
+ (NSString *)dateToTimestamp:(NSDate *)date {
    
    NSTimeInterval stamp = [date timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

@end
