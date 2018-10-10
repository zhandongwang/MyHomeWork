//
//  TDFNetconnTypeHelper.h
//  AFNetworking
//
//  Created by Octree on 19/12/2017.
//

#import <Foundation/Foundation.h>
//(有线： 1； wifi： 2； 3G： 3；4G：4；5G：5)
typedef NS_ENUM(NSInteger, TDFNetconnType) {
    
    TDFNetconnTypeWIFI      =   2,
    TDFNetconnType3G        =   3,
    TDFNetconnType4G        =   4,
    TDFNetconnType5G        =   5,
    TDFNetconnTypeOthers    =   6,
};

@interface TDFNetconnTypeHelper : NSObject

+ (TDFNetconnType)netconnType;

@end
