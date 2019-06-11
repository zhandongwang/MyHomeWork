//
//  OOMDataManager.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/14.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "OOMDataManager.h"


@interface OOMDataManager ()

@end


@implementation OOMDataManager

+ (instancetype)getInstance
{
    static OOMDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [OOMDataManager new];
    });
    return manager;
}

-(void)performanceData:(NSDictionary *)data completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(YES);
}

//- (void)fileData:(NSData *)data extra:(NSDictionary<NSString *,NSString *> *)extra type:(QQStackReportType)type completionHandler:(void (^)(BOOL))completionHandler
//{
//    if (type == QQStackReportTypeOOMLog) {
//        // 此处为了Demo演示需要传参数NO，NO表示我们自己业务对data处理尚未完成或者失败，OOMDetector内部暂时不会删除临时文件
//        completionHandler(NO);
//    } else {
//        completionHandler(YES);
//    }
//}
@end
