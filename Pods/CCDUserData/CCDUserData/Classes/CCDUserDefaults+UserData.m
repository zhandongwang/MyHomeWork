//
//  CCDUserDefaults+UserData.m
//  CCDUserData
//
//  Created by qingye on 2018/9/5.
//

#import "CCDUserDefaults+UserData.h"
#import "CCDUserManager.h"
#import "CCDUserModel.h"
@implementation CCDUserDefaults (UserData)

+ (void)initialize {
    [CCDUserDefaults sharedInstance].userId = ^NSString *{
        return [CCDUserManager sharedInstance].userInfo.userId;
    };
}

@end
