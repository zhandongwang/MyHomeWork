//
//  TDFAppLocationManager.h
//  TDFApp
//
//  Created by 凤梨 on 2018/2/28.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^TDFAppLocationSuccess) (CLLocationDegrees latitude, CLLocationDegrees longitude);
typedef void(^TDFAppLocationFailed) (NSError *error);

@interface TDFAppLocationManager : NSObject<CLLocationManagerDelegate>

+ (instancetype)sharedInstance;
- (void)getLocationWithSuccessBlock:(TDFAppLocationSuccess)success failure:(TDFAppLocationFailed)failure;
+ (void)getLocationWithSuccessBlock:(TDFAppLocationSuccess)success failure:(TDFAppLocationFailed)failure;
- (void)stop;
+ (void)stop;

@end
