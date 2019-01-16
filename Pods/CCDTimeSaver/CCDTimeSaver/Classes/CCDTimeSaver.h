
//
//  CCDTimeSaver.h
//  Pods
//
//  Created by 凤梨 on 18/5/18.
//
//

#import <Foundation/Foundation.h>

@protocol CCDTimeSaverDelegate <NSObject>

- (void)mainThreadSlowWorkDetected:(NSArray*)callStack;

@end

@interface CCDTimeSaver : NSObject

@property (nonatomic, weak) id<CCDTimeSaverDelegate>  detectorDelegate;

+ (instancetype)sharedInstance;

/**
 开始检测
 @param delegate 代理
 @param frameRate 预设的帧率
 */
- (void)startWorkWithDelegate:(id<CCDTimeSaverDelegate>)delegate frameRate:(NSInteger)frameRate;

- (void)startPing;

@end
