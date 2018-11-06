//
//  WebPlugin.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/6.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OCTWebViewBridge/OCTWebViewBridge.h>

@interface WebPlugin : NSObject <OCTWebViewPlugin>

@property (copy, nonatomic, readonly) NSString *identifier;
@property (copy, nonatomic, readonly) NSString *javascriptCode;


@end
