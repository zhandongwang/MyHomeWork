//
//  ASTextNode+FL.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTextNode (FL)

+ (ASTextNode *)createWithAttr:(NSAttributedString *)attr;
+ (ASTextNode *)createWithAttr:(NSAttributedString *)attr LineCount:(NSInteger)lineCount;
@end

NS_ASSUME_NONNULL_END
