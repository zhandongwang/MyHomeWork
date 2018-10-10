//
//  NSBundle+Factory.m
//  TDFCategories
//
//  Created by tripleCC on 2017/8/9.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import "NSBundle+Factory.h"

@implementation NSBundle (Factory)
+ (NSBundle *)tdf_bundleForClass:(Class)aClass bundleName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
    return [NSBundle bundleWithURL:url];
}
@end
