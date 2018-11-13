//
//  WZDBaseViewController.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/28.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FLBaseViewControllerProtocol<NSObject>

- (void)sendRequest;

@end

@protocol  FLBaseViewControllerInterceptorProtocol<NSObject>

- (void)willRun;
- (void)didRun;

@end


@interface WZDBaseViewController : UIViewController

@property (nonatomic, weak) id <FLBaseViewControllerProtocol> child;
@property (nonatomic, weak) id <FLBaseViewControllerInterceptorProtocol> interceptor;

@end
