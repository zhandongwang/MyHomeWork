//
//  FLTableViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLTableViewController.h"
#import "FLUIKitViewController.h"
#import "FLCTViewController.h"
#import "FLCoreGraphicsViewController.h"
#import "FLUIKitTableViewController.h"
#import "FLRunTimeViewController.h"
#import "FLDBViewController.h"
#import "FLConcurrentViewController.h"
#import "FLRunloopViewController.h"
#import "FLWebViewController.h"
#import <Flutter/Flutter.h>

#import "FLFlutterViewController.h"
#import "FLASDKViewController.h"
#import "AppDelegate.h"

#import <flutter_boost/FlutterBoost.h>
#import <FLFlutterRouter.h>

static NSString * const kCellID = @"cellID";
static NSString * const kExampleNotification = @"kExampleNotification";

static NSString * const kKDSMethodChannelName = @"com.zmsoft.ccd/channel/user";
static NSString * const kKDSMethodChannelMethodUserInfo = @"getUserInfo";


@interface FLTableViewController ()

@property (nonatomic, copy) NSDictionary *dataDict;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能列表";
    [self configDataSource];
    [self configTableView];

}

- (void)configDataSource {
    self.dataDict = @{@"UIKit":@"goToUIKit",
                      @"Concurrent":@"goToConcurrent",
                      @"RunLoop":@"goToRunLoop",
                      @"DataBase":@"goToDataBase",
                      @"Core Text":@"goToCoreText",
                      @"Core Graphics":@"goToCoreGraphics",
                      @"WebView":@"goToWebView",
                      @"RunTime":@"goToRunTime",
                      @"Flutter":@"goToFlutter",
                      
                      };
    self.dataSource = [NSMutableArray arrayWithArray:self.dataDict.allKeys];
}


- (void)configTableView {
    self.tableView.rowHeight = 88;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    self.tableView.tableFooterView = [UIView new];
}

- (void)registerMethodChannel:(FlutterViewController *)flutterVC {
    FlutterMethodChannel *kdsChannel = [FlutterMethodChannel methodChannelWithName:kKDSMethodChannelName binaryMessenger:flutterVC];
    [kdsChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:kKDSMethodChannelMethodUserInfo]) {
            result([self getUserInfo]);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

- (NSString *)getUserInfo {
    NSDictionary *dict = @{@"userId":@"123"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - Methods

- (void)goToFlutter {
//    FlutterEngine *flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter.kds.CloudCash" project:nil];
//    [flutterEngine runWithEntrypoint:nil];
//
//    FLFlutterViewController *vc =  [[FLFlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
//
//    [self registerMethodChannel:vc];
    
    FLBFlutterViewContainer *kdsViewController = FLBFlutterViewContainer.new;
    [kdsViewController setName:@"ccd://kdsOrder" params:@{}];
    [self.navigationController pushViewController:kdsViewController animated:YES];
    
//    [FLFlutterRouter.sharedInstance openPage:@"ccd://kdsOrder" params:@{} animated:YES completion:^(BOOL finished) {
//        NSLog(@"fafa");
//    }];
    FlutterMethodChannel *kdsChannel = [FlutterMethodChannel methodChannelWithName:@"com.zmsoft.ccd/channel/user" binaryMessenger:[FlutterBoostPlugin.sharedInstance currentViewController]];
    [kdsChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"getUserInfo"]) {
            result([self getUserInfoForFlutter]);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

- (void)goToWebView {
    [self.navigationController pushViewController:[[FLWebViewController alloc] init] animated:YES];
}


- (void)goToUIKit {
    [self.navigationController pushViewController:[[FLUIKitViewController alloc] init] animated:YES];
}

- (void)goToRunLoop {
    [self goToFlutter];
//    [self.navigationController pushViewController:[[FLRunloopViewController alloc] init] animated:YES];
}



- (void)goToRunTime {
    [self.navigationController pushViewController:[[FLRunTimeViewController alloc] init] animated:YES];
}
- (void)goToConcurrent {
     [self.navigationController pushViewController:[[FLConcurrentViewController alloc] init] animated:YES];
}
- (void)goToDataBase {
     [self.navigationController pushViewController:[[FLDBViewController alloc] init] animated:YES];
}

- (void)goToCoreText {
    [self.navigationController pushViewController:[[FLCTViewController alloc] init] animated:YES];
}

- (void)goToCoreGraphics {
    [self.navigationController pushViewController:[[FLCoreGraphicsViewController alloc] init] animated:YES];
}

- (NSString *)getUserInfoForFlutter {
    return @"{\"app_key\":\"200016\",\"s_sc\":\"375 X 667\",\"lang\":\"zh_CN\",\"entity_id\":\"00112665\",\"sign_method\":\"md5\",\"s_lng\":\"\",\"user_id\":\"001126655d5905c9015d5a33448f0093\",\"currency_symbol\":\"￥\",\"super_admin\":false,\"is_configuration_printer\":false,\"industry\":0,\"s_did\":\"73b27003cfadcb786804b11f6e43d663\",\"s_os\":\"ios\",\"s_lat\":\"\",\"country_id\":\"001\",\"format\":\"json\",\"s_apv\":\"2.8.3\",\"s_osv\":\"12.1.2\",\"api_secret\":\"2b8e48e608d349cf9e236ecd9c677a83\",\"s_br\":\"王战东的 iPhone\",\"s_net\":\"3\",\"timestamp\":\"1565077608.555525\",\"env\":\"publish\",\"s_eid\":\"00112665\",\"token\":\"CO8Z5xAOYbB5CNdP5X7QsnRlWJ1Qlr9TM7IryOXAjARxbhq04OAydaDMqzWR%2BHsYXcrLSW6MA8i7FqW76BQGRA%3D%3D\",\"shop_code\":\"381\",\"work_status\":true,\"mobile\":\"18858102101\",\"model_mixture\":false,\"shop_name\":\"凤梨线上测试店\"}";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *selString =  [self.dataDict valueForKey:self.dataSource[indexPath.row]];
    if ([self respondsToSelector:NSSelectorFromString(selString)]) {
        [self performSelector:NSSelectorFromString(selString)];
    }
}


@end
