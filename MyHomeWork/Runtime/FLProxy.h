//
//  FLProxy.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLClothesProvider.h"
#import "FLBookProvider.h"

@interface FLProxy : NSProxy
<FLBookProviderProtocol, FLClothesProviderProtocol>
{
    id _object;
}

+ (instancetype)dealerProxy;
+ (id)proxyForObject:(id)obj;
@end
