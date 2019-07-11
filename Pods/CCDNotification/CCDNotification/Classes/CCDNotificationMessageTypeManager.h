//
//  CCDNotificationMessageTypeManager.h
//  CCDNotification
//
//  Created by loop安 on 2018/9/20.
//

#import <Foundation/Foundation.h>
#import "CCDPushNotificationConst.h"

typedef NS_ENUM (NSInteger, CCDMessageType) {
    CCDMessageTypeServiceBell                    = 111,    //服务铃
    CCDMessageTypeServicePay                     = 141,    //支付消息:xx支付多少元,未/已付清
    CCDMessageTypeServiceScanAddDish             = 101,    //扫码加菜
    CCDMessageTypeServiceManualCheck             = 123,    //手动审核
    CCDMessageTypeServiceScanDesk                = 102,    //扫码点菜
    CCDMessageTypeServiceThirdDelivery           = 401,    //第三方外卖
    CCDMessageTypeServiceFireDelivery            = 501,    //小二外卖
    CCDMessageTypeServiceRemindDelivery          = 1052,   //催单
    CCDMessageTypeServiceAutoCheckScanDesk       = 1210,   //自动审核情况下 扫码点菜
    CCDMessageTypeServiceAutoCheckAddDish        = 1211,   //自动审核情况下，扫码加菜
    CCDMessageTypeServicePrePayScanDesk          = 1221,   //扫码点菜,云收银预付款支付消息，收到的通知消息:扫码下单，｛数量｝个菜，已支付{支付金额}元，是否付清。
    CCDMessageTypeServiceOrderDelivery           = 1229,   //自动审核情况下，外卖订单
    CCDMessageTypeServiceUpdateDelivery          = 1231,   //配送更新
    CCDMessageTypeServiceCancelDelivery          = 1235,   //取消外卖通知消息
    CCDMessageTypeServicePrintException          = 1237,   //厨打失败
    CCDMessageTypeServicePrintMalfunction        = 1238,   //打印机故障消息消息
    CCDMessageTypeServicePrintKDSStatusChange    = 1239,   //KDS状态变更消息
    CCDMessageTypeServicePrintPrintOK            = 1240,   //打印机恢复正常消息
    CCDMessageTypeServiceRefundApply             = 1245,   //退款申请
    CCDMessageTypeServiceRefundRepeal            = 1247,   //退款撤销
};

@interface CCDNotificationMessageTypeManager : NSObject
+ (instancetype)sharedInstance;
//判断消息类型是否包含于数组中
- (BOOL)messageType:(CCDMessageType)messageType isContainedInMessageList:(NSArray *)messageList;
//返回消息中心支持的所有消息类型
+ (NSArray *)fetchAllMessageTypeList;
//返回消息中心支持的所有餐饮类消息类型
+ (NSArray *)fetchFoodMessageTypeList;
//返回消息中心需要手动审核的消息类型
+ (NSArray *)fetchPendingMessageTypeList;
//返回所有支付的消息类型
+ (NSArray *)fetchPayMessageTypeList;
//返回所有下单的消息类型
+ (NSArray *)fetchOrderMessageTypeList;
//返回所有外卖的消息类型
+ (NSArray *)fetchDeliveryMessageTypeList;
@end
