//
//  NSString+Rule.h
//  RestApp
//
//  Created by Arlen on 2017/7/14.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NSStringRuleTypeDefault,                    //默认的类型：没有条件限制
    NSStringRuleTypeOnlyChinese,                //仅仅中文  -   模式。
    NSStringRuleTypeOnlyEnglish,                //仅仅英文  -   英文。
    NSStringRuleTypeOnlyNumber,                 //仅仅数字  -   模式
    NSStringRuleTypeChineseEnglish,             //中文 - 英文：模式
    NSStringRuleTypeChineseNumber,              //中文 - 数字：模式
    NSStringRuleTypeEnglishNumber,              //英文 - 数字：模式
    NSStringRuleTypeChineseEnglistNumber,       //中文 - 英文 - 数组：模式
    NSStringRuleTypeEmail,                      //邮箱
} NSStringRuleType;

@interface NSString (Rule)

/**
 判断字符串格式

 @param ruleType 格式
 @param min 最小数量
 @param max 最大数量
 @return 判断的结果
 */
- (BOOL)isRuleType:(NSStringRuleType)ruleType min:(int)min max:(int)max;


/*****  判断字符串是否是邮箱格式 *****/
- (BOOL)isEmail;

/***** 判断是否是手机 *****/
- (BOOL)isMobilePhone;

//是否是企业名称格式
- (BOOL)companyNameRuleMinNum:(int)min maxNum:(int)max;

//是否是详细地址格式
- (BOOL)addressRuleMinNum:(int)min maxNum:(int)max;


@end
