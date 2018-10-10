//
//  AliPayResultUtil.m
//  RestApp
//
//  Created by zxh on 14-11-21.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "AliPayResultUtil.h"

//网盘充值.
#define PAYTYPE_CLOUD @"1"

//短信充值.
#define PAYTYPE_SMS NSLocalizedString(@"短信营销", nil)
//视频栏位
#define VIDEO_FEILD NSLocalizedString(@"视频栏位", nil)
//影鹿订单
#define SHADOWDEER_ORDER NSLocalizedString(@"影鹿视频", nil)
//企业外卖保证金
#define COMPANY_TAKEOUT_CASH_DEPOSIT @"企业外卖保证金"

#define Notification_Sms_Pay_Finish @"Notification_Sms_Pay_Finish"
@implementation AliPayResultUtil

+ (void)payFinish:(NSDictionary*)resultDic
{
    NSString* status=[resultDic objectForKey:@"resultStatus"];
    NSString* memo=[resultDic objectForKey:@"memo"];
    if ([status isEqualToString:@"9000"]) {
        NSString* reulst=[resultDic objectForKey:@"result"];
        NSMutableDictionary* dic=[AliPayResultUtil convertDic:reulst];
        NSString* subject=[dic objectForKey:@"subject"];
        if ([subject isEqualToString:PAYTYPE_SMS]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Sms_Pay_Finish object:dic] ;
        } else if ([subject  isEqualToString:VIDEO_FEILD]){
            [[NSNotificationCenter  defaultCenter] postNotificationName:Notification_Video_Feild_Finish object:dic];
        }  else if ([subject  isEqualToString:SHADOWDEER_ORDER]){
            [[NSNotificationCenter  defaultCenter] postNotificationName:Notification_ShadowDeer_Order_Finish object:dic];
        }else if ([subject isEqualToString:COMPANY_TAKEOUT_CASH_DEPOSIT]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_Company_Takeout_Cash_Deposit" object:dic];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"moduleCharge" object:dic];
        }
    } else if ([status isEqualToString:@"6001"]) {
        [[AliPayResultUtil alloc ] showAlertViewWithMessage:NSLocalizedString(@"本次支付已取消。", nil)];
    } else {
         [[AliPayResultUtil alloc ] showAlertViewWithMessage:memo];
    }
}

+ (NSString *)authLoginFinish:(NSDictionary*)resultDic
{
    NSString* status=[resultDic objectForKey:@"resultStatus"];
    if ([status isEqualToString:@"9000"]) {
        //成功
        // 解析 auth code
        NSString *result = resultDic[@"result"];
        NSString *authCode = nil;
        if (result.length>0) {
            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
            for (NSString *subResult in resultArr) {
                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                    authCode = [subResult substringFromIndex:10];
                    break;
                }
            }
        }
        return authCode;
    } else if ([status isEqualToString:@"6001"]) {
        [[AliPayResultUtil alloc ] showAlertViewWithMessage:NSLocalizedString(@"用户中途取消", nil)];
        return nil;
    } else if ([status isEqualToString:@"6002"]){
        [[AliPayResultUtil alloc ] showAlertViewWithMessage:NSLocalizedString(@"网络连接出错", nil)];
        return nil;
    } else if ([status isEqualToString:@"4000"]){
        [[AliPayResultUtil alloc ] showAlertViewWithMessage:NSLocalizedString(@"系统异常", nil)];
        return nil;
    }
    return nil;
}

- (void) showAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"我知道了", nil) otherButtonTitles:nil];
    [alert show];
}

 //生成key;
+ (NSMutableDictionary*)convertDic:(NSString*)source
{
    source=[source stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray* sources = [source componentsSeparatedByString: @"&"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSArray* pairs;
    if (sources!=nil && sources.count>0) {
        for (NSString* str in sources) {
            pairs=[str componentsSeparatedByString: @"="];
            [dic setObject:[pairs objectAtIndex:1] forKey:[pairs objectAtIndex:0]];
        }
    }
    
    
    return dic;
}
@end
