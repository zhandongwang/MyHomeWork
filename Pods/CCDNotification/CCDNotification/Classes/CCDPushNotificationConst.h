//
//  CCDPushNotificationConst.h
//  Pods
//
//  Created by 凤梨 on 2017/6/20.
//
//

#import <Foundation/Foundation.h>
//打印消息：账已结清打印消息
extern NSInteger const kCCDRemoteNotificationTypePayCompletion;
//服务铃
extern NSInteger const kCCDRemoteNotificationTypeServiceBell;
//支付消息::xx支付多少元,未/已付清
extern NSInteger const kCCDRemoteNotificationTypePay;
//加菜消息(非预付款的下单消息),扫单加菜
extern NSInteger const kCCDRemoteNotificationTypeAddFoodScanOrder;
//点菜消息(非预付款的下单消息)，扫码点菜
extern NSInteger const kCCDRemoteNotificationTypeAddFoodScanDesk;
//手动审核
extern NSInteger const kCCDRemoteNotificationTypeManualCheck;
//桌位变动[火收银/云收银/服务生]
extern NSInteger const kCCDRemoteNotificationTypeSeatChange;
//第三方外卖
extern NSInteger const kCCDRemoteNotificationTypeThirdDelivery;
//小二外卖
extern NSInteger const kCCDRemoteNotificationTypeFireDelivery;
//云收银催单
extern NSInteger const kCCDRemoteNotificationTypeRemindDelivery;
//云收银开单
extern NSInteger const kCCDRemoteNotificationTypeOpenOrder;
//云收银加菜
extern NSInteger const kCCDRemoteNotificationTypeAddFood;
//云收银修改菜信息
extern NSInteger const kCCDRemoteNotificationTypeModifyFood;
//云收银修改订单信息
extern NSInteger const kCCDRemoteNotificationTypeModifyOrder;
//云收银并单
extern NSInteger const kCCDRemoteNotificationTypeCombineOrder;
//云收银结账完毕
extern NSInteger const kCCDRemoteNotificationTypeCompleteOrder;
//云收银撤单
extern NSInteger const kCCDRemoteNotificationTypeCancelOrder;
//云收银拒绝订单
extern NSInteger const kCCDRemoteNotificationTypeRejectOrder;
//云收银反结账
extern NSInteger const kCCDRemoteNotificationTypeRevCheckOut;
//自动审核的扫码点菜:扫码下单，｛数量｝个菜
extern NSInteger const kCCDRemoteNotificationTypeAutoCheckPrePay;
//自动审核的扫码加菜:扫码下单，｛数量｝个菜
extern NSInteger const kCCDRemoteNotificationTypeAutoCheck;
//云收银退菜
extern NSInteger const kCCDRemoteNotificationTypeBackFood;
//云收银暂不上菜(菜)
extern NSInteger const kCCDRemoteNotificationTypeDelayFood;
//云收银呼叫取餐
extern NSInteger const kCCDRemoteNotificationTypeTakeFood;
//云收银暂不上菜(订单)
extern NSInteger const kCCDRemoteNotificationTypeDelayOrder;
//云收银桌位修改
extern NSInteger const kCCDRemoteNotificationTypeModifySeat;
//预付款开单、加菜
extern NSInteger const kCCDRemoteNotificationTypePrePayAddFood;
//云收银预付款支付消息:扫码下单，｛数量｝个菜，已支付{支付金额}元，是否付清。
extern NSInteger const kCCDRemoteNotificationTypePrePayScanDesk;
//自动审核打印消息
extern NSInteger const kCCDRemoteNotificationTypeAutoCheckPrint;
//零售线上订单消息
extern NSInteger const kCCDRemoteNotificationTypeOrderDelivery;
//云收银外卖配送更新
extern NSInteger const kCCDRemoteNotificationTypeUpdateDelivery;
//云收银取消外卖通知消息
extern NSInteger const kCCDRemoteNotificationTypeCancelDelivery;
//打印消息：推送所有用户
extern NSInteger const kCCDRemoteNotificationTypeAutoCheckPrintAll;
//打印消息：厨打失败
extern NSInteger const kCCDRemoteNotificationTypeKitchenPrintException;
//打印消息：打印机故障消息消息
extern NSInteger const kCCDRemoteNotificationTypeKitchenPrintMalfunction;
//打印消息：KDS状态变更消息
extern NSInteger const kCCDRemoteNotificationTypePrintKDSStatusChange;
//打印消息：打印机恢复正常消息
extern NSInteger const kCCDRemoteNotificationTypeKitchenPrintPrintOK;
//同桌加入点菜
extern NSInteger const kCCDRemoteNotificationTypePartenerJoin;
//购物车提交
extern NSInteger const kCCDRemoteNotificationTypeCommitCart;
//绑定银行卡成功消息
extern NSInteger const kCCDRemoteNotificationTypeBindBankCardSuccess;
//试用店激活成功消息
extern NSInteger const kCCDRemoteNotificationTypeShopActivateSuccess;

extern NSString * const kCCDPushMessageType;
extern NSString * const kCCDPushMessageTitle;
extern NSString * const kCCDPushMessageContentDict;

@interface CCDPushNotificationConst : NSObject

@end
