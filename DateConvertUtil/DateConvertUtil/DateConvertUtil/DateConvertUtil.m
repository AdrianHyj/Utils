//
//  DateConvertUtil.m
//  NaiNiuStore
//
//  Created by Jin on 15/4/4.
//  Copyright (c) 2015年 NaiNiuJia. All rights reserved.
//

#import "DateConvertUtil.h"

@implementation DateConvertUtil

+ (NSDateFormatter *)makeFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    return dateFormatter;
}

+ (nullable NSString *)convertToStringWithNSDate:(nonnull NSDate *)date dateFormatter:(nullable NSDateFormatter *)formatter {
    if (!formatter) {
        return [[self makeFormatter] stringFromDate:date];
    }
    return [formatter stringFromDate:date];
}
+ (nullable NSString *)convertToStringWithTimeInterval:(NSTimeInterval)timeInterval dateFormatter:(nullable NSDateFormatter *)formatter {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self convertToStringWithNSDate:date dateFormatter:formatter];
}

+ (nonnull NSDate *)converToDateWithString:(nullable NSString *)timeString dateFormatter:(nullable NSDateFormatter *)formatter {
    if (!formatter) {
        return [[self makeFormatter] dateFromString:timeString];
    }
    return [formatter dateFromString:timeString];
}
+ (NSTimeInterval)converToTimeIntervalWithString:(nullable NSString *)timeString dateFormatter:(nullable NSDateFormatter *)formatter {
    return [[self converToDateWithString:timeString dateFormatter:formatter] timeIntervalSince1970];
}

#pragma mark - 获得当前时间
+ (nullable NSString *)getNowDateStringWithDateFormatter:(nullable NSDateFormatter *)formatter {
    NSDate *nowDate = [NSDate date];
    return [self convertToStringWithNSDate:nowDate dateFormatter:formatter];
}
+ (nonnull NSDate *)getNowDate {
    NSDate *nowDate = [NSDate date];
    return nowDate;
}
+ (NSTimeInterval)getNowTimeInterval {
    NSDate *nowDate = [NSDate date];
    return [nowDate timeIntervalSince1970];
}


#pragma mark - 和当前时间比较
+ (BOOL)isNowTimeBeforeDate:(nonnull NSDate *)date {
    NSDate *nowDate = [NSDate date];
    NSTimeInterval seconds = [nowDate timeIntervalSinceDate:date];
    if (seconds > 0) {
        return NO;
    }
    return YES;
}
+ (BOOL)isNowTimeBeforeTimeInterval:(NSTimeInterval)timeInterval {
    if (timeInterval > 0) {
        NSDate *dateBegin = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
        return [self isNowTimeBeforeDate:dateBegin];
    }
    return NO;
}

#pragma mark - 时间处理方法
+ (nullable NSString *)weekdayStringFromDate:(nonnull NSDate *)date {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (nonnull NSString *)getChineseCalendarWithDate:(nonnull NSDate *)date {
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%zd_%zd_%zd",localeComp.year,localeComp.month,localeComp.day);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return chineseCal_str;
}

@end
