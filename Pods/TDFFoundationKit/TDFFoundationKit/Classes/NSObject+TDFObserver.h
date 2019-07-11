//
//  NSObject+tdf_observer.h
//  napos
//
//  Created by neoman on 7/5/14.
//  Copyright (c) 2014 Rajax Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TDFObserver)

- (void)tdf_observe:(NSString *)notificationName action:(SEL)aSelector;

- (void)tdf_observe:(NSString *)notificationName action:(SEL)aSelector object:(id)obj;

- (void)tdf_stopObserve:(NSString *)notificationName;

- (void)tdf_stopObserveAll;

- (void)tdf_postNotification:(NSString *)notificationName;

- (void)tdf_postNotification:(NSString *)notificationName object:(id)obj;

- (void)tdf_postNotification:(NSString *)notificationName object:(id)obj userInfo:(NSDictionary *)userInfo;


@end
