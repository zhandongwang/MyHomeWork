//
//  FLConst.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kFLNetworkHost;
extern NSString * const kFLNetworkApikey;
extern NSString * const kFLNetworkThumbnailPosterImageUrl;
extern NSString * const kFLNetworkOriginalPosterImageUrl;

/*** MD5 ***/

#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
#define CC_MD5_BLOCK_BYTES      64          /* block size in bytes */
#define CC_MD5_BLOCK_LONG       (CC_MD5_BLOCK_BYTES / sizeof(CC_LONG))


@interface FLConst : NSObject


@end

NS_ASSUME_NONNULL_END
