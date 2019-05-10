//
//  FLDataService.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLDataService.h"
#import <CommonCrypto/CommonDigest.h>
#import "FLConst.h"

@interface FLDataService ()

@property (nonatomic, strong) dispatch_queue_t jsonQueue;
@property (nonatomic, strong) dispatch_queue_t networkQueue;
@property (nonatomic, strong) dispatch_queue_t cacheQueue;
@property (nonatomic, strong) dispatch_queue_t imageQueue;
@property (nonatomic, strong) COActor *networkActor;
@property (nonatomic, strong) COActor *jsonActor;
@property (nonatomic, strong) COActor *imageActor;
@property (nonatomic, strong) COActor *cacheActor;
@property (nonatomic, strong) NSString *cachePath;


@end


@implementation FLDataService

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _cachePath = [paths [0] stringByAppendingPathComponent:@"FLUIKit"];
        _networkQueue = dispatch_queue_create("com.fl.network", NULL);
        _jsonQueue = dispatch_queue_create("com.fl.json", NULL);
        _cacheQueue = dispatch_queue_create("com.fl.cache", NULL);
        _imageQueue = dispatch_queue_create("com.fl.image", NULL);
        _networkActor = co_actor_onqueue(_networkQueue, ^(COActorChan * _Nonnull channel) {
            for (COActorMessage *message in channel) {
                NSString *url = [message stringType];
                if (url.length) {
                    message.complete(await([self getDataWithURL:url]));
                } else {
                    message.complete(nil);
                }
            }
            
        });
        
        _cacheActor = co_actor_onqueue(_cacheQueue, ^(COActorChan * _Nonnull channel) {
            for (COActorMessage *message in channel) {
                NSDictionary *dict = [message dictType];
                NSString *type = dict[@"type"];
                
                if ([type isEqualToString:@"save"]) {
                    NSString *identifier = dict[@"id"];
                    NSData *data = dict[@"data"];
                    NSString *fileName = [self cachedFileNameForKey:identifier];
                    NSString *filePath = [self cachePathForFileName:fileName];
                    if (fileName.length &&  data.length) {
                        if (![[NSFileManager defaultManager] fileExistsAtPath:self.cachePath]) {
                            [[NSFileManager defaultManager] createDirectoryAtPath:self.cachePath withIntermediateDirectories:NO attributes:nil error:nil];
                        }
                        [data writeToFile:filePath atomically:YES];
                    }
                } else if ([type isEqualToString:@"load"]) {
                    NSString *identifier = dict[@"id"];
                    NSString *fileName = [self cachedFileNameForKey:identifier];
                    NSString *filePath = [self cachePathForFileName:fileName];
                    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
                    message.complete(data);
                    
                } else if ([type isEqualToString:@"clean"]) {
                    NSString *identifier = dict[@"id"];
                    NSString *fileName = [self cachedFileNameForKey:identifier];
                    NSString *filePath = [self cachePathForFileName:fileName];
                    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                } else if ([type isEqualToString:@"clean_all"]) {
                    [[NSFileManager defaultManager] removeItemAtPath:self.cachePath error:nil];
                     [[NSFileManager defaultManager] createDirectoryAtPath:self.cachePath withIntermediateDirectories:NO attributes:nil error:nil];
                }
            }
        });
        
        _imageActor =  co_actor_onqueue(_imageQueue, ^(COActorChan * _Nonnull channel) {
            NSData *data = nil;
            UIImage *image = nil;
            COActorCompletable *completable = nil;
            NSCache *memoryCache = [[NSCache alloc] init];
            memoryCache.countLimit = 50;
            for (COActorMessage *message in channel) {
                image = nil;
                NSString *url = [message stringType];
                if (url.length) {
                    image = [memoryCache objectForKey:url];
                    if (image) {
                        message.complete(image);
                        continue;
                    }
                    data = [self getDataWithIdentifier:url];
                    if (data) {
                        image = [[UIImage alloc] initWithData:data];
                        message.complete(image);
                    } else {
                        completable = [self.networkActor sendMessage:url];
                        data = await(completable);
                        if (data) {
                            image = [[UIImage alloc] initWithData:data];
                            message.complete(image);
                            [self saveDataToCache:data withIdentifier:url];
                        }
                    }
                    if (image) {
                        [memoryCache setObject:image forKey:url];
                    }
                    
                } else {
                    message.complete(nil);
                }
            }
        });
    
        _jsonActor = co_actor_onqueue(_jsonQueue, ^(COActorChan * _Nonnull channel) {
            NSData *data = nil;
            id json = nil;
            COActorCompletable *completable = nil;
            for (COActorMessage *message in channel) {
                NSString *url = [message stringType];
                json = nil;
                if (url.length) {
                    completable = [self.networkActor sendMessage:url];
                    data = await(completable);
                    if (data) {
                        json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    }
                    message.complete(json);
                } else {
                    message.complete(nil);
                }
            }
        });
        
    }
    return self;
}

- (COPromise *)getDataWithURL:(NSString*)url {
    return [COPromise promise:^(COPromiseFulfill  _Nonnull fullfill, COPromiseReject  _Nonnull reject) {
        [NSURLSession sharedSession].configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                reject(error);
            } else {
                fullfill(data);
            }
        }];
        [task resume];
    } onQueue:_networkQueue];
}

- (id)requestJSONWithURL:(NSString *)url CO_ASYNC {
    SURE_ASYNC
    return await([self.jsonActor sendMessage:url]);
}

- (UIImage*)imageWithURL:(NSString*)url CO_ASYNC {
    SURE_ASYNC
    return await([self.imageActor sendMessage:url]);
}

- (void)saveDataToCache:(NSData*)data
         withIdentifier:(NSString*)identifier CO_ASYNC {
    SURE_ASYNC
    NSDictionary *msg = @{@"type":@"save", @"data":data, @"id":identifier};
    await([self.cacheActor sendMessage:msg]);
}

- (NSData*)getDataWithIdentifier:(NSString*)identifier CO_ASYNC{
    SURE_ASYNC
    NSDictionary *msg = @{@"type":@"load",  @"id":identifier};
    return await([self.cacheActor sendMessage:msg]);
}


- (NSString *)cachePathForFileName:(NSString *)name {
    NSParameterAssert(name.length);
    
    return [self.cachePath stringByAppendingPathComponent:name];
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    NSParameterAssert(key.length);
    
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;

}
@end
