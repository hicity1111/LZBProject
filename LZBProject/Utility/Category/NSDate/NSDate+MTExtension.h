//
//  NSDate+MTExtension.h
//  iOSWheels
//
//  Created by liyan on 2018/10/24.
//  Copyright © 2018年 liyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MTExtension)


//内存优化 单例
+ (NSDateFormatter *)mt_formatter;


/**
 * 获取日、月、年、小时、分钟、秒
 */

- (NSUInteger)mt_day;
- (NSUInteger)mt_month;
- (NSUInteger)mt_year;
- (NSUInteger)mt_hour;
- (NSUInteger)mt_minute;
- (NSUInteger)mt_second;
+ (NSUInteger)mt_day:(NSDate *)date;
+ (NSUInteger)mt_month:(NSDate *)date;
+ (NSUInteger)mt_year:(NSDate *)date;
+ (NSUInteger)mt_hour:(NSDate *)date;
+ (NSUInteger)mt_minute:(NSDate *)date;
+ (NSUInteger)mt_second:(NSDate *)date;



/**
 * 获取当前月份的天数
 */
- (NSUInteger)mt_daysInMonth;
+ (NSUInteger)mt_daysInMonth:(NSDate *)date month:(NSUInteger)month;


/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)mt_isLeapYear;
+ (BOOL)mt_isLeapYear:(NSDate *)date;



/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)mt_timeInfoWithDate:(NSDate *)date;




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
- (NSString *)mt_dayFromWeekday;
+ (NSString *)mt_dayFromWeekday:(NSDate *)date;





/**
 @param formate  eg: yyyy-MM-dd HH:mm:ss
 @return 格式化后的字符串
 */
- (NSString *)mt_stringWithFormate:(NSString *)formate;



/**
 *  NSDate --> 时间戳字符串
 */
- (NSString *)mt_timeStamp;



/**
时间戳转字符串
 @param timeStamp 时间戳
 @param formate 序列化格式
 */
+ (NSString *)mt_timeStamp:(NSString *)timeStamp
                   formate:(NSString *)formate;



///时间戳转NSDate
+ (NSDate *)timeStampToDate:(NSString *)timeStamp;


///字符串转时间戳
+ (NSString *)mt_ymdStringFormaterToTimeStampString:(NSString *)ymdString;



#pragma mark ---- 时间间隔
///比aDate晚多少分钟
- (NSInteger)mt_minutesAfterDate:(NSDate *)aDate;
///比aDate早多少分钟
- (NSInteger)mt_minutesBeforeDate:(NSDate *)aDate;
///比aDate晚多少小时
- (NSInteger)mt_hoursAfterDate:(NSDate *)aDate;
///比aDate早多少小时
- (NSInteger)mt_hoursBeforeDate:(NSDate *)aDate;
///比aDate晚多少天
- (NSInteger)mt_daysAfterDate:(NSDate *)aDate;
///比aDate早多少天
- (NSInteger)mt_daysBeforeDate:(NSDate *)aDate;

///将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr;

///将时间转换为时间字符串
+ (NSString *)dateToTimeStr:(NSDate *)date;

///获取当前时间戳
+(NSString *)getNowTimestamp;

//将时间转换为时间戳
+ (NSString *)dateToTimestamp:(NSDate *)date;
@end
