//
//  FLUIKitTableViewControllerViewModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLUIKitTableViewControllerViewModel.h"
#import "FLConst.h"
#import "FLDataService.h"
#import "FLMovieModel.h"
#import "FLMovieListModel.h"

#import <YYModel.h>

@implementation FLUIKitTableViewControllerViewModel

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSArray*)getDiscoverList:(NSString *)pageLimit {
    NSString *url = [NSString stringWithFormat:@"%@&page=%@",[self prepareUrl], pageLimit];
    id json = [[FLDataService sharedInstance] requestJSONWithURL:url];
    if (!json) {
        return nil;
    }
    FLMovieListModel *listModel = [FLMovieListModel yy_modelWithJSON:json];
    if (listModel) {
        return listModel.results;
    }
    return nil;
}

- (NSDictionary * _Nullable)dictionaryFromResponseObject:(id)responseObject {
    NSDictionary* dictionary = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        dictionary = responseObject;
    } else {
        if (responseObject) {
            dictionary = [NSDictionary dictionaryWithObject:responseObject forKey:@"results"];
        }
    }
    return dictionary;
}

- (NSString *)prepareUrl {
    return [NSString stringWithFormat:@"%@/discover/movie?api_key=%@&sort_by=popularity.desc",kFLNetworkHost, kFLNetworkApikey];
}


@end
