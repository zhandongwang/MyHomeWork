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

- (id)realmModelByClass:(Class)targetCls {
    NSParameterAssert(targetCls);
    id realmModel = [[targetCls alloc] init];
    
    
    Class originCls = [self class];
    NSDictionary<NSString *, id> *genericMapper = nil;
    //数组属性
    if ([originCls respondsToSelector:@selector(modelContainerRLMPropertyGenericClass)]) {
        genericMapper = [originCls modelContainerRLMPropertyGenericClass];
    }
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(originCls, &count);
    for (unsigned int idx = 0; idx < count; ++idx) {
        objc_property_t property = properties[idx];
        const char * name = property_getName(property);
        if (name) {
            NSString *propertyName = [NSString stringWithUTF8String:name];
            objc_property_t targetProperty = class_getProperty(targetCls, name);
            if (!targetProperty) {
                @throw [NSException exceptionWithName:@"Transfer RLMModel Error" reason:@"Target Property Not Found" userInfo:nil];
            }
            if ([genericMapper.allKeys containsObject:propertyName]) {//数组属性暂不处理
                continue;
            }
            CCDEncodingType type = 0;
            unsigned int attrCount = 0;
            objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
            for (unsigned int i = 0; i < attrCount; ++i) {
                switch (attrs[i].name[0]) {
                        case 'T':{//Type Encoding
                            NSString *typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                            type = CCDEncodingGetType(attrs[i].value);
                            if ((type & CCDEncodingTypeMask) == CCDEncodingTypeObject && typeEncoding.length) {
                                NSScanner *scanner = [NSScanner scannerWithString:typeEncoding];
                                if (![scanner  scanString:@"@\""  intoString:NULL]) {
                                      continue;
                                }
                                NSString *clsName = nil;
                                if ([scanner scanUpToCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName]) {
                                    if (clsName.length) {
                                        Class tmpCls = objc_getClass(clsName.UTF8String);
                                        
                                        NSString *innerRealmClsName = [NSString stringWithFormat:@"%@RLM",NSStringFromClass(tmpCls)];
                                    }
                                }
                                
                            }
                            
                            
                            
                        }break;
                        
                    default:
                        break;
                }
                
            }
            if (attrs) {
                free(attrs);
                attrs = NULL;
            }
        
        }
    }
    if (properties) {
        free(properties);
        properties = NULL;
    }
    
    
    return realmModel;
}

@end
