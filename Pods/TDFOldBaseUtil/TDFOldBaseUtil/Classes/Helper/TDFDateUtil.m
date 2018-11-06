//
//  TDFDateUtil.m
//  Pods
//
//  Created by happyo on 2017/4/12.
//
//

#import "TDFDateUtil.h"
#import "NSBundle+Language.h"
@implementation TDFDateUtil

+ (NSString *)weekNameWithDayString:(NSString *)dayString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:dayString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSString *weekDay = [NSString stringWithFormat:@"%i", (int)components.weekday];
    NSString *language = [NSBundle getCurrentLanguageFromLocation];
    NSDictionary *weekDict = [[NSDictionary alloc] init];
    if ([language isEqualToString:@"en"]) {
        weekDict = @{@"2": @"Monday", @"3": @"Tuesday", @"4": @"Wednesday", @"5": @"Thursday", @"6": @"Friday", @"7": @"Saturday", @"1": @"Sunday"};
    } else {
        weekDict = @{@"2": NSLocalizedString(@"一", nil), @"3": NSLocalizedString(@"二", nil), @"4": NSLocalizedString(@"三", nil), @"5": NSLocalizedString(@"四", nil), @"6": NSLocalizedString(@"五", nil), @"7": NSLocalizedString(@"六", nil), @"1": NSLocalizedString(@"日", nil)};
        
    }

    return weekDict[weekDay];
}

+ (NSString *)chineseDateStringWithDayString:(NSString *)dayString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:dayString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    return [NSString stringWithFormat:@"%i年%02i月%02i日", (int)components.year, (int)components.month, (int)components.day];
}

+ (NSString *)chineseDateStringWithMonthString:(NSString *)monthString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyyMM";
    NSDate *date = [dateFormatter dateFromString:monthString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    
    return [NSString stringWithFormat:@"%i年%02i月", (int)components.year, (int)components.month];
}

+ (NSString *)fullWeekNameWithDayString:(NSString *)dayString
{
    return [NSString stringWithFormat:NSLocalizedString(@"星期%@",nil), [TDFDateUtil weekNameWithDayString:dayString]];
}

+ (NSString *)monthNameWithMonthString:(NSString *)monthString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMM";
    NSDate *date = [dateFormatter dateFromString:monthString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:date];
    
    NSString *monthNum = [NSString stringWithFormat:@"%i", (int)components.month];
    
    NSDictionary *monthDict = @{@"1" : NSLocalizedString(@"一", nil), @"2" : NSLocalizedString(@"二", nil), @"3" : NSLocalizedString(@"三", nil), @"4" : NSLocalizedString(@"四", nil), @"5" : NSLocalizedString(@"五", nil), @"6" : NSLocalizedString(@"六", nil), @"7" : NSLocalizedString(@"七", nil), @"8" : NSLocalizedString(@"八", nil), @"9" : NSLocalizedString(@"九", nil), @"10" : NSLocalizedString(@"十", nil), @"11" : NSLocalizedString(@"十一", nil), @"12" : NSLocalizedString(@"十二", nil)};
    
    return monthDict[monthNum];
}

+ (NSDateComponents *)dateComponentsWithDayString:(NSString *)dayString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:dayString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];

    return components;
}

+ (NSDateComponents *)dateComponentsWithMonthString:(NSString *)monthString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyyMM";
    NSDate *date = [dateFormatter dateFromString:monthString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    
    return components;
}

+ (NSString *)foreignDateStringWithDayString:(NSString *)dayString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [dateFormatter dateFromString:dayString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    return [NSString stringWithFormat:@"%02i-%02i-%i", (int)components.day, (int)components.month, (int)components.year];
}

+ (NSString *)foreignDateStringWithMonthString:(NSString *)monthString
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyyMM";
    NSDate *date = [dateFormatter dateFromString:monthString];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    
    return [NSString stringWithFormat:@"%02i-%i", (int)components.month, (int)components.year];
}
@end
