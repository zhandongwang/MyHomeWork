//
//  HBWebInputModel.m
//  weather
//
//  Created by CaydenK on 2017/2/18.
//  Copyright © 2017年 CaydenK. All rights reserved.
//

#import "HBWebInputModel.h"
#import "UIAlertView+HBExtend.h"
#import "HBWebEngine.h"
#import "NSBundle+HBHybridKit.h"

@implementation HBWebInputModel

- (BOOL)openURLPauseCondition:(BOOL (^)(BOOL))completion {
    if (self.url == nil) {
        NSString *invalidUrl = [HBWebEngine scanPrompt][@"invalidUrlPrompt"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSBundle hb_localizedStringForKey:@"Warn"] message:invalidUrl ?: [NSBundle hb_localizedStringForKey:@"CannotAccess"] delegate:nil cancelButtonTitle:[NSBundle hb_localizedStringForKey:@"OK"] otherButtonTitles:nil];
        [alert show];

        return completion(NO);
    }
    
    NSURL *url = [NSURL URLWithString:self.url];
    HBWebEngineURLType type = [HBWebEngine typeOfURL:url];
    
    switch (type) {
        case HBWebEngineURLTypeBlack:
        {
            NSString *blackListString = [HBWebEngine scanPrompt][@"blackListPrompt"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSBundle hb_localizedStringForKey:@"Warn"] message:blackListString ?: [NSBundle hb_localizedStringForKey:@"BlockingAccess"] delegate:nil cancelButtonTitle:[NSBundle hb_localizedStringForKey:@"OK"] otherButtonTitles:nil];
            [alert show];

            return completion(NO);
        }
            break;
        case HBWebEngineURLTypeWhite:
        case HBWebEngineURLTypeLichKing:
        case HBWebEngineURLTypeLocal:
        case HBWebEngineURLTypeSpecifie:
        {
            return completion(YES);
        }
            break;
        case HBWebEngineURLTypeNormal:
        {
            //以上三种都不是，则为普通地址，弹框后打开
            NSString *normalUrlString = [HBWebEngine scanPrompt][@"otherUrlPrompt"];
            [UIAlertView hb_showAlertViewWithTitle:[NSBundle hb_localizedStringForKey:@"Hint"]
                                           message:normalUrlString ?: [NSBundle hb_localizedStringForKey:@"AreYouSureToOpenThisWebPage"]
                                 cancelButtonTitle:[NSBundle hb_localizedStringForKey:@"NotOpen"]
                                 otherButtonTitles:@[[NSBundle hb_localizedStringForKey:@"Open"]]
                                           handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                completion(buttonIndex != 0);
                                           }];
            //可以打开，是否打开由用户决定，所以返回 YES
            return YES;
        }
            break;
            //switch 不加default
    }
    
    return completion(NO);
}

@end
