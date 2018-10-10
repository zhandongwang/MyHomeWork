//
//  ColorHelper.m
//  RestApp
//
//  Created by zxh on 14-7-3.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

#pragma #999999
+(UIColor*) getTipColor9
{
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
}


#pragma #333333
+(UIColor*) getTipColor3
{
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
}

#pragma #666666
+(UIColor*) getTipColor6
{
    return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
}

#pragma #cc0000
+(UIColor*) getRedColor
{
    return [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
}

#pragma #0088cc
+(UIColor*) getBlueColor
{
    return [UIColor colorWithRed:0/255.0 green:136/255.0 blue:204/255.0 alpha:1];

}

#pragma 绿色.
+(UIColor*) getGreenColor
{
    return [UIColor colorWithRed:0 green:170/255.0 blue:34/255.0 alpha:1];
}

#pragma 登录占位文字.
+(UIColor*) getPlaceholderColor
{
    return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
}

#pragma 黑色.
+(UIColor*) getBlackColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
}

@end
