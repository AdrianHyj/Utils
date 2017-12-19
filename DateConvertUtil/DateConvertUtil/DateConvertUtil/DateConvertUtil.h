//
//  DateConvertUtil.h
//  NaiNiuStore
//
//  Created by Jin on 15/4/4.
//  Copyright (c) 2015年 NaiNiuJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateConvertUtil : NSObject


/**
 把NSDate转成字符串的时间

 @param date NSDate
 @param formatter 时间Formatter 如果为nil 则使用默认 @"yyyy-MM-dd"
 @return 返回NSDate对应的字符串时间
 */
+ (nullable NSString *)convertToStringWithNSDate:(nonnull NSDate *)date dateFormatter:(nullable NSDateFormatter *)formatter;
/**
 把NSTimeInterval转成字符串的时间

 @param timeInterval NSTimeInterval
 @param formatter 时间Formatter 如果为nil 则使用默认 @"yyyy-MM-dd"
 @return 返回NSTimeInterval对应的字符串时间
 */
+ (nullable NSString *)convertToStringWithTimeInterval:(NSTimeInterval)timeInterval dateFormatter:(nullable NSDateFormatter *)formatter;


/**
 把字符串的时间转成NSDate

 @param timeString 字符串时间
 @param formatter 时间Formatter 如果为nil 则使用默认 @"yyyy-MM-dd"
 @return 返回字符串时间对应的NSDate
 */
+ (nonnull NSDate *)converToDateWithString:(nullable NSString *)timeString dateFormatter:(nullable NSDateFormatter *)formatter;
/**
 把字符串的时间转成NSTimeInterval

 @param timeString 字符串时间
 @param formatter 时间Formatter 如果为nil 则使用默认 @"yyyy-MM-dd"
 @return 返回字符串时间对应的NSTimeInterval
 */
+ (NSTimeInterval)converToTimeIntervalWithString:(nullable NSString *)timeString dateFormatter:(nullable NSDateFormatter *)formatter;


#pragma mark - 获得当前时间
/**
 获取本地当前时间
 
 @param formatter 时间Formatter 如果为nil 则使用默认 @"yyyy-MM-dd"
 @return 返回本地当前时间的字符串时间
 */
+ (nullable NSString *)getNowDateStringWithDateFormatter:(nullable NSDateFormatter *)formatter;
/**
 获取本地当前时间

 @return 返回本地当前时间的NSDate
 */
+ (nonnull NSDate *)getNowDate;
/**
 获取本地当前时间戳

 @return 返回本地当前时间的NSTimeInterval
 */
+ (NSTimeInterval)getNowTimeInterval;

#pragma mark - 和当前时间比较
/**
 给出的date是否比本地当前时间晚 (nowdate < date)

 @param date NSDate
 @return 是否
 */
+ (BOOL)isNowTimeBeforeDate:(nonnull NSDate *)date;
/**
 给出的timeInterval是否比本地当前时间晚 (nowtimeInterval < timeInterval)
 
 @param timeInterval timeInterval。如果timeInterval <=0 则返回NO
 @return 是否
 */
+ (BOOL)isNowTimeBeforeTimeInterval:(NSTimeInterval)timeInterval;

#pragma mark - 时间处理方法
/**
 判断是星期几

 @param date
 时间
 @return [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"
 */
+ (nullable NSString *)weekdayStringFromDate:(nonnull NSDate *)date;

/**
 判断农历

 @param date 时间
 @return 农历字符串
 */
+ (nonnull NSString *)getChineseCalendarWithDate:(nonnull NSDate *)date;
@end
