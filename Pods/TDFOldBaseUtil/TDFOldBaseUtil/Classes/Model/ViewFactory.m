//
//  ViewFactory.m
//  CardApp
//
//  Created by 邵建青 on 14-2-19.
//  Copyright (c) 2014年 ZMSOFT. All rights reserved.
//

#import "ViewFactory.h"
#import "SystemUtil.h"

@implementation ViewFactory

+ (UIView *)generateFooter:(CGFloat)height
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];

    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

+(UIView *)customerFooter:(CGFloat)height
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    footer.backgroundColor = [UIColor clearColor];
    UILabel *label =[[UILabel alloc]initWithFrame:footer.frame];
    [footer addSubview:label];
    label.text =NSLocalizedString(@"注：当顾客手机下单，所点的某一类菜肴比建议份数少时，系统会自动提示顾客并随机推荐几个此种标签下的菜肴。提醒和推荐时会显示提醒与推荐语，您可以使用系统统一提供的推荐语，也可以自定义这些推荐语。推荐语最多不能超过16个字", nil);
    label.numberOfLines=0;
    label.textColor =[UIColor lightGrayColor];
    label.font =[UIFont systemFontOfSize:12];
    
    
    return footer;
}
@end
