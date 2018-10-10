//
//  INavigateEvent.h
//  RestApp
//
//  Created by zxh on 14-3-22.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol INavigateEvent <NSObject>

@optional
-(void) onNavigateEvent:(NSInteger)event;

@end
