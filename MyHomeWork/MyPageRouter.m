//
//  MyPageRouter.m
//  MyHomeWork
//
//  Created by 王战东 on 2016/11/9.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageRouter.h"
#import <objc/runtime.h>

// 协议头与path间的分隔符
static NSString * const kSchemaProtocolDelimiter = @"~";
NSString * const kHBPageRouteNotificationValidateResult = @"kNotificationPageRouteValidateResult";//通知发送校验结果 {result:YES/NO,paramsDict:paramsDict}

NSString * const kHBPageRouteBlockSuffix = @"kHBPageRouteBlockSuffix";

@interface MyPageRouter ()
@property (strong, nonatomic) NSMutableDictionary *routes;
@property (assign, nonatomic) BOOL enableScheme;

@end

@implementation MyPageRouter

+ (instancetype)router
{
    static MyPageRouter *router = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        router = [[self alloc] init];
    });
    return router;
}

+ (void)enableScheme:(BOOL)enable
{
    [MyPageRouter router].enableScheme = enable;
}

- (void)registerUrl:(NSString *)route toControllerClass:(Class)controllerClass
{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    subRoutes[@"_"] = controllerClass;
    
    NSMutableArray *targetArray = self.targetRoutes[NSStringFromClass(controllerClass)];
    if (targetArray) {
        [targetArray addObject:route];
    } else {
        self.targetRoutes[NSStringFromClass(controllerClass)] = @[route].mutableCopy;
    }
}

- (UIViewController *)matchControllerUrl:(NSString *)route
{
    NSMutableDictionary *params = [self paramsInRoute:route];
    return [self createViewControllerByRouteParams:params];
}

// extract params in a route
- (NSMutableDictionary *)paramsInRoute:(NSString *)route
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (!self.enableScheme) {
        route = [self stringFromFilterAppUrlScheme:route];
    }
    params[@"route"] = route;
    
    NSMutableDictionary *subRoutes = self.routes;
    NSArray *pathComponents = [self pathComponentsFromRoute:route];
    for (NSString *pathComponent in pathComponents) {
        BOOL found = NO;
        NSArray *subRoutesKeys = subRoutes.allKeys;
        for (NSString *key in subRoutesKeys) {
            if ([subRoutesKeys containsObject:pathComponent]) {
                found = YES;
                subRoutes = subRoutes[pathComponent];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRoutes = subRoutes[key];
                params[[key substringFromIndex:1]] = pathComponent;
                break;
            }
        }
        if (!found) {
            return nil;
        }
    }
    
    // Extract Params From Query.
    NSRange firstRange = [route rangeOfString:@"?"];
    if (firstRange.location != NSNotFound && route.length > firstRange.location + firstRange.length) {
        NSString *paramsString = [route substringFromIndex:firstRange.location + firstRange.length];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *paramString in paramStringArr) {
            NSArray *paramArr = [paramString componentsSeparatedByString:@"="];
            if (paramArr.count > 1) {
                NSString *key = [paramArr objectAtIndex:0];
                NSString *value = [paramArr objectAtIndex:1];
                params[key] = value;
            }
        }
    }
    
    Class class = subRoutes[@"_"];
    if (class_isMetaClass(object_getClass(class))) {
        if ([class isSubclassOfClass:[UIViewController class]]) {
            params[@"controller_class"] = subRoutes[@"_"];
        } else {
            return nil;
        }
    } else {
        if (subRoutes[@"_"]) {
            params[@"block"] = [subRoutes[@"_"] copy];
        }
    }
    return params;
}

- (UIViewController *)createViewControllerByRouteParams:(NSMutableDictionary *)params
{
    Class controllerClass = params[@"controller_class"];
    if (!controllerClass) {
        return nil;
    }
    
    NSString *route = params[@"route"];
    NSString *target = route;
    if (route && [route containsString:@"?"]) {
        target = [route componentsSeparatedByString:@"?"][0];
    }
    [params setValue:target forKey:@"target"];
    
    UIViewController *viewController = [[controllerClass alloc] init];
    //    if (![[viewController class] validateParams:params]) {
    BOOL validateResult = [viewController validateParams:params];
    [[NSNotificationCenter defaultCenter] postNotificationName:kHBPageRouteNotificationValidateResult object:nil userInfo:@{@"result":@(validateResult),@"paramsDict":[params copy]}];
    if (!validateResult) {
        return nil;
    }
    
    objc_setAssociatedObject(viewController, @selector(params), [params copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return viewController;
}


- (NSMutableDictionary *)subRoutesToRoute:(NSString *)route
{
    if (!self.enableScheme) {
        route = [self stringFromFilterAppUrlScheme:route];
    }
    NSArray *pathComponents = [self pathComponentsFromRoute:route];
    NSInteger index = 0;
    NSMutableDictionary *subRoutes = self.routes;
    while (index < pathComponents.count) {
        NSString *pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    
    return subRoutes;
}

- (NSString *)stringFromFilterAppUrlScheme:(NSString *)string
{
    // 过滤一切scheme
    if ([string rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [string componentsSeparatedByString:@"://"];
        NSString *appUrlScheme = pathSegments[0];
        string = [string substringFromIndex:appUrlScheme.length + 2];
    }
    return string;
}

- (NSArray *)pathComponentsFromRoute:(NSString *)route
{
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([route rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [route componentsSeparatedByString:@"://"];
        // 添加scheme
        NSString *scheme = pathSegments[0];
        [pathComponents addObject:scheme];
        
        // 如果只有协议，那么放一个占位符
        if ((pathSegments.count == 2 && ((NSString *)pathSegments[1]).length) || pathSegments.count < 2) {
            [pathComponents addObject:kSchemaProtocolDelimiter];
        }
        route = [route substringFromIndex:scheme.length + 2];
    }
    
    for (NSString *pathComponent in route.pathComponents) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        //if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
        
        NSRange range = [pathComponent rangeOfString:@"?"];
        if (range.location != NSNotFound) {
            if (range.location > 0) {
                [pathComponents addObject:[pathComponent substringToIndex:range.location]];
            }
            break;
        }
        [pathComponents addObject:pathComponent];
    }
    return [pathComponents copy];
}


-(NSMutableDictionary *)routes
{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)targetRoutes
{
    if (!_targetRoutes) {
        _targetRoutes = [[NSMutableDictionary alloc] init];
    }
    return _targetRoutes;
}

@end
