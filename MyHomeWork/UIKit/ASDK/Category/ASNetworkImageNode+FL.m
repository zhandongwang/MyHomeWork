//
//  ASNetworkImageNode+FL.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "ASNetworkImageNode+FL.h"

@implementation ASNetworkImageNode (FL)

+ (ASNetworkImageNode *)createWithURLStr:(NSString *)urlStr {
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.URL = [NSURL URLWithString:urlStr];
    imageNode.clipsToBounds = YES;
    imageNode.clipsToBounds = YES;
    imageNode.placeholderFadeDuration = 0.2;
    imageNode.placeholderEnabled = YES;
    imageNode.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageNode;
}

-(asimagenode_modification_block_t)imageModBlockWithCorner:(CGFloat)corner {
    return [self imageModBlockWithCorner:8 maskImage:nil];
}


-(asimagenode_modification_block_t)imageModBlockWithCorner:(CGFloat)corner  maskImage:(UIImage *)maskImage {
    __weak __typeof(self)weakSelf = self;
    return ^UIImage* (UIImage *originalImg) {
        CGSize size = CGSizeMake(weakSelf.calculatedSize.width * [UIScreen mainScreen].scale, weakSelf.calculatedSize.height * [UIScreen mainScreen].scale);
        UIGraphicsBeginImageContext(size);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:corner*[UIScreen mainScreen].scale];
        [path addClip];
        [originalImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
        if (maskImage) {
            [maskImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        }
        UIImage * refinedImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return refinedImg;
    };
}


@end
