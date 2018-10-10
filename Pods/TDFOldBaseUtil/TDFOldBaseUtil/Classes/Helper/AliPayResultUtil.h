//
//  AliPayResultUtil.h
//  RestApp
//
//  Created by zxh on 14-11-21.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Notification_Video_Feild_Finish @"NOtification_Video_Feild_Finish"
#define Notification_ShadowDeer_Order_Finish @"NOtification_ShadowDeer_Order_Finish"
@interface AliPayResultUtil : NSObject


//Alipay支付完成.
+ (void)payFinish:(NSDictionary*)resultDic;
//Alipay返回结果解析;
+ (NSMutableDictionary*)convertDic:(NSString*)source;

+ (NSString *)authLoginFinish:(NSDictionary*)resultDic;
@end
