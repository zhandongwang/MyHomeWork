//
//  HBJSCenter.mm
//  weather
//
//  Created by CaydenK on 2016/12/5.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import "HBJSCenter.h"
#import "HBUtility.h"
//#import <BlocksKit/BlocksKit+UIKit.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "HBWebEngine.h"
#import <objc/runtime.h>

@protocol HBJSExport <JSExport>

@required
- (void)messageSend:(NSString *)methodName :(NSString *)callBackId :(NSString *)paramsString;
//js执行异常的时候，回调native
- (void)hybrid:(NSString *)callbackClosureId;

@end


@interface HBJSCenter ()<HBJSExport>

@property (class, strong, nonatomic, readonly) NSMutableArray<Class<HBJSBridgeProtocol>> *registedClassArray;

@property (class, strong, nonatomic, readonly) NSMutableArray<NSObject<HBJSBridgeProtocol> *> *registedObjArray;
@property (strong, nonatomic, readonly) NSMutableArray<NSObject<HBJSBridgeProtocol> *> *registedObjArray;

@end

@implementation HBJSCenter {
    NSThread *webThread;
    NSMutableArray<NSObject<HBJSBridgeProtocol> *> *_registedObjArray;
}

+ (BOOL)registerClass:(Class<HBJSBridgeProtocol>)protocolClass {
    if (!protocolClass) { return NO; }
    if (![self.registedClassArray containsObject:protocolClass]) {
        [self.registedClassArray addObject:protocolClass];
        return YES;
    }
    return NO;
}
+ (BOOL)registerObject:(NSObject<HBJSBridgeProtocol> *)protocolObject {
    if (!protocolObject) { return NO; }
    if (![self.registedObjArray containsObject:protocolObject]) {
        [self.registedObjArray addObject:protocolObject];
        return YES;
    }
    return NO;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化
        [self.registedObjArray addObjectsFromArray:[HBJSCenter registedObjArray]];
        [HBJSCenter.registedObjArray removeAllObjects];
    }
    return self;
}


- (void)messageSend:(NSString *)methodName :(NSString *)callBackId :(NSString *)paramsString{
    webThread = [NSThread currentThread];
    //优先判断 Object plugin是否支持
    for (id<HBJSBridgeProtocol> plugin in self.registedObjArray) {
        if ([[plugin class] isSupportMethodWithMethodName:methodName]) {
            //支持
            [self executePlugin:plugin method:methodName callbackId:callBackId params:paramsString];
            return;
        }
    }
    
    //其次判断class plugin
    for (Class cls in HBJSCenter.registedClassArray) {
        if ([cls isSupportMethodWithMethodName:methodName]) {
            //支持
            id<HBJSBridgeProtocol> plugin = [[cls alloc] init];
            [self executePlugin:plugin method:methodName callbackId:callBackId params:paramsString];
            return;
        }
    }
}

- (void)executePlugin:(id<HBJSBridgeProtocol>)plugin method:(NSString *)methodName callbackId:(NSString *)callBackId params:(NSString *)paramsString {
    NSDictionary *dict = [HBUtility jsonDataFromString:paramsString];
    [plugin executeMethodWithName:methodName params:dict completion:^(HBJSBridgeCompletionType type, id responseObject) {
        //执行完成
        NSString *paramsString;
        if (responseObject && [responseObject isKindOfClass:[NSString class]]) {
            paramsString = responseObject;
        }
        else {
            paramsString = [HBUtility jsonStringFromData:responseObject];
        }
        [self sendCallBackWithId:callBackId
                            type:bridgeCompletionTypeMap(type)
                    paramsString:paramsString];
    }];
    return;

}


- (void)hybrid:(NSString *)callbackClosureId {
    NSLog(@"no callBack with id:%@",callbackClosureId);
}

- (void)sendCallBackWithId:(NSString *)callBackId type:(NSString *)type paramsString:(NSString *)paramsString {
    [self sendCallBackWithId:callBackId type:type paramsString:paramsString sync:NO];
}

- (void)sendCallBackWithId:(NSString *)callBackId type:(NSString *)type paramsString:(NSString *)paramsString sync:(BOOL)sync {
    NSString *javaScript = [NSString stringWithFormat:@"FRWCardApp.callBackFromNative('%@','%@','%@');",callBackId, type, paramsString];
    [self performSelector:@selector(disposeCallBackOnWebThreadWithJavaScript:) onThread:webThread withObject:javaScript waitUntilDone:sync];
}

- (void)disposeCallBackOnWebThreadWithJavaScript:(NSString *)javaScript {
    NSLog(@"%@",javaScript);
    [self.context evaluateScript:javaScript];
}

#pragma mark - type mapping
NSString *bridgeCompletionTypeMap(HBJSBridgeCompletionType type) {
    if (type == HBJSBridgeTypeSuccess) {
        return @"success";
    }
    else if (type == HBJSBridgeTypeFailer) {
        return @"failer";
    }
    else if (type == HBJSBridgeTypeCacenl) {
        return @"cancel";
    }
    else {
        return @"";
    }
}

#pragma mark - Getter
+ (NSMutableArray<Class<HBJSBridgeProtocol>> *)registedClassArray {
    NSMutableArray<Class<HBJSBridgeProtocol>> *_registedClassArray = objc_getAssociatedObject(self, _cmd);
    if (!_registedClassArray) {
        _registedClassArray = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, _registedClassArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _registedClassArray;
}

+ (NSMutableArray<NSObject<HBJSBridgeProtocol> *> *)registedObjArray {
    NSMutableArray<NSObject<HBJSBridgeProtocol> *> *_registedObjArray = objc_getAssociatedObject(self, _cmd);
    if (!_registedObjArray) {
        _registedObjArray = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, _registedObjArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _registedObjArray;
}

- (NSMutableArray<NSObject<HBJSBridgeProtocol> *> *)registedObjArray {
    if (!_registedObjArray) {
        _registedObjArray = @[].mutableCopy;
    }
    return _registedObjArray;
}

@end
