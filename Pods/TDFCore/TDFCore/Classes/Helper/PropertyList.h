//
//  PropertyList.h
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-22.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyList : NSObject

+ (void)updateValue:(id)value forKey:(NSString *)key;

+ (id)readValue:(NSString *)key;

+ (void)removeValue:(NSString *)key;

@end
