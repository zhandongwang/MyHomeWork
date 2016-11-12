//
//  MyPageNavigator.h
//  MyHomeWork
//
//  Created by 王战东 on 2016/11/9.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPageNavigator : NSObject

+ (instancetype)navigator;//不建议使用 swift不支持
+ (instancetype)instance;
- (BOOL)pushViewControllerByUrl:(NSString *)url animated:(BOOL)animate;
@end
