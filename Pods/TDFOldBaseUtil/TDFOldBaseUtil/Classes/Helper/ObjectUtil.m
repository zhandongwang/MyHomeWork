//
//  JsonUtil.m
//  CardApp
//
//  Created by 邵建青 on 14-1-22.
//  Copyright (c) 2014年 ZMSOFT. All rights reserved.
//

#import "DateUtils.h"
#import "ObjectUtil.h"
#import "NSString+Estimate.h"

@implementation ObjectUtil

+ (BOOL)isNull:(id)object
{
    if (object == nil || object == [NSNull null]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNotNull:(id)object
{
    if (object != nil && object != [NSNull null]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEmpty:(id)object
{
    if ([ObjectUtil isNull:object]) {
        return YES;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)object;
        return (array.count==0);
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)object;
        return (dictionary.count==0);
    }
    return NO;
}

+ (BOOL)isNotEmpty:(id)object
{
    if ([ObjectUtil isNotNull:object]) {
        if ([object isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)object;
            return (array.count>0);
        }
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = (NSDictionary *)object;
            return (dictionary.count>0);
        }
    }
    return NO;
}

+ (short)getShortValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object shortValue];
        }
    }
    return 0;
}

+ (double)getDoubleValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object doubleValue];
        }
    }
    return 0;
}

+ (NSInteger)getIntegerValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object integerValue];
        }
    }
    return 0;
}

+ (long long)getLonglongValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return [object longLongValue];
        }
    }
    return 0;
}

+ (NSString *)getStringValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return object;
        }
    }
    return @"";
}
+ (NSArray *)getArryValue:(NSDictionary *)dictionary key:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id object = [dictionary objectForKey:key];
        if ([ObjectUtil isNotNull:object]) {
            return object;
        }
    }
    return [NSArray array];
}

+ (NSString *)array2String:(NSArray *)array
{
    if ([ObjectUtil isNotEmpty:array]) {
        NSString *stringBuffer = @"";
        BOOL isFirst = YES;
        for (NSString *string in array) {
            if (isFirst==NO) {
                stringBuffer = [stringBuffer stringByAppendingString:@","];
            }
            stringBuffer = [stringBuffer stringByAppendingString:string];
            isFirst=NO;
        }
        return stringBuffer;
    }
    return nil;
}

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueInt:(NSInteger)value key:(NSString *)key
{
    if (dictionaryData !=nil && [NSString isNotBlank:key]) {
        [dictionaryData setObject:[NSString stringWithFormat:@"%li", (long)value] forKey:key];
    }
}

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueStr:(NSString *)value key:(NSString *)key
{
    if (dictionaryData !=nil && [ObjectUtil isNotNull:value] && [NSString isNotBlank:key]) {
        [dictionaryData setObject:value forKey:key];
    }
}

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueDou:(double)value key:(NSString *)key
{
    if (dictionaryData !=nil && [NSString isNotBlank:key]) {
        [dictionaryData setObject:[NSString stringWithFormat:@"%0.2f", value] forKey:key];
    }
}

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueDate:(NSDate *)value key:(NSString *)key
{
    if (dictionaryData !=nil && [ObjectUtil isNotNull:value] && [NSString isNotBlank:key]) {
        [dictionaryData setObject:[DateUtils formatTimeWithDate:value type:TDFFormatTimeTypeFullTime] forKey:key];
    }
}

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueLon:(long)value key:(NSString *)key
{
    if (dictionaryData !=nil && [NSString isNotBlank:key]) {
        [dictionaryData setObject:[NSString stringWithFormat:@"%li", value] forKey:key];
    }
}

+ (NSDictionary *)dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

@end