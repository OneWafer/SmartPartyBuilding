//
//  OWMtDatePickerView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/5.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWDateBlock)(NSDate *dateString);

@interface OWMtDatePickerView : UIView

@property (nonatomic,strong)UIPickerView *datePicker;

/**
 时间选择按钮
 */
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *okButton;

/**
 NSDate回调
 */
@property (nonatomic,copy)OWDateBlock blcok;
/**
 时间的标题
 */
@property(nonatomic,strong)UILabel *chooseTimeLabel;

/**
 控件出现
 */
- (void)fadeIn;
/**
 控件显示
 */
- (void)fadeOut;

@end


@interface NSDate (Extension)

+ (NSCalendar *) currentCalendar; // avoid bottlenecks

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;

// Short string utilities
- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

// Date extremes
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

- (NSDate *)dateWithYMD;
- (NSDate *)dateWithFormatter:(NSString *)formatter;

@end


@interface UIView (Extension)


/**  设置圆角  */
- (void)rounded:(CGFloat)cornerRadius;

/**  设置圆角和边框  */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**  设置边框  */
- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;

/**   给哪几个角设置圆角  */
-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;

/**  设置阴影  */
-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

- (UIViewController *)viewController;

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;

@end
