//
//  FLMsgModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/2/21.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLMsgModel : NSObject

@property (nonatomic, copy) NSString *senderName;
@property (nonatomic, copy) NSString *receiverName;
@property (nonatomic, assign) NSUInteger senderID;
@property (nonatomic, assign) NSUInteger receiverID;
@property (nonatomic, strong) NSDate *sendTime;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSURL *avartarUrl;

@end

NS_ASSUME_NONNULL_END
