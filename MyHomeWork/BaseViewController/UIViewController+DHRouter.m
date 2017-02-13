//
//  UIViewController+DHRouter.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/13.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "UIViewController+DHRouter.h"

@implementation UIViewController (DHRouter)

- (NSDictionary *)routerParams {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRouterParams:(NSDictionary *)paramsDictionary {
    objc_setAssociatedObject(self, @selector(routerParams), paramsDictionary, OBJC_ASSOCIATION_COPY);
}


@end
