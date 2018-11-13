//
//  WZDWebViewController.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/10/30.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import JavaScriptCore;

@protocol JSObjcDelegate <NSObject, JSExport>

- (void)callCamera;
- (void)share:(NSString *)shareString;
- (void)getPreviewContent:(id)data;

@end

@interface FLWebViewController : UIViewController

@end
