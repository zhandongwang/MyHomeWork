//
//  HBUtility.h
//  weather
//
//  Created by CaydenK on 2016/12/6.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBUtility : NSObject


///**
// 验证是否符合正则表达式
//
// @param aString 待验证的字符串
// @param regularArray 正则表达式列表
// @return 是否符合
// */
//+ (BOOL)verifyString:(NSString *)aString regularArray:(NSArray<NSString *> *)regularArray;
//

/**
 验证是包含正则表达式的内容

 @param string 待验证的字符串
 @param regexStr 正则表达式
 @return 是否符合
 */
+ (BOOL)verifyString:(NSString*)string containsRegex:(NSString*)regexStr;

/**
 URL中的query解析为字典
 */
+ (NSDictionary<NSString *, NSString *>*)queryParamsFromURL:(NSURL*)url;

+ (id)jsonDataFromString:(NSString *)paramString;
+ (NSString *)jsonStringFromData:(id)json;

@end
