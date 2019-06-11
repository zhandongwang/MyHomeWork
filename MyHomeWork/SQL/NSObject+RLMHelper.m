//
//  NSObject+RLMHelper.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "NSObject+RLMHelper.h"
#import <objc/runtime.h>
#import "FLPersonRealmModel.h"
#import <YYModel/YYClassInfo.h>

CCDEncodingType CCDEncodingGetType(const char *typeEncoding) {
    char *type = (char *)typeEncoding;
    if (!type) {
        return CCDEncodingTypeUnknown;
    }
    size_t len = strlen(type);
    if (len == 0) {
        return CCDEncodingTypeUnknown;
    }
    switch (*type) {
            case 'v': return CCDEncodingTypeVoid;
            case 'B': return CCDEncodingTypeBool;
            case 'c': return CCDEncodingTypeInt8;
            case 'C': return CCDEncodingTypeUInt8;
            case 's': return CCDEncodingTypeInt16;
            case 'S': return CCDEncodingTypeUInt16;
            case 'i': return CCDEncodingTypeInt32;
            case 'I': return CCDEncodingTypeUInt32;
            case 'l': return CCDEncodingTypeInt32;
            case 'L': return CCDEncodingTypeUInt32;
            case 'q': return CCDEncodingTypeInt64;
            case 'Q': return CCDEncodingTypeUInt64;
            case 'f': return CCDEncodingTypeFloat;
            case 'd': return CCDEncodingTypeDouble;
            case 'D': return CCDEncodingTypeLongDouble;
            case '#': return CCDEncodingTypeClass;
            case ':': return CCDEncodingTypeSEL;
            case '*': return CCDEncodingTypeCString;
            case '^': return CCDEncodingTypePointer;
            case '[': return CCDEncodingTypeCArray;
            case '(': return CCDEncodingTypeUnion;
            case '{': return CCDEncodingTypeStruct;
            case '@': {
                if (len == 2 && *(type + 1) == '?')
                return CCDEncodingTypeBlock;
                else
                return CCDEncodingTypeObject;
            }
        default: return CCDEncodingTypeUnknown ;
    }
}

@implementation NSObject (RLMHelper)

- (id)ccd_realmModelByClass:(Class)targetCls {
    NSParameterAssert(targetCls);
    id realmModel = [[targetCls alloc] init];
    
    
    Class cls = [self class];
    NSDictionary<NSString *, Class> *genericMapper = nil;
    NSDictionary<NSString *, NSString *> *customRLMPropertyMapper = nil;
    
    if ([cls respondsToSelector:@selector(modelCustomRLMPropertyMapper)]) {
        customRLMPropertyMapper = [cls modelCustomRLMPropertyMapper];
    }
    
    //数组属性
    if ([cls respondsToSelector:@selector(modelContainerRLMPropertyGenericClass)]) {
        genericMapper = [cls modelContainerRLMPropertyGenericClass];
    }

    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (unsigned int idx = 0; idx < count; ++idx) {
        objc_property_t property = properties[idx];
        
        YYClassPropertyInfo *propertyInfo = [[YYClassPropertyInfo alloc] initWithProperty:property];
        NSString *propertyName = propertyInfo.name;
        if (propertyName.length) {
            objc_property_t targetProperty = class_getProperty(targetCls, property_getName(property));
            if (!targetProperty) {
                @throw [NSException exceptionWithName:@"Transfer RLMModel Error" reason:@"Target Property Not Found" userInfo:nil];
            }
            if ([genericMapper.allKeys containsObject:propertyName]) {//数组属性暂不处理
                continue;
            }
            NSString *targetPropertyName = propertyName;
            if ([customRLMPropertyMapper valueForKey:propertyName]) {
                targetPropertyName = [customRLMPropertyMapper valueForKey:propertyName];
            }
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
