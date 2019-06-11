//
//  NSObject+RLMHelper.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, CCDEncodingType) {
    CCDEncodingTypeMask       = 0xFF, ///< mask of type value
    CCDEncodingTypeUnknown    = 0, ///< unknown
    CCDEncodingTypeVoid       = 1, ///< void
    CCDEncodingTypeBool       = 2, ///< bool
    CCDEncodingTypeInt8       = 3, ///< char / BOOL
    CCDEncodingTypeUInt8      = 4, ///< unsigned char
    CCDEncodingTypeInt16      = 5, ///< short
    CCDEncodingTypeUInt16     = 6, ///< unsigned short
    CCDEncodingTypeInt32      = 7, ///< int
    CCDEncodingTypeUInt32     = 8, ///< unsigned int
    CCDEncodingTypeInt64      = 9, ///< long long
    CCDEncodingTypeUInt64     = 10, ///< unsigned long long
    CCDEncodingTypeFloat      = 11, ///< float
    CCDEncodingTypeDouble     = 12, ///< double
    CCDEncodingTypeLongDouble = 13, ///< long double
    CCDEncodingTypeObject     = 14, ///< id
    CCDEncodingTypeClass      = 15, ///< Class
    CCDEncodingTypeSEL        = 16, ///< SEL
    CCDEncodingTypeBlock      = 17, ///< block
    CCDEncodingTypePointer    = 18, ///< void*
    CCDEncodingTypeStruct     = 19, ///< struct
    CCDEncodingTypeUnion      = 20, ///< union
    CCDEncodingTypeCString    = 21, ///< char*
    CCDEncodingTypeCArray     = 22, ///< char[10] (for example)
};


@interface NSObject (RLMHelper)

- (id)realmModelByClass:(Class)cls;


@end

@protocol RLMHelper <NSObject>

+ (nullable NSDictionary<NSString *, id> *)modelCustomRLMPropertyMapper;

+ (nullable NSDictionary<NSString *, id> *)modelContainerRLMPropertyGenericClass;

@end

NS_ASSUME_NONNULL_END
