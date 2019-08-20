//
//  ASNetworkImageNode+FL.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASNetworkImageNode (FL)

+ (ASNetworkImageNode *)createWithURLStr:(NSString *)urlStr;

-(asimagenode_modification_block_t)imageModBlockWithCorner:(CGFloat)corner;

-(asimagenode_modification_block_t)imageModBlockWithCorner:(CGFloat)corner  maskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
