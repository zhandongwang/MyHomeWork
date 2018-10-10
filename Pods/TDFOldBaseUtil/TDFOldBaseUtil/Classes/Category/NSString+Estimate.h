//
//  UIHelper.h
//  RestApp
//
//  Created by zxh on 14-3-27.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Estimate)

+ (BOOL)isNotBlank:(NSString *)source;

+ (BOOL)isBlank:(NSString *)source;

//正整数验证(带0).
+ (BOOL) isPositiveNum:(NSString *)source;

// 是否是纯数字
+ (BOOL)isValidNumber:(NSString*)value;

+ (BOOL) isNumNotZero:(NSString *)source;

+ (BOOL) isNotNumAndLetter:(NSString *)source;

//整数验证.
+ (BOOL) isInt:(NSString *)source;

//小数正验证.
+ (BOOL) isFloat:(NSString *)source;

//日期验证.
+ (BOOL) isDate:(NSString *)source;

//URL路径过滤掉随机数.
+ (NSString*) urlFilterRan:(NSString *)urlPath;

+ (NSString *)getUniqueStrByUUID;

//验证Email是否正确.
+ (BOOL)isValidateEmail:(NSString *)email;

//密码验证（只能输入数字，字母（区分大小写））
+(BOOL)isRightPassword:(NSString *)password;

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//判断是否为汉字
+ (BOOL)isChineseCharacter:(NSString *)text;

//判断IP地址是否有效
+ (BOOL)isValidatIP:(NSString *)ipAddress;

//URL中文转码
+(NSString *)urlStringEncode:(NSString *)urlString;

//千分位转换
+(NSString *)numberFormatterWithDouble:(NSNumber *)number;
+(NSString *)numberFormatterWithInt:(NSNumber *)number;

+(NSString *)notRounding:(double)price afterPoint:(int)position;
//格式话小数 四舍五入类型  例子：[self decimalwithFormat:@"0.00" floatV:0.335] 输出0.34;
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(double)doubel;

// 电话号码的验证
+ (BOOL)isRightTelephoneNumber:(NSString *)phoneNum;

// 传真号码的验证
+ (BOOL)isRightFaxNumber:(NSString *)faxNum;

- (BOOL)checkStringisMatch:(NSString *)regex;

@end
