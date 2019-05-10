//
//  FLDataService.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <coobjc/coobjc.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLDataService : NSObject

+ (instancetype)sharedInstance;

- (id)requestJSONWithURL:(NSString *)url CO_ASYNC;

- (UIImage*)imageWithURL:(NSString*)url CO_ASYNC;

@end

NS_ASSUME_NONNULL_END
