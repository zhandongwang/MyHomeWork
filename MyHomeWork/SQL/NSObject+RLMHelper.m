//
//  NSObject+RLMHelper.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "NSObject+RLMHelper.h"
#import <objc/runtime.h>
#import <YYModel/YYClassInfo.h>
#import "FLPersonRealmModel.h"

@implementation NSObject (RLMHelper)

- (id)ccd_realmModelByClass:(Class)targetCls {
    NSParameterAssert(targetCls);
    id realmModel = [[targetCls alloc] init];
    
    
    Class cls = [self class];
    NSDictionary<NSString *, NSString *> *customRLMPropertyMapper = nil;
    NSDictionary<NSString *, Class> *genericMapper = nil;
    
    if ([cls conformsToProtocol:@protocol(RLMHelperProtocol)] && [cls respondsToSelector:@selector(modelCustomRLMPropertyMapper)]) {
        customRLMPropertyMapper = [cls modelCustomRLMPropertyMapper];
    }
    //数组属性
    if ([cls conformsToProtocol:@protocol(RLMHelperProtocol)] && [cls respondsToSelector:@selector(modelContainerRLMPropertyGenericClass)]) {
        genericMapper = [cls modelContainerRLMPropertyGenericClass];
    }

    NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (unsigned int idx = 0; idx < count; ++idx) {
        objc_property_t property = properties[idx];
        
        YYClassPropertyInfo *propertyInfo = [[YYClassPropertyInfo alloc] initWithProperty:property];
        NSString *propertyName = propertyInfo.name;
        if (propertyName.length) {
            if ([filters containsObject:propertyName]) {
                continue;
            }
            objc_property_t targetProperty = class_getProperty(targetCls, property_getName(property));
            if (!targetProperty) {
                @throw [NSException exceptionWithName:@"Transfer RLMModel Error" reason:@"Target Property Not Found" userInfo:nil];
            }
            NSString *targetPropertyName = propertyName;
            if ([customRLMPropertyMapper valueForKey:propertyName]) {
                targetPropertyName = [customRLMPropertyMapper valueForKey:propertyName];
            }
            
            if ([genericMapper.allKeys containsObject:propertyName]) {//数组
                NSArray *itemArray = [self valueForKey:propertyName];
                NSMutableArray *itemTargetArray = [NSMutableArray array];
                [itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    Class itemTargetCls = [obj class];
                    NSString *itemTargetClsName = [self ccd_assembleRealmModelClassName:NSStringFromClass(itemTargetCls)];
                    id itemTargetModel = [obj ccd_realmModelByClass:NSClassFromString(itemTargetClsName)];
                    [itemTargetArray addObject:itemTargetModel];
                }];
                [realmModel setValue:itemTargetArray forKeyPath:targetPropertyName];
                
            } else {
                YYEncodingType type = propertyInfo.type & YYEncodingTypeMask;
                switch (type) {
                    case YYEncodingTypeObject: {
                        if (propertyInfo.cls == [NSNumber class] ||
                            propertyInfo.cls == [NSString class] ||
                            propertyInfo.cls == [NSDate class] ||
                            propertyInfo.cls == [NSData class]) {
                            [realmModel setValue:[self valueForKey:propertyName] forKey:targetPropertyName];
                        } else {//自定义class
                            id subModel = [self valueForKey:propertyName];
                            if (subModel) {
                                NSString *targetSubModelName = [self ccd_assembleRealmModelClassName:NSStringFromClass(propertyInfo.cls)];
                                id targetSubModel = [subModel ccd_realmModelByClass:NSClassFromString(targetSubModelName)];
                                [realmModel setValue:targetSubModel forKey:targetPropertyName];
                            }
                        }
                    }break;
                        
                    case YYEncodingTypeBool:
                    case YYEncodingTypeInt8:
                    case YYEncodingTypeUInt8:
                    case YYEncodingTypeInt16:
                    case YYEncodingTypeUInt16:
                    case YYEncodingTypeInt32:
                    case YYEncodingTypeUInt32:
                    case YYEncodingTypeInt64:
                    case YYEncodingTypeUInt64:
                    case YYEncodingTypeFloat:
                    case YYEncodingTypeDouble:
                    case YYEncodingTypeLongDouble: {
                        [realmModel setValue:[self valueForKey:propertyName] forKey:targetPropertyName];
                    }break;
                        
                    default:
                        break;
                }
            }
        }
        
    }
    
    return realmModel;
}

- (NSString *)ccd_assembleRealmModelClassName:(NSString *)modelClassName {
    if (modelClassName.length == 0 ) {
        return nil;
    }
    NSString *name = nil;
    NSRange range = [modelClassName rangeOfString:@"Model" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        NSString *subString = [modelClassName substringToIndex:range.location];
        name = [NSString stringWithFormat:@"%@RealmModel",subString];
    }
    return name;
}


@end
