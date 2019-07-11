/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (TDFFoundation)
+ (NSCalendar *)tdf_currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *)tdf_dateTomorrow;
+ (NSDate *)tdf_dateYesterday;
+ (NSDate *)tdf_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *)tdf_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *)tdf_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *)tdf_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *)tdf_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *)tdf_dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Short string utilities
- (NSString *)tdf_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *)tdf_stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *tdf_shortString;
@property (nonatomic, readonly) NSString *tdf_shortDateString;
@property (nonatomic, readonly) NSString *tdf_shortTimeString;
@property (nonatomic, readonly) NSString *tdf_mediumString;
@property (nonatomic, readonly) NSString *tdf_mediumDateString;
@property (nonatomic, readonly) NSString *tdf_mediumTimeString;
@property (nonatomic, readonly) NSString *tdf_longString;
@property (nonatomic, readonly) NSString *tdf_longDateString;
@property (nonatomic, readonly) NSString *tdf_longTimeString;

// Comparing dates
- (BOOL)tdf_isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL)tdf_isToday;
- (BOOL)tdf_isTomorrow;
- (BOOL)tdf_isYesterday;

- (BOOL)tdf_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL)tdf_isThisWeek;
- (BOOL)tdf_isNextWeek;
- (BOOL)tdf_isLastWeek;

- (BOOL)tdf_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL)tdf_isThisMonth;
- (BOOL)tdf_isNextMonth;
- (BOOL)tdf_isLastMonth;

- (BOOL)tdf_isSameYearAsDate: (NSDate *) aDate;
- (BOOL)tdf_isThisYear;
- (BOOL)tdf_isNextYear;
- (BOOL)tdf_isLastYear;

- (BOOL)tdf_isEarlierThanDate: (NSDate *) aDate;
- (BOOL)tdf_isLaterThanDate: (NSDate *) aDate;

- (BOOL)tdf_isInFuture;
- (BOOL)tdf_isInPast;

// Date roles
- (BOOL)tdf_isTypicallyWorkday;
- (BOOL)tdf_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)tdf_dateByAddingYears: (NSInteger) dYears;
- (NSDate *)tdf_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *)tdf_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *)tdf_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *)tdf_dateByAddingDays: (NSInteger) dDays;
- (NSDate *)tdf_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *)tdf_dateByAddingHours: (NSInteger) dHours;
- (NSDate *)tdf_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *)tdf_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *)tdf_dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *)tdf_dateAtStartOfDay;
- (NSDate *)tdf_dateAtEndOfDay;

// Retrieving intervals
- (NSInteger)tdf_minutesAfterDate: (NSDate *) aDate;
- (NSInteger)tdf_minutesBeforeDate: (NSDate *) aDate;
- (NSInteger)tdf_hoursAfterDate: (NSDate *) aDate;
- (NSInteger)tdf_hoursBeforeDate: (NSDate *) aDate;
- (NSInteger)tdf_daysAfterDate: (NSDate *) aDate;
- (NSInteger)tdf_daysBeforeDate: (NSDate *) aDate;
- (NSInteger)tdf_distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger tdf_nearestHour;
@property (readonly) NSInteger tdf_hour;
@property (readonly) NSInteger tdf_minute;
@property (readonly) NSInteger tdf_seconds;
@property (readonly) NSInteger tdf_day;
@property (readonly) NSInteger tdf_month;
@property (readonly) NSInteger tdf_week;
@property (readonly) NSInteger tdf_weekday;
@property (readonly) NSInteger tdf_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger tdf_year;
@end
