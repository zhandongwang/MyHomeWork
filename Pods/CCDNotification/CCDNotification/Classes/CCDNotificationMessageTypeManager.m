//
//  CCDNotificationMessageTypeManager.m
//  CCDNotification
//
//  Created by loop安 on 2018/9/20.
//

#import "CCDNotificationMessageTypeManager.h"

@implementation CCDNotificationMessageTypeManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static CCDNotificationMessageTypeManager *_manager;
    dispatch_once(&onceToken, ^{
        _manager = [[CCDNotificationMessageTypeManager alloc] init];
    });
    return _manager;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL)messageType:(CCDMessageType)messageType isContainedInMessageList:(NSArray *)messageList{
    return [messageList containsObject:@(messageType)];
}

+ (NSArray *)fetchAllMessageTypeList{
    return @[
             @(CCDMessageTypeServiceBell),
             @(CCDMessageTypeServicePay),
             @(CCDMessageTypeServiceScanAddDish),
             @(CCDMessageTypeServiceScanDesk),
             @(CCDMessageTypeServiceAutoCheckScanDesk),
             @(CCDMessageTypeServiceAutoCheckAddDish),
             @(CCDMessageTypeServicePrePayScanDesk),
             @(CCDMessageTypeServiceOrderDelivery),
             @(CCDMessageTypeServiceThirdDelivery),
             @(CCDMessageTypeServiceFireDelivery),
             @(CCDMessageTypeServiceCancelDelivery),
             @(CCDMessageTypeServiceUpdateDelivery),
             @(CCDMessageTypeServiceRemindDelivery),
             @(CCDMessageTypeServiceManualCheck),
             @(CCDMessageTypeServicePrintException),
             @(CCDMessageTypeServicePrintMalfunction),
             @(CCDMessageTypeServiceRefundApply),
             @(CCDMessageTypeServiceRefundRepeal)
             ];
}

+ (NSArray *)fetchFoodMessageTypeList{
    return @[
             @(CCDMessageTypeServiceBell),
             @(CCDMessageTypeServicePay),
             @(CCDMessageTypeServiceScanAddDish),
             @(CCDMessageTypeServiceScanDesk),
             @(CCDMessageTypeServiceAutoCheckScanDesk),
             @(CCDMessageTypeServiceAutoCheckAddDish),
             @(CCDMessageTypeServicePrePayScanDesk),
             @(CCDMessageTypeServiceOrderDelivery),
             @(CCDMessageTypeServiceThirdDelivery),
             @(CCDMessageTypeServiceFireDelivery),
             @(CCDMessageTypeServiceCancelDelivery),
             @(CCDMessageTypeServiceUpdateDelivery),
             @(CCDMessageTypeServiceRemindDelivery),
             @(CCDMessageTypeServiceManualCheck),
             @(CCDMessageTypeServicePrintException),
             @(CCDMessageTypeServicePrintMalfunction)
             ];
}

+ (NSArray *)fetchPendingMessageTypeList{
    return @[
             @(CCDMessageTypeServiceScanAddDish),
             @(CCDMessageTypeServiceScanDesk),
             @(CCDMessageTypeServiceManualCheck),
             @(CCDMessageTypeServiceThirdDelivery),
             @(CCDMessageTypeServiceFireDelivery)
             ];
}

+ (NSArray *)fetchPayMessageTypeList{
    return @[
             @(CCDMessageTypeServicePay),
             @(CCDMessageTypeServicePrePayScanDesk),
             ];
}

+ (NSArray *)fetchBellMessageTypeList{
    return @[
             @(CCDMessageTypeServiceBell)
             ];
}

+ (NSArray *)fetchOrderMessageTypeList{
    return @[
             @(CCDMessageTypeServiceScanDesk),
             @(CCDMessageTypeServiceScanAddDish),
             @(CCDMessageTypeServiceManualCheck),
             @(CCDMessageTypeServiceAutoCheckAddDish),
             @(CCDMessageTypeServiceAutoCheckScanDesk)
             ];
}

+ (NSArray *)fetchDeliveryMessageTypeList{
    return @[
             @(CCDMessageTypeServiceFireDelivery),
             @(CCDMessageTypeServiceThirdDelivery),
             @(CCDMessageTypeServiceOrderDelivery),
             @(CCDMessageTypeServiceRemindDelivery),
             @(CCDMessageTypeServiceCancelDelivery),
             @(CCDMessageTypeServiceUpdateDelivery),
             @(CCDMessageTypeServiceRefundApply),
             @(CCDMessageTypeServiceRefundRepeal)
             ];
}


@end
