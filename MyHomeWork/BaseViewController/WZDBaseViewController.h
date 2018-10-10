//
//  WZDBaseViewController.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/28.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  WZDBaseViewControllerProtocol<NSObject>

- (void)sendRequest;

@end

@protocol  WZDBaseViewControllerInterceptorProtocol<NSObject>

- (void)willRun;
- (void)didRun;

@end


@interface WZDBaseViewController : UIViewController

@property (nonatomic, weak) id <WZDBaseViewControllerProtocol> child;
@property (nonatomic, weak) id <WZDBaseViewControllerInterceptorProtocol> interceptor;

@end
