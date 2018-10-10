//
//  NSDictionary+Enum.m
//  Pods-TDFCategories
//
//  Created by tripleCC on 2017/10/12.
//

#import "NSDictionary+Enum.h"

@implementation NSDictionary (Enum)
- (NSInteger)tdf_indexForValue:(id)value {
    return [self.allValues indexOfObject:value];
}

- (NSInteger)tdf_indexForKey:(id)key {
    return [self.allKeys indexOfObject:key];
}

- (NSInteger)tdf_keyIntegerForValue:(id)value {
    NSInteger index = [self.allValues indexOfObject:value];
    if (index == NSNotFound) {
        return 0;
    }
    if (self.allKeys.count > index) {
        return [self.allKeys[index] integerValue];
    }
    
    return 0;
}

- (id)tdf_valueForInteger:(NSInteger)integer {
    return self[@(integer)] ?: self.allValues.firstObject;
}
@end
