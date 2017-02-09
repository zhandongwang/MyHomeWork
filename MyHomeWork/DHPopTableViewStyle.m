//
//  DHPopTableViewStyle.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHPopTableViewStyle.h"

@implementation DHPopTableViewStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bgAlpha = 0.7;
        _tableViewAlpha = 1.0;
        _tableViewRowHeight = 40;
        _sectionHeaderHeight = 40;
        _cellTextLableFontSize = 14.0;
    }
    return self;
}


@end
