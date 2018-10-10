//
//  JsonUtil.h
//  CardApp
//
//  Created by 邵建青 on 14-1-22.
//  Copyright (c) 2014年 ZMSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectUtil : NSObject

+ (BOOL)isNull:(id)object;

+ (BOOL)isNotNull:(id)object;

+ (BOOL)isEmpty:(id)object;

+ (BOOL)isNotEmpty:(id)object;

+ (short)getShortValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (double)getDoubleValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (NSInteger)getIntegerValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (long long)getLonglongValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (NSString *)array2String:(NSArray *)array;

+ (NSString *)getStringValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (NSArray *)getArryValue:(NSDictionary *)dictionary key:(NSString *)key;

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueInt:(NSInteger)value key:(NSString *)key;

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueStr:(NSString *)value key:(NSString *)key;

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueDou:(double)value key:(NSString *)key;

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueDate:(NSDate *)value key:(NSString *)key;

+ (void)setObject:(NSMutableDictionary *)dictionaryData valueLon:(long)value key:(NSString *)key;

+ (NSDictionary *)dictionaryWithJSON:(id)json;

@end