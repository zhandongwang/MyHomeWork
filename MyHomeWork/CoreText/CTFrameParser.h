//
//  CTFrameParser.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParser : NSObject
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;
+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

+(CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config;

@end

NS_ASSUME_NONNULL_END
