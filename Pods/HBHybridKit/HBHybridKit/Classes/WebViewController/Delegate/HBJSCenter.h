//
//  HBJSCenter.h
//  weather
//
//  Created by CaydenK on 2016/12/5.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController,JSContext;


typedef NS_ENUM(NSUInteger, HBJSBridgeCompletionType) {
    HBJSBridgeTypeSuccess,
    HBJSBridgeTypeFailer,
    HBJSBridgeTypeCacenl,
};

@protocol HBJSBridgeProtocol <NSObject>

@required
+ (BOOL)isSupportMethodWithMethodName:(NSString *)methodName;
- (void)executeMethodWithName:(NSString *)methodName params:(id)params completion:(void(^)(HBJSBridgeCompletionType type, id responseObject))completion;

@end


@interface HBJSCenter : NSObject

@property (weak, nonatomic) JSContext *context;

+ (BOOL)registerClass:(Class<HBJSBridgeProtocol>)protocolClass;
+ (BOOL)registerObject:(NSObject<HBJSBridgeProtocol> *)protocolObject;

@end
