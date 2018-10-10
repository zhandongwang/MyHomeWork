//
//  NSDictionary+Enum.h
//  Pods-TDFCategories
//
//  Created by tripleCC on 2017/10/12.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Enum)
- (NSInteger)tdf_keyIntegerForValue:(id)value;
- (id)tdf_valueForInteger:(NSInteger)integer;
- (NSInteger)tdf_indexForKey:(id)key;
- (NSInteger)tdf_indexForValue:(id)value;
@end
