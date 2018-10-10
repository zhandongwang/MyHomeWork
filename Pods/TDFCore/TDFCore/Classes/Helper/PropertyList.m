//
//  PropertyList.m
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-22.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Estimate.h"
#import "PropertyList.h"
#import "ObjectUtil.h"

#define CONFIG_FILE @"properties.plist"

@implementation PropertyList

+ (void)updateValue:(id)value forKey:(NSString *)key
{
    if ([NSString isNotBlank:key] && [ObjectUtil isNotNull:value]) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
}

+ (id)readValue:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        return value;
    }
    return nil;
}

+ (void)removeValue:(NSString *)key
{
    if ([NSString isNotBlank:key]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

@end
