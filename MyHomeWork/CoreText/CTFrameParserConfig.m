//
//  CTFrameParserConfig.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "CTFrameParserConfig.h"

#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@implementation CTFrameParserConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _width = 200.f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor =  RGB(108, 108, 108);
    }
    return self;
}
@end
