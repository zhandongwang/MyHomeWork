//
//  NSString+Rule.m
//  RestApp
//
//  Created by Arlen on 2017/7/14.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import "NSString+Rule.h"

#define OnlyChineseRule     @"[\u4e00-\u9fa5]"                      //仅仅中文模式
#define OnlyEnglishRule     @"[a-zA-Z]"                             //仅仅英文模式
#define OnlyNumberRule      @"[0-9]"                                //仅仅数字模式
#define EnglisthNumber      @"[a-zA-Z0-9]"                          //英文 - 数字 模式
#define ChineseNumber       @"[0-9\\u4e00-\u9fa5]"                  //中文 - 数字 模式
#define ChineseEnglish      @"[a-zA-Z\\u4e00-\u9fa5]"               //中文 - 英文 模式
#define ChineseEngNum       @"[0-9a-zA-Z\\u4e00-\u9fa5]"            //数字 - 英文 - 中文 模式

@implementation NSString (Rule)

- (BOOL)isRuleType:(NSStringRuleType)ruleType min:(int)min max:(int)max
{
    if (ruleType == NSStringRuleTypeDefault) {
        return YES;
    }
    
    //数组：正则的字符串，和枚举值对应1
    NSArray *array  =   @[OnlyChineseRule,OnlyEnglishRule,OnlyNumberRule,ChineseEnglish,ChineseNumber,EnglisthNumber,ChineseEngNum ];
    
    //拼接成正则。长度为0～20
    NSString *rule  = [NSString stringWithFormat:@"%@{%d,%d}",array[ruleType - 1],min,max];
    
    //创建谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",rule];
    
    //进行判断
    return [predicate evaluateWithObject:self];
}




- (BOOL)isEmail
{
    NSString *email = self;
    if([self rangeOfString:@"\n"].location !=NSNotFound)
    {
        email =  [email stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    if ([email rangeOfString:@" "].location !=NSNotFound) {
        email =  [email stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if (email.length > 50) {
        return NO;
    }
    
    NSString *rule  =   @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",rule];
    return [predicate evaluateWithObject:email];
}

- (BOOL)isMobilePhone
{
    if (self.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL)companyNameRuleMinNum:(int)min maxNum:(int)max {
    NSString *string = @"[\\(\\)\\（\\）0-9a-zA-Z\\u4e00-\u9fa5]";
    string = [NSString stringWithFormat:@"%@{%d,%d}",string,min,max];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",string];
    return [predicate evaluateWithObject:self];
}


- (BOOL)addressRuleMinNum:(int)min maxNum:(int)max {
    NSString *string = @"[0-9a-zA-Z_\\-\\、\\u4e00-\u9fa5]";
    string = [NSString stringWithFormat:@"%@{%d,%d}",string,min,max];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",string];
    return [predicate evaluateWithObject:self];
}



@end
