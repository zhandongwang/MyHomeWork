//
//  NSObject+tdf_observer.m
//  napos
//
//  Created by neoman on 7/5/14.
//  Copyright (c) 2014 Rajax Network Technology Co., Ltd. All rights reserved.
//

@implementation NSObject (TDFObserver)

- (void)tdf_observe:(NSString *)notificationName action:(SEL)aSelector {
  [self tdf_observe:notificationName action:aSelector object:nil];
}

- (void)tdf_observe:(NSString *)notificationName action:(SEL)aSelector object:(id)obj {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:notificationName object:obj];
}

- (void)tdf_stopObserve:(NSString *)notificationName {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}

- (void)tdf_stopObserveAll {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tdf_postNotification:(NSString *)notificationName {
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

- (void)tdf_postNotification:(NSString *)notificationName object:(id)obj {
  NSNotification *notif = [[NSNotification alloc] initWithName:notificationName
                                                        object:obj
                                                      userInfo:nil];
  [[NSNotificationCenter defaultCenter] postNotification:notif];
}

- (void)tdf_postNotification:(NSString *)notificationName object:(id)obj userInfo:(NSDictionary *)userInfo {
    NSNotification *notif = [[NSNotification alloc] initWithName:notificationName
                                                          object:obj
                                                        userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notif];
}

@end
