//
//  NSBundle+Factory.h
//  TDFCategories
//
//  Created by tripleCC on 2017/8/9.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Factory)
+ (NSBundle *)tdf_bundleForClass:(Class)aClass bundleName:(NSString *)bundleName;
@end
