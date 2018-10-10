//
//  DateUtils.m
//  CardApp
//
//  Created by 邵建青 on 13-11-18.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import "DateUtils.h"
#import "ObjectUtil.h"
#import "NSString+Estimate.h"

static DateUtils *dateUtils;

@implementation DateUtils

- (id)init
{
    self = [super init];
    if (self) {
        dateFormatter = [[NSDateFormatter alloc]init];
    }
    return self;
}

+ (NSString *)formatTimeWithDate:(NSDate *)date type:(TDFFormatTimeType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    NSString *formatterString = nil;
    
    switch (type) {
        case TDFFormatTimeTypeChinese:
            formatterString = NSLocalizedString(@"yyyy年MM月dd日", nil);
            break;
            
        case TDFFormatTimeTypeChineseWithWeek:
            formatterString = NSLocalizedString(@"yyyy年MM月dd日 EEEE", nil);
            break;
            
        case TDFFormatTimeTypeChineseWithoutDay:
            formatterString = NSLocalizedString(@"yyyy年MM月", nil);
            break;
            
        case TDFFormatTimeTypeHourAndMinute:
            formatterString = @"HH:mm";
            break;
            
        case TDFFormatTimeTypeFullTime:
            formatterString = @"yyyy-MM-dd HH:mm";
            break;
            
        case TDFFormatTimeTypeFullTimeSecond:
            formatterString = @"yyyy-MM-dd HH:mm:ss";
            break;
            
        case TDFFormatTimeTypeYearMonthDay:
            formatterString = @"yyyy-MM-dd";
            break;
            
        case TDFFormatTimeTypeChineseWithTime:
            formatterString = NSLocalizedString(@"yyyy年MM月dd日 HH:mm", nil);
            break;
            
        case TDFFormatTimeTypeDateSeparateWithDot:
            formatterString = @"yyyy.MM.dd";
            break;
            
        case TDFFormatTimeTypeChineseWithoutYear:
            formatterString = NSLocalizedString(@"MM月dd日", nil);
            break;
            
        case TDFFormatTimeTypeChineseFullTimeWithoutYear:
            formatterString = NSLocalizedString(@"MM月dd日 HH:mm", nil);
            break;
            
        case TDFFormatTimeTypeYearMonthDayNoLine:
            formatterString = @"yyyyMMdd";
            break;
            
        case TDFFormatTimeTypeYearWithMonth:
            formatterString = @"yyyy-MM";
            break;
        case TDFFormatTimeTypeMonthWithDay:
            formatterString = @"MM-dd ";
            break;
        case TDFForeignFormatTimeTypeFullTimeSecond:
            formatterString = @"dd-MM-yyyy HH:mm:ss";
            break;
            
        case TDFForeignFormatTimeTypeFullTime:
            formatterString = @"dd-MM-yyyy HH:mm";
            break;
            
        case TDFForeignFormatTimeTypeYearMonthDay:
            formatterString = @"dd-MM-yyyy";
            break;
        case TDFForeignFormatTimeTypeYearWithMonth:
            formatterString = @"MM-yyyy";
            break;
            
        case TDFFormatTimeTypeYearMonth:
            formatterString = @"yyyy年MM月";
            break;
        case TDFFormatTimeTypeYearMonthDayHourMinute:
            formatterString = @"yyyy.MM.dd HH:mm";
            break;
        default:
            break;
    }
    
    [dateFormatter setDateFormat:formatterString];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatTimeWithTimestamp:(NSTimeInterval)timestamp type:(TDFFormatTimeType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    
    return [self formatTimeWithDate:date type:type];
}

+ (NSString *)formatTimeWithSecond:(NSInteger)second {
    return [NSString stringWithFormat:@"%.2li:%.2li", (long)second/60, (long)second%60];
}

+ (NSDate *)DateWithString:(NSString *)dateTimeString type:(TDFFormatStringType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSString *formatterString = nil;
    switch (type) {
            
        case TDFFormatTimeTypeFullTimeString:
            formatterString = @"yyyy-MM-dd HH:mm";
            break;
            
        case TDFFormatTimeTypeFullTimeWithoutDayString:
            formatterString = @"yyyy-MM HH:mm";
            break;
            
        case TDFFormatTimeTypeEnglishFullTimeString:
            formatterString = @"MMM dd, yyyy HH:mm:ss";
            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            break;
            
        case TDFFormatTimeTypeAllTimeString:
            formatterString = @"yyyy-MM-dd HH:mm:ss";
            dateTimeString=[dateTimeString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            break;
            
        case TDFFormatTimeTypeYearMonthDayString:
            formatterString = @"yyyy-MM-dd";
            break;
            
        case TDFFormatTimeTypeChineseString:
            formatterString = NSLocalizedString(@"yyyy年MM月dd日", nil);
            break;
            
        case TDFFormatTimeTypeHourAndMinuteString:
            formatterString = @"HH:mm";
            break;
       case TDFFormatTimeTypeYearMonthDayNoLineString:
            formatterString = @"yyyyMMdd";
            break;
        case TDFForeignFormatTimeTypeYearMonthDayString:
            formatterString = @"dd-MM-yyyy";
            break;
        default:
            break;
    }
    [dateFormatter setDateFormat:formatterString];
    return [dateFormatter dateFromString:dateTimeString];
}

//新增全数字时间格式
+ (NSString *)formateAllNumberDate:(NSDate *)date
{
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyyMMdd"];
    if ([ObjectUtil isNotNull:date]) {
        return [dateUtils->dateFormatter stringFromDate:date];
    }
    return nil;
}

+ (NSInteger)getMinuteOfDate:(NSDate *)date
{
    if ([ObjectUtil isNotNull:date]) {
        NSString *timeStr = [DateUtils formatTimeWithDate:date type:TDFFormatTimeTypeHourAndMinute];
        return [self getMinuteOfString:timeStr];
    }
    return 0;
}

+ (NSInteger)getMinuteOfString:(NSString *)timeStr {
    
    NSArray *times = [timeStr componentsSeparatedByString:@":"];
    NSString *time1 = times[0];
    NSString *time2 = times[1];
    return time1.integerValue*60 + time2.integerValue;
}

+ (NSDate *)parseDateStart:(NSDate *)datetime
{
    NSString *dateString = [DateUtils formatTimeWithDate:datetime type:TDFFormatTimeTypeYearMonthDay];
    dateString = [dateString stringByAppendingString:@" 00:00:00"];
     return [DateUtils DateWithString:dateString type:TDFFormatTimeTypeAllTimeString];
}

+ (NSDate *)parseDateEnd:(NSDate *)datetime
{
    NSString *dateString = [DateUtils formatTimeWithDate:datetime type:TDFFormatTimeTypeYearMonthDay];
    dateString = [dateString stringByAppendingString:@" 23:59:59"];
    return [DateUtils DateWithString:dateString type:TDFFormatTimeTypeAllTimeString];
}

+ (NSDate *)getTodayLastTime
{
    NSString *dateTime = [[DateUtils formatTimeWithDate:[NSDate date] type:TDFFormatTimeTypeYearMonthDay] stringByAppendingString:@"23:59"];
    return [DateUtils DateWithString:dateTime type:TDFFormatTimeTypeFullTimeString];
}

//字符串转换为日期时间格式
+ (NSString *)getTimeStrWithDateStr:(NSString *)datetime
{
  
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:datetime];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init] ;
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+(NSString *)getWeek:(NSString *)date
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:date];
    
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
#pragma GCC diagnostic pop
    
    comps = [calendar  components:unitFlags fromDate:inputDate];
    NSInteger week = [comps weekday];
    NSString *strWeek = [DateUtils getWeeKName1:week];
    return strWeek;
}

+(NSString *)getWeek1:(NSString *)date
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:date];
    
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
#pragma GCC diagnostic pop
    
    comps = [calendar  components:unitFlags fromDate:inputDate];
    NSInteger week = [comps weekday];
    NSString *strWeek = [DateUtils getWeeKName:week];
    return strWeek;
}

+ (NSDate *)parseTodayTime:(NSInteger)time
{
    [DateUtils build];
    NSString *timeStr = [DateUtils formatTimeWithSecond:time];
    NSString *dateStr = [DateUtils formatTimeWithDate:[NSDate date] type:TDFFormatTimeTypeYearMonthDay];
    return [DateUtils DateWithString:[dateStr stringByAppendingFormat:@" %@", timeStr] type:TDFFormatTimeTypeFullTimeString];
}

+ (NSDate *)getTimeSinceNow:(NSTimeInterval)interval
{
    return [NSDate dateWithTimeIntervalSinceNow:interval];
}

+ (NSString*) getWeeKName:(NSInteger)week
{
    if (week==1) {
        return NSLocalizedString(@"星期日", nil);
    } else if (week==2){
        return NSLocalizedString(@"星期一", nil);
    } else if (week==3){
        return NSLocalizedString(@"星期二", nil);
    } else if (week==4){
        return NSLocalizedString(@"星期三", nil);
    } else if (week==5){
        return NSLocalizedString(@"星期四", nil);
    } else if (week==6){
        return NSLocalizedString(@"星期五", nil);
    } else {
        return NSLocalizedString(@"星期六", nil);
    }
}
+ (NSString*) getWeeKName1:(NSInteger)week
{
    if (week==1) {
        return NSLocalizedString(@"周日", nil);
    } else if (week==2){
        return NSLocalizedString(@"周一", nil);
    } else if (week==3){
        return NSLocalizedString(@"周二", nil);
    } else if (week==4){
        return NSLocalizedString(@"周三", nil);
    } else if (week==5){
        return NSLocalizedString(@"周四", nil);
    } else if (week==6){
        return NSLocalizedString(@"周五", nil);
    } else {
        return NSLocalizedString(@"周六", nil);
    }
}

//获取本月的第一天
+ (NSDate *)getFirstDayOfThisMonth {
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:[NSDate date]];
    [dateComponents setDay:1];
    NSDate *date = [calender dateFromComponents:dateComponents];
    return date;
}

+ (long long)convertDateStringToTimestamp:(NSString*)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formatter dateFromString:datetime];
    return  (long long)[date timeIntervalSince1970]*1000;
}

+ (NSString *)formateDateFromIntDate:(int)date
{
    NSString *strDate = [NSString stringWithFormat:@"%d", date];
    
    if(strDate.length<8) return @"";
    
    NSArray *dateArray = @[[strDate substringWithRange:NSMakeRange(0, 4)], [strDate substringWithRange:NSMakeRange(4, 2)], [strDate substringWithRange:NSMakeRange(6, 2)]];
    
    return [dateArray componentsJoinedByString:@"-"];
}

+ (NSString *)formateDateFromLongDateWithTime:(long)date
{
    NSString *strDate = [NSString stringWithFormat:@"%ld", date];
    NSArray *dateArray = @[
                           [strDate substringWithRange:NSMakeRange(0, 4)],
                           [strDate substringWithRange:NSMakeRange(4, 2)],
                           [strDate substringWithRange:NSMakeRange(6, 2)]
                           ];
    
    NSString *dateStr = [dateArray componentsJoinedByString:@"-"];
    
    dateArray = @[
                  [strDate substringWithRange:NSMakeRange(8, 2)],
                  [strDate substringWithRange:NSMakeRange(10, 2)],
                  [strDate substringWithRange:NSMakeRange(12, 2)]
                  ];
    
    NSString *timeStr = [dateArray componentsJoinedByString:@":"];
    
    return [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
}

+ (int)formateIntDateFromDate:(NSString *)stringDate {
    
    NSArray *strArray = [stringDate componentsSeparatedByString:@"-"];
    stringDate = [strArray componentsJoinedByString:@""];
    return [stringDate intValue];
}

+ (NSString *)formateDateFromLongDate:(long long)date type:(TDFFormatTimeType)type {
    
    NSString *inputStr = [NSString stringWithFormat:@"%lld",date];
    [DateUtils build];
    [dateUtils->dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSDate* inputDate = [dateUtils->dateFormatter dateFromString:inputStr];
    return [self formatTimeWithDate:inputDate type:type];
}

//获取一个月有多少天
+ (NSInteger)getDaysOfMonth:(NSDate*)date_
{
    NSCalendar* calender=[NSCalendar currentCalendar];
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSRange range=[calender rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date_];
#pragma GCC diagnostic pop
    return range.length;
}

+(NSInteger)getDaysFrom:(NSDate *)startDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:startDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    
    return dayComponents.day;
}

+ (NSArray *)getBeginDateAndEndDateWithType:(TDFDateType)dateType {
    
    NSDate *date = [NSDate date];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    switch (dateType) {
        case TDFDateTypeYesterday:
            beginDate = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
            endDate = beginDate;
            break;
        case TDFDateTypeToday:
            beginDate = date;
            endDate = date;
            break;
        case TDFDateTypeThisWeek:
            [calendar setFirstWeekday:2];//设定周一为周首日
            [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:date];
            endDate = [NSDate date];
            break;
        case TDFDateTypeThisMonth:
            [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:date];
            endDate = [NSDate date];
            break;
        case TDFDateTypeLastMonth:
            [components setMonth:([components month]-1)];
            date = [calendar dateFromComponents:components];
            [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:date];
            endDate = [beginDate dateByAddingTimeInterval:interval-1];
            break;
            
        default:
            break;
    }
    #pragma GCC diagnostic pop
    NSString *startDateStr = [self formatTimeWithDate:beginDate type:TDFFormatTimeTypeYearMonthDayNoLine];
    NSString *endDateStr = [self formatTimeWithDate:endDate type:TDFFormatTimeTypeYearMonthDayNoLine];
    return @[startDateStr,endDateStr];
}

//供应链新增日期时间转时间戳
+ (long long)formateDateTime2:(NSString*)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:datetime];
    return  (long long)[date timeIntervalSince1970]*1000;
}



+ (void)build
{
    if (dateUtils == nil) {
        dateUtils = [[DateUtils alloc]init];
    }
}

@end
