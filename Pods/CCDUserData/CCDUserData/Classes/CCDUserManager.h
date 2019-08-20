//
//  CCDUserData.h
//  Pods
//
//  Created by 凤梨 on 17/2/15.
//
//

#import <Foundation/Foundation.h>

@class CCDUserModel;

@protocol CCDUserManagerDelegate <NSObject>
- (void)userDidLogout;
@end

@interface CCDUserManager : NSObject

/**
 对外只读，统一通过logInWithInfo方法来修改
 */
@property(nonatomic, readonly) CCDUserModel *userInfo;
@property(nonatomic, weak) id <CCDUserManagerDelegate> delegate;

/**
 登录后获得,除登陆接口外其他接口需要带上这个参数
 */
@property(nonatomic, readonly) NSString *token;
/**
 获取entityId后,请求其他接口需要带上这个参数
 */
@property(nonatomic, readonly) NSString *entityId;

@property(nonatomic, readonly) BOOL userLoggedIn;

@property (nonatomic, copy) NSString *xingeClientID;

@property (nonatomic, copy) NSString *xingeDeviceToken;

+ (instancetype)sharedInstance;

- (void)logInWithInfo:(CCDUserModel *)userInfo;

- (void)logout;

@end
