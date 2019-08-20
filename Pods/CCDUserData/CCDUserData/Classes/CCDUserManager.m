//
//  CCDUserData.m
//  Pods
//
//  Created by 凤梨 on 17/2/15.
//
//

#import "CCDUserManager.h"
#import "CCDUserModel.h"
#import "AutoCoding.h"
#import "YYModel.h"
#import "NSString+TDFFoundation.h"
#import <CocoaSecurity/CocoaSecurity.h>
#import <CocoaSecurity/Base64.h>

static NSString *const kLocalUserInfo = @"kCCDLocalUserInfo";
static NSString *const kCCDEncrypyLocalUserInfo = @"kCCDEncrypyLocalUserInfo";
static NSString * kCCDUserInfoKeyChainService = @"kCCDUserInfoKeyChainService";
static NSString * kCCDUserInfoKeyChainAccount = @"kCCDUserInfoKeyChainAccount";
static NSString * kCCDUserEncryptKey = @"YunCash";

@interface CCDUserManager ()

@property(nonatomic, readwrite) CCDUserModel *userInfo;
@property(nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation CCDUserManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _semaphore = dispatch_semaphore_create(1);
        [self restoreUserInfo];
    }
    return self;
}

- (void)logInWithInfo:(CCDUserModel *)userInfo {
    self.userInfo = userInfo;
}


- (void)logout {
    self.userInfo = [[CCDUserModel alloc] init];
    if ([self.delegate respondsToSelector:@selector(userDidLogout)]) {
        [self.delegate userDidLogout];
    }
}
#pragma mark Properties

- (BOOL)userLoggedIn {
    return [self.token tdf_isNotEmpty];
}

- (void)setUserInfo:(CCDUserModel *)userInfo {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    _userInfo = userInfo;
    [self storeUserInfo:userInfo];
    dispatch_semaphore_signal(self.semaphore);
}

- (NSString *)token {
    return self.userInfo.token;
}

- (NSString *)entityId {
    return self.userInfo.entityId;
}

#pragma mark Local Storge

- (void)storeUserInfo:(CCDUserModel *)model {
    CCDUserModel *encryptedModel = [self encryptUserModel:model];
    NSDictionary *userData = [encryptedModel yy_modelToJSONObject];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kCCDEncrypyLocalUserInfo];
    
    //记录店铺对应的语言
    NSString *groupID = [NSString stringWithFormat:@"group.%@",[[NSBundle mainBundle] bundleIdentifier]];
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:groupID];
    NSString *language = model.lang ?: @"zh-CN";
    [sharedDefaults setValue:model.lang forKey:@"language"];
}

- (void)restoreUserInfo {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kLocalUserInfo] != nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLocalUserInfo];//删除老版本的缓存
    }
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kCCDEncrypyLocalUserInfo];
    if (!dictionary) {
        return;
    }
    CCDUserModel *model = [CCDUserModel yy_modelWithDictionary:dictionary];
    self.userInfo = [self decryptUserModel:model];
}

#pragma mark - methods

- (CCDUserModel *)encryptUserModel:(CCDUserModel *)originModel {
    CCDUserModel *encrypedModel = [originModel yy_modelCopy];
    if (originModel.token.length) {
     CocoaSecurityResult *result = [CocoaSecurity aesEncrypt:originModel.token key:kCCDUserEncryptKey];
        encrypedModel.token = result.base64;
    }
    return encrypedModel;
}

- (CCDUserModel *)decryptUserModel:(CCDUserModel *)encryptedModel {
    CCDUserModel *decryptedModel = [encryptedModel yy_modelCopy];
    if (encryptedModel.token.length) {
        CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithBase64:encryptedModel.token key:kCCDUserEncryptKey];
        decryptedModel.token = [result.base64 base64DecodedString];
    }
    return decryptedModel;
}

@end
