//
//  FLProxy.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLProxy : NSProxy {
    id _objct;
}

+ (id)proxyForObject:(id)obj;

@end
