//
//  UIImageView+FLWebCache.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/10.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <coobjc/coobjc.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (FLWebCache)
- (void)setImageWithPicURL:(NSString*)url CO_ASYNC;

@end

NS_ASSUME_NONNULL_END
