//
//  UIHelper.h
//  RestApp
//
//  Created by zxh on 14-3-27.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "RegexKitLite.h"
#import "NSString+Estimate.h"

@implementation NSString (Estimate)

+ (BOOL)isNotBlank:(NSString *)source
{
    if (source == nil || [source isEqual:[NSNull null]] || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return NO;
    }
    return YES;
}

+ (BOOL)isBlank:(NSString *)source
{
    if (source == nil || [source isEqual:[NSNull null]] || source.length == 0 || [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}

//非0正整数验证.
+ (BOOL)isNumNotZero:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

//格式话小数 四舍五入类型  例子：[self decimalwithFormat:@"0.00" floatV:0.336] 输出0.34;
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(double)doubel
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithDouble:doubel]];
}

//正整数验证(带0).
+ (BOOL)isPositiveNum:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^[1-9]\\d*|0$";
    return [source isMatchedByRegex:format];
}

// 是否是纯数字
+ (BOOL)isValidNumber:(NSString*)value
{
    NSString* num = @"^[0-9]+$";
    NSPredicate *regextestnum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    return [regextestnum evaluateWithObject:value];;
}

//整数验证.
+ (BOOL)isInt:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString* format=@"^-?[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

//小数正验证.
+ (BOOL)isFloat:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    if ([NSString isPositiveNum:source]) {
        return YES;
    }
    NSString* format=@"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    return [source isMatchedByRegex:format];
}

//包换不是数字英文字母验证.
+ (BOOL)isNotNumAndLetter:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return YES;
    }
    NSString* format=@"[^a-zA-Z0-9]+";
    return [source isMatchedByRegex:format];
}

//日期验证.
+ (BOOL)isDate:(NSString*)source
{
    if ([NSString isBlank:source]) {
        return NO;
    }
    NSString *format=@"^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2} CST$";
    return [source isMatchedByRegex:format];
}

//URL路径过滤掉随机数.
+ (NSString*)urlFilterRan:(NSString*)urlPath
{
    if ([NSString isNotBlank:urlPath]) {
        NSString *regex = @"(.*)([\\?|&]ran=[^&]+)";
        return [urlPath stringByReplacingOccurrencesOfRegex:regex withString:@"$1"];
    }
    return nil;
}

+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    retStr=[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [retStr lowercaseString];
}
//密码验证（只能输入数字，字母（区分大小写））
+(BOOL)isRightPassword:(NSString *)password{
    
    if ([NSString isNotBlank:password]) {
        NSString *regex = @"^[A-Za-z0-9]{6，}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if([pred evaluateWithObject:password])
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isRightTelephoneNumber:(NSString *)phoneNum {
    
    if ([NSString isNotBlank:phoneNum]) {
        NSString *regex = @"^(\\d{3,4}-)\\d{7,8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if([pred evaluateWithObject:phoneNum])
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isRightFaxNumber:(NSString *)faxNum {
    
    if ([NSString isNotBlank:faxNum]) {
        NSString *regex = @"^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if([pred evaluateWithObject:faxNum])
        {
            return YES;
        }
    }
    
    return NO;
}

//验证Email是否正确.
+ (BOOL)isValidateEmail:(NSString *)email
{
    if ([NSString isNotBlank:email]) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if([email rangeOfString:@"\n"].location !=NSNotFound)
        {
            email =  [email stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        }
        if ([email rangeOfString:@" "].location !=NSNotFound) {
            email =  [email stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        return [emailTest evaluateWithObject:email];
    }
    return NO;
}
// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //    /**
    //     * 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
    //        || ([regextestcm evaluateWithObject:mobileNum] == YES)
    //        || ([regextestct evaluateWithObject:mobileNum] == YES)
    //        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    
    if ([NSString isNotBlank:mobileNum]) {
        //手机号码不为空时再去做判断
        if (11 != mobileNum.length || ![@"1" isEqualToString:[mobileNum substringToIndex:1]]) {
            return NO;
        }
    }
    return YES;
}

//判断是否为汉字
+ (BOOL)isChineseCharacter:(NSString *)text
{
    int a = 0;
    for (int i=0; i<text.length; i++) {
        NSRange range=NSMakeRange(i,1);
        NSString *subString=[text substringWithRange:range];
        const char *cString=[subString UTF8String];
        if (strlen(cString)==3)
        {
            a=1;
        }else{
            a=0;
            return NO;
        }
    }
//    if (a == 1) {
//        return YES;
//    }
    
    return a == 1;
}

//判断IP地址是否有效
+ (BOOL)isValidatIP:(NSString *)ipAddress{
    
    NSString  *urlRegEx =@"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:ipAddress];
    
}

//URL中文转码
+(NSString *)urlStringEncode:(NSString *)urlString{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
#pragma GCC diagnostic pop
    return encodedString;
}
//千分位转换
+(NSString *)numberFormatterWithDouble:(NSNumber *)number{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:number];
    return formattedNumberString;
}
+(NSString *)numberFormatterWithInt:(NSNumber *)number{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:number];
    return formattedNumberString;
}

//double和float 类型四舍五入（只舍不入）
/**
 *  @param price    数据
 *  @param position 几位小数
 */
+(NSString *)notRounding:(double)price afterPoint:(int)position{
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
    
}

- (BOOL)checkStringisMatch:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    bool isMatch = [predicate evaluateWithObject:self];
    return isMatch;
}


@end
