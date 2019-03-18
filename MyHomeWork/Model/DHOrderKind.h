//
//  DHOrderKind.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DHOrderModel;

@interface DHOrderKind : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray <DHOrderModel *> *orders;
@property (nonatomic, assign) BOOL isOld;

- (void)changeTitle:(NSString *)str;
- (void)changeOld:(BOOL)status;
@end
