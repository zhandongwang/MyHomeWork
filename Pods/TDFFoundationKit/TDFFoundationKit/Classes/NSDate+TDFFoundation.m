/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/*
 #import <humor.h> : Not planning to implement: dateByAskingBoyOut and dateByGettingBabysitter
 ----
 General Thanks: sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Lily Vulcano, jcromartiej, Blagovest Dachev, Matthias Plappert,  Slava Bushtruk, Ali Servet Donmez, Ricardo1980, pip8786, Danny Thuerin, Dennis Madsen
 
 Include GMT and time zone utilities?
*/

#import "NSDate+TDFFoundation.h"

// Thanks, AshFurrow
static const unsigned componentFlags = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit);

@implementation NSDate (TDFFoundation)

// Courtesy of Lukasz Margielewski
// Updated via Holger Haenisch
+ (NSCalendar *)tdf_currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *)tdf_dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] tdf_dateByAddingDays:days];
}

+ (NSDate *)tdf_dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] tdf_dateBySubtractingDays:days];
}

+ (NSDate *)tdf_dateTomorrow
{
	return [NSDate tdf_dateWithDaysFromNow:1];
}

+ (NSDate *)tdf_dateYesterday
{
	return [NSDate tdf_dateWithDaysBeforeNow:1];
}

+ (NSDate *)tdf_dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *)tdf_dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *)tdf_dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *)tdf_dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

#pragma mark - String Properties
- (NSString *)tdf_stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)tdf_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
//    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

- (NSString *) tdf_shortString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) tdf_shortTimeString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) tdf_shortDateString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) tdf_mediumString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *) tdf_mediumTimeString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle];
}

- (NSString *) tdf_mediumDateString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) tdf_longString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *) tdf_longTimeString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle];
}

- (NSString *) tdf_longDateString
{
    return [self tdf_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL)tdf_isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) && 
			(components1.day == components2.day));
}

- (BOOL)tdf_isToday
{
	return [self tdf_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)tdf_isTomorrow
{
	return [self tdf_isEqualToDateIgnoringTime:[NSDate tdf_dateTomorrow]];
}

- (BOOL)tdf_isYesterday
{
	return [self tdf_isEqualToDateIgnoringTime:[NSDate tdf_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)tdf_isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	NSDateComponents *components2 = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.week != components2.week) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)tdf_isThisWeek
{
	return [self tdf_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)tdf_isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self tdf_isSameWeekAsDate:newDate];
}

- (BOOL)tdf_isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self tdf_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)tdf_isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)tdf_isThisMonth
{
    return [self tdf_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL)tdf_isLastMonth
{
    return [self tdf_isSameMonthAsDate:[[NSDate date] tdf_dateBySubtractingMonths:1]];
}

- (BOOL)tdf_isNextMonth
{
    return [self tdf_isSameMonthAsDate:[[NSDate date] tdf_dateByAddingMonths:1]];
}

- (BOOL)tdf_isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL)tdf_isThisYear
{
    // Thanks, baspellis
	return [self tdf_isSameYearAsDate:[NSDate date]];
}

- (BOOL)tdf_isNextYear
{
	NSDateComponents *components1 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL)tdf_isLastYear
{
	NSDateComponents *components1 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSDate tdf_currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL)tdf_isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)tdf_isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL)tdf_isInFuture
{
    return ([self tdf_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)tdf_isInPast
{
    return ([self tdf_isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL)tdf_isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate tdf_currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)tdf_isTypicallyWorkday
{
    return ![self tdf_isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

// Thaks, rsjohnson
- (NSDate *)tdf_dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)tdf_dateBySubtractingYears: (NSInteger) dYears
{
    return [self tdf_dateByAddingYears:-dYears];
}

- (NSDate *)tdf_dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)tdf_dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self tdf_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *)tdf_dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)tdf_dateBySubtractingDays: (NSInteger) dDays
{
	return [self tdf_dateByAddingDays:(dDays * -1)];
}

- (NSDate *)tdf_dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *)tdf_dateBySubtractingHours: (NSInteger) dHours
{
	return [self tdf_dateByAddingHours:(dHours * -1)];
}

- (NSDate *)tdf_dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *)tdf_dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self tdf_dateByAddingMinutes:(dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark - Extremes

- (NSDate *)tdf_dateAtStartOfDay
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [[NSDate tdf_currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *)tdf_dateAtEndOfDay
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	components.hour = 23; // Thanks Aleksey Kononov
	components.minute = 59;
	components.second = 59;
	return [[NSDate tdf_currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger)tdf_minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)tdf_minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)tdf_hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)tdf_hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)tdf_daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger)tdf_daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)tdf_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) tdf_nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger) tdf_hour
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.hour;
}

- (NSInteger) tdf_minute
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.minute;
}

- (NSInteger) tdf_seconds
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.second;
}

- (NSInteger) tdf_day
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.day;
}

- (NSInteger) tdf_month
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.month;
}

- (NSInteger) tdf_week
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.week;
}

- (NSInteger) tdf_weekday
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.weekday;
}

- (NSInteger) tdf_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) tdf_year
{
	NSDateComponents *components = [[NSDate tdf_currentCalendar] components:componentFlags fromDate:self];
	return components.year;
}
@end
