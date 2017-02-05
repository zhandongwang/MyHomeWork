//
//  WZDMainViewController.h
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol JSObjcDelegate <NSObject, JSExport>

- (void)callCamera;
- (void)share:(NSString *)shareString;

@end

@interface WZDMainViewController : UIViewController


@end

