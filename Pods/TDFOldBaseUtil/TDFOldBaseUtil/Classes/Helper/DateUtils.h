//
//  DateUtils.h
//  CardApp
//
//  Created by 邵建青 on 13-11-18.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TDFFormatTimeType) {
    /// yyyy年MM月dd日
    TDFFormatTimeTypeChinese,
    /// yyyy年MM月dd日 EEEE
    TDFFormatTimeTypeChineseWithWeek,
    /// yyyy年MM月
    TDFFormatTimeTypeChineseWithoutDay,
    /// MM月dd日
    TDFFormatTimeTypeChineseWithoutYear,
    /// MM月dd日 HH:mm
    TDFFormatTimeTypeChineseFullTimeWithoutYear,
    /// yyyy年MM月dd日 HH:mm
    TDFFormatTimeTypeChineseWithTime,
    /// HH:mm
    TDFFormatTimeTypeHourAndMinute,
    /// yyyy-MM-dd HH:mm:ss
    TDFFormatTimeTypeFullTimeSecond,
    /// yyyy-MM-dd HH:mm
    TDFFormatTimeTypeFullTime,
    /// yyyy-MM-dd
    TDFFormatTimeTypeYearMonthDay,
    /// yyyy.MM.dd
    TDFFormatTimeTypeDateSeparateWithDot,
    //yyyyMMdd
    TDFFormatTimeTypeYearMonthDayNoLine,
    /// yyyy-MM
    TDFFormatTimeTypeYearWithMonth,
    //MM-dd
    TDFFormatTimeTypeMonthWithDay,
    // dd-MM-yyyy HH:mm:ss
    TDFForeignFormatTimeTypeFullTimeSecond,
    // dd-MM-yyyy HH:mm
    TDFForeignFormatTimeTypeFullTime,
    /// dd-MM-yyyy
    TDFForeignFormatTimeTypeYearMonthDay,
    //MM-yyyy
    TDFForeignFormatTimeTypeYearWithMonth,
    //YYYY年M月
    TDFFormatTimeTypeYearMonth,
    //YYYY.MM.dd hh:ss
    TDFFormatTimeTypeYearMonthDayHourMinute,
};

typedef NS_ENUM(NSUInteger, TDFFormatStringType) {
    /// yyyy-MM-dd HH:mm
    TDFFormatTimeTypeFullTimeString,
    //yyyy-MM HH:mm
    TDFFormatTimeTypeFullTimeWithoutDayString,
    //MMM dd, yyyy HH:mm:ss
    TDFFormatTimeTypeEnglishFullTimeString,
    //yyyy-MM-dd HH:mm:ss（有秒）
    TDFFormatTimeTypeAllTimeString,
    /// yyyy-MM-dd
    TDFFormatTimeTypeYearMonthDayString,
    /// yyyy年MM月dd日
    TDFFormatTimeTypeChineseString,
    /// HH:mm
    TDFFormatTimeTypeHourAndMinuteString,
    /// yyyyMMdd
    TDFFormatTimeTypeYearMonthDayNoLineString,
    //dd-MM-yyyy
    TDFForeignFormatTimeTypeYearMonthDayString
    
};

typedef NS_ENUM(NSUInteger, TDFDateType) {
    /// 昨天
    TDFDateTypeYesterday,
    /// 今天
    TDFDateTypeToday,
    /// 本周
    TDFDateTypeThisWeek,
    /// 本月
    TDFDateTypeThisMonth,
    /// 上月
    TDFDateTypeLastMonth,
};

@interface DateUtils : NSObject
{
    NSDateFormatter *dateFormatter;
}

+ (NSString *)formatTimeWithDate:(NSDate *)date type:(TDFFormatTimeType)type;

+ (NSString *)formatTimeWithTimestamp:(NSTimeInterval)timestamp type:(TDFFormatTimeType)type;

+ (NSString *)formatTimeWithSecond:(NSInteger)second;

+ (NSDate *)DateWithString:(NSString *)dateTimeString type:(TDFFormatStringType)type ;

+ (NSInteger)getMinuteOfDate:(NSDate *)date;

+ (NSInteger)getMinuteOfString:(NSString *)timeStr;

+ (NSDate *)parseDateStart:(NSDate *)datetime;

+ (NSDate *)parseDateEnd:(NSDate *)datetime;

+ (NSDate *)parseTodayTime:(NSInteger)time;

+ (NSDate *)getTodayLastTime;

+ (NSDate *)getTimeSinceNow:(NSTimeInterval)interval;

+ (NSString *)getWeeKName:(NSInteger)week;
+(NSString *)getWeek1:(NSString *)date;

//供应链
//获取本月的第一天
+ (NSDate *)getFirstDayOfThisMonth;

+ (long long)convertDateStringToTimestamp:(NSString*)datetime;

+(NSString *)formateDateFromIntDate:(int)date;

+ (NSString *)formateDateFromLongDateWithTime:(long)date;

+ (int)formateIntDateFromDate:(NSString *)stringDate;

+ (NSString *)formateDateFromLongDate:(long long)date type:(TDFFormatTimeType)type;

//获取一个月有多少天
+ (NSInteger)getDaysOfMonth:(NSDate*)date_;

+(NSInteger)getDaysFrom:(NSDate *)startDate To:(NSDate *)endDate;

+ (NSArray *)getBeginDateAndEndDateWithType:(TDFDateType)dateType;


//供应链添加转换日期格式
+ (long long)formateDateTime2:(NSString*)datetime;

+ (NSString *)getWeek:(NSString *)date;

//新增全数字时间格式
+ (NSString *)formateAllNumberDate:(NSDate *)date;
//新增字符串转换为日期时间格式
+ (NSString *)getTimeStrWithDateStr:(NSString *)datetime;

@end
