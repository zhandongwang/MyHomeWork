//
//  TDFAppLocationManager.m
//  TDFApp
//
//  Created by 凤梨 on 2018/2/28.
//

#import "TDFAppLocationManager.h"

@interface TDFAppLocationManager ()

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, copy) TDFAppLocationSuccess successBlock;
@property (nonatomic, copy) TDFAppLocationFailed failureBlock;

@end

@implementation TDFAppLocationManager

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
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestWhenInUseAuthorization];
    }
    return self;
}

- (void)getLocationWithSuccessBlock:(TDFAppLocationSuccess)success failure:(TDFAppLocationFailed)failure {
    self.successBlock = success;
    self.failureBlock = failure;
    
    [self stop];
    if ([CLLocationManager authorizationStatus]
         == kCLAuthorizationStatusNotDetermined) {
        [_manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
}

- (void)stop {
    [self.manager stopUpdatingLocation];
}

+ (void)getLocationWithSuccessBlock:(TDFAppLocationSuccess)success failure:(TDFAppLocationFailed)failure {
    [[TDFAppLocationManager sharedInstance] getLocationWithSuccessBlock:success failure:failure];
}

+ (void)stop {
    [[TDFAppLocationManager sharedInstance] stop];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    !self.successBlock?:self.successBlock(latitude,longitude);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    !self.failureBlock?:self.failureBlock(error);
}

@end
