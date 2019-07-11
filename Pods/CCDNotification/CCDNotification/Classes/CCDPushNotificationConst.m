//
//  CCDPushNotificationConst.m
//  Pods
//
//  Created by 凤梨 on 2017/6/20.
//
//

#import "CCDPushNotificationConst.h"
//打印消息：账已结清打印消息
NSInteger const kCCDRemoteNotificationTypePayCompletion = 21;
//服务铃
NSInteger const kCCDRemoteNotificationTypeServiceBell = 111;
//支付消息::xx支付多少元,未/已付清
NSInteger const kCCDRemoteNotificationTypePay = 141;
//加菜消息(非预付款的下单消息),扫单加菜
NSInteger const kCCDRemoteNotificationTypeAddFoodScanOrder = 101;
//点菜消息(非预付款的下单消息)，扫码点菜
NSInteger const kCCDRemoteNotificationTypeAddFoodScanDesk = 102;
//手动审核
NSInteger const kCCDRemoteNotificationTypeManualCheck = 123;
//桌位变动[火收银/云收银/服务生]
NSInteger const kCCDRemoteNotificationTypeSeatChange = 301;
//第三方外卖
NSInteger const kCCDRemoteNotificationTypeThirdDelivery  = 401;
//小二外卖
NSInteger const kCCDRemoteNotificationTypeFireDelivery  = 501;
//云收银催单
NSInteger const kCCDRemoteNotificationTypeRemindDelivery = 1052;
//云收银开单
NSInteger const kCCDRemoteNotificationTypeOpenOrder = 1201;
//云收银加菜
NSInteger const kCCDRemoteNotificationTypeAddFood = 1202;
//云收银修改菜信息
NSInteger const kCCDRemoteNotificationTypeModifyFood = 1203;
//云收银修改订单信息
NSInteger const kCCDRemoteNotificationTypeModifyOrder = 1204;
//云收银并单
NSInteger const kCCDRemoteNotificationTypeCombineOrder = 1205;
//云收银结账完毕
NSInteger const kCCDRemoteNotificationTypeCompleteOrder = 1206;
//云收银撤单
NSInteger const kCCDRemoteNotificationTypeCancelOrder = 1207;
//云收银拒绝订单
NSInteger const kCCDRemoteNotificationTypeRejectOrder = 1208;
//云收银反结账
NSInteger const kCCDRemoteNotificationTypeRevCheckOut = 1209;
//自动审核的扫码点菜:扫码下单，｛数量｝个菜
NSInteger const kCCDRemoteNotificationTypeAutoCheckPrePay = 1210;
//自动审核的扫码加菜:扫码下单，｛数量｝个菜
NSInteger const kCCDRemoteNotificationTypeAutoCheck = 1211;
//云收银退菜
NSInteger const kCCDRemoteNotificationTypeBackFood = 1212;
//云收银暂不上菜(菜)
NSInteger const kCCDRemoteNotificationTypeDelayFood = 1213;
//云收银呼叫取餐
NSInteger const kCCDRemoteNotificationTypeTakeFood = 1214;
//云收银暂不上菜(订单)
NSInteger const kCCDRemoteNotificationTypeDelayOrder = 1215;
//云收银桌位修改
NSInteger const kCCDRemoteNotificationTypeModifySeat = 1216;
//预付款开单、加菜
NSInteger const kCCDRemoteNotificationTypePrePayAddFood = 1217;
//云收银预付款支付消息:扫码下单，｛数量｝个菜，已支付{支付金额}元，是否付清。
NSInteger const kCCDRemoteNotificationTypePrePayScanDesk = 1221;
//自动审核打印消息
NSInteger const kCCDRemoteNotificationTypeAutoCheckPrint = 1226;
//自动审核情况下，外卖订单(零售线上订单消息)
NSInteger const kCCDRemoteNotificationTypeOrderDelivery = 1229;
//云收银外卖配送更新
NSInteger const kCCDRemoteNotificationTypeUpdateDelivery = 1231;
//云收银取消外卖通知消息
NSInteger const kCCDRemoteNotificationTypeCancelDelivery = 1235;
//打印消息：推送所有用户
NSInteger const kCCDRemoteNotificationTypeAutoCheckPrintAll = 1236;
//打印消息：厨打失败
NSInteger const kCCDRemoteNotificationTypeKitchenPrintException = 1237;
//打印消息：打印机故障消息消息
NSInteger const kCCDRemoteNotificationTypeKitchenPrintMalfunction = 1238;
//打印消息：KDS状态变更消息
NSInteger const kCCDRemoteNotificationTypePrintKDSStatusChange = 1239;
//打印消息：打印机恢复正常消息
NSInteger const kCCDRemoteNotificationTypeKitchenPrintPrintOK = 1240;
//同桌加入点菜
NSInteger const kCCDRemoteNotificationTypePartenerJoin = 1301;
//购物车提交
NSInteger const kCCDRemoteNotificationTypeCommitCart = 1302;
//绑定银行卡成功消息
NSInteger const kCCDRemoteNotificationTypeBindBankCardSuccess = 6010;
//试用店激活成功消息
NSInteger const kCCDRemoteNotificationTypeShopActivateSuccess = 1248;


NSString * const kCCDPushMessageType = @"kCCDPushMessageType";
NSString * const kCCDPushMessageTitle = @"kCCDPushMessageContent";
NSString * const kCCDPushMessageContentDict = @"kCCDPushMessageContentDict";

@implementation CCDPushNotificationConst

@end
