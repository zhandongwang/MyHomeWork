//
//  TDFBaseInfoDefaults.m
//  Pods
//
//  Created by tripleCC on 2017/8/5.
//
//

#import "TDFBaseInfoDefaults.h"

@implementation TDFBaseInfoDefaults
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    
    static id singleton = nil;
    
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });

    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 掌柜用 pod 'TDFBossBaseInfoDefaults' 引入配置分类
        // 其他业务线可以选择创建自己的配置 pod ，或者手动将分类文件放进主工程
        if (![self conformsToProtocol:@protocol(TDFBaseInfoDefaultsInitialProtocol)]) {
            @throw [NSException exceptionWithName:NSGenericException reason:@"You should implement a category of TDFBaseInfoDefaults class and then conform the <TDFBaseInfoDefaultsInitialProtocol> protocol to init all ivars in -initDefaultsInformation method" userInfo:nil];
        }
        
        [(id <TDFBaseInfoDefaultsInitialProtocol>)self initDefaultsInformation];
    }
    return self;
}
@end
