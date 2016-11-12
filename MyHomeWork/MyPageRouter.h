//
//  MyPageRouter.h
//  MyHomeWork
//
//  Created by 王战东 on 2016/11/9.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPageRouter : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString *,NSMutableArray *> *targetRoutes;

+ (instancetype)router;

+ (void)enableScheme:(BOOL)enable;

- (void)registerUrl:(NSString *)route toControllerClass:(Class)controllerClass;

- (UIViewController *)matchControllerUrl:(NSString *)route;

@end


@interface UIViewController (PageRouter)

@property (nonatomic, strong, readonly) NSDictionary *params;

// TODO: maybe we need a validate params or mapping params method
- (BOOL)validateParams:(NSDictionary *)params;

@end
