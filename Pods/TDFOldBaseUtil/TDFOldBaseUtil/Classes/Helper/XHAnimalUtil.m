//
//  XHAnimalUtil.m
//  RestApp
//
//  Created by zxh on 14-6-6.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "XHAnimalUtil.h"
#import "UIView+Sizes.h"
#import "GlobeConstants.h"
@implementation XHAnimalUtil

+ (void)animal:(UIViewController*)controller type:(NSString*)type direct:(NSString*)direct
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    if (direct == kCATransitionFromLeft) {
        transition.duration = 0.2;
    }
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = type;
    transition.subtype = direct;
    
    transition.delegate = controller;
    [controller.view.layer addAnimation:transition forKey:nil];
    
    NSInteger count = controller.view.subviews.count;
    if (count > 2) {
        [controller.view exchangeSubviewAtIndex:count - 1 withSubviewAtIndex: count - 2];
    }
}

+ (void)animalEdit:(UIViewController*) controller action:(NSInteger)action
{
    if (action==ACTION_CONSTANTS_ADD) {
        [XHAnimalUtil animal:controller type:kCATransitionPush direct:kCATransitionFromBottom];
    } else {
        [XHAnimalUtil animal:controller type:kCATransitionPush direct:kCATransitionFromLeft];
    }
}

+ (void)animationMoveUp:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.4];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationMoveDown:(UIView *)view
{
    CATransition *transition = [CATransition animation];
    transition.duration =0.4;
    transition.timingFunction = [CAMediaTimingFunction
                                 
                                 functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:transition forKey:nil];
}

+ (void)animationMoveIn:(UIView *)view backround:(UIView *)background
{
    background.hidden = NO;
    [UIView beginAnimations:@"view moveIn" context:nil];
    [UIView setAnimationDuration:0.2];
    view.frame = CGRectMake(SCREEN_WIDTH, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    view.frame = CGRectMake(SCREEN_WIDTH - view.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    view.alpha = 0.5;
    view.alpha = 1.0;
    background.alpha = 0.0;
    background.alpha = 1;
    [UIView commitAnimations];
    
}

+ (void)animationMoveOut:(UIView *)view backround:(UIView *)background
{
    [UIView beginAnimations:@"view moveOut" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2];
    view.frame = CGRectMake(SCREEN_WIDTH - view.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    view.frame = CGRectMake(SCREEN_WIDTH, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    view.alpha = 1.0;
    view.alpha = 0.5;
    background.alpha = 1;
    background.alpha = 0.0;
    [UIView commitAnimations];
    background.hidden = YES;
}

@end

