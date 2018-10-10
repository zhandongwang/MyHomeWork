//
//  HBUtility.m
//  weather
//
//  Created by CaydenK on 2016/12/6.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import "HBUtility.h"

@implementation HBUtility

///**
// 验证是否符合正则表达式
// 
// @param aString 待验证的字符串
// @param regularArray 正则表达式列表
// @return 是否符合
// */
//+ (BOOL)verifyString:(NSString *)aString regularArray:(NSArray<NSString *> *)regularArray {
//    for (NSString *regular in regularArray) {
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionCaseInsensitive error:NULL];
//        NSArray<NSTextCheckingResult *> *result = [regex matchesInString:aString options:0 range:NSMakeRange(0, aString.length)];
//        if (result.count) {
//            return YES;
//        }
//    }
//    return NO;
//}

+ (BOOL)verifyString:(NSString*)string containsRegex:(NSString*)regexStr {
    if (string.length == 0 || regexStr.length == 0) {
        return NO;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:NULL];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    return result.count > 0;
}

/**
 URL中的query解析为字典
 */
+(NSDictionary<NSString *, NSString *>*)queryParamsFromURL:(NSURL*)url {
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSMutableDictionary<NSString *, NSString *> *queryParams = @{}.mutableCopy;
    for (NSURLQueryItem* queryItem in [urlComponents queryItems])
    {
        if (queryItem.value == nil) {
            continue;
        }
        [queryParams setObject:queryItem.value forKey:queryItem.name];
    }
    return queryParams;
}

+ (id)jsonDataFromString:(NSString *)paramString {
    NSData *detailData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    if (detailData == nil) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:detailData options:0 error:nil];
}

+ (NSString *)jsonStringFromData:(id)json {
    NSString *jsonString = nil;
    NSError *error;
    if (!json) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:0
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
