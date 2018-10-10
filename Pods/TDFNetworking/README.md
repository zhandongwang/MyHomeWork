# 火掌柜网络模块

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```


To integrate TDFNetworking into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'git@git.2dfire-inc.com:ios/cocoapods-spec.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TDFNetworking'
    pod 'TDFRequestsBuilder'
end
```

Then, run the following command:

```bash
pod install
```

## Usage

### 初始化 - TDFHTTPClient

当调用方不需要配置代理 ，且TDFRequestsBuilder加工类已满足需求的情况下不需要初始化 。

导入头文件

```objc
#import <TDFNetworking/TDFNetworking.h>
```

配置代理

```objc
TDFHTTPClient *httpClient = [TDFHTTPClient sharedInstance];
httpClient.proxy = self.httpProxy;
```

注意 ，Proxy属性不是必须的 ，调用方可以自己自定义网络代理 ，遵守协议TDFHTTPProxyProtocol就好。
初始化TDFHTTPClient时 ，调用方也可以不设置该属性 ，不会影响网络请求执行 ，设置代理后可拦截处理经过TDFHTTPClient的网络请求 ，具体请参考TDFHTTPProxyProtocol.h

配置请求加工

```objc
TDFHTTPClient *httpClient = [TDFHTTPClient sharedInstance];
httpClient.modelSerializer = [YOUR_SERIALIZER_CLASS new];
```

引入TDFRequestsBuilder库功能为加工不同类型的requestModel ，TDFRequestsBuilder内置4个加工类 ，分别加工BossApi 、GateWay 、AppSecret 、NoneSign类型的请求模型，
以上4种加工类已经使用cocoapod的subspec切割开来 ，若调用方认为不满足业务需求可以扩展自己的加工类 ，若调用方想完全自己定义请求模型的加工规则则不必引入TDFRequestsBuilder仓库 ，
只要调用方需要设置的加工类遵守TDFHTTPSerializeProtocol即可。

### 初始化 - 参数

请求中服务端会要求诸如签名和提供默认URL参数 ，所以如果使用TDFRequestsBuilder仓库 ，那么要初始化一些数据 ，步骤如下:

- 引入TDFBaseInfoKit

```objc
pod 'TDFBaseInfoKit'
```

- 新建TDFBaseInfoDefaults的Category

- 实现TDFBaseInfoDefaultsInitialProtocol协议

```objc
- (void)initDefaultsInformation {
    self.appBossApiKey  = @"xxxxx";
    self.appGWApiSignKey = @"xxxxx";
    self.appApiSecret = @"xxxxx";
    self.appApiKey = @"xxxxx";
}
```

### 创建请求对象

```objc
TDFRequestModel *login = [TDFRequestModel new];
login.requestType = TDFHTTPRequestTypePOST;
login.signType = TDFHTTPRequestSignTypeAppGateWay;
login.serverRoot = kTDFGWAPI;
login.serviceName = @"com.dfire.boss.center.soa.login.service.IUnifiedLoginClientService.login";
login.env = kTDFGwEnv;
```

- requestType：GET ，POST等

- signType：签名类型

- serverRoot：请求发送地址

- serviceName：服务名称

- env：环境 ，daily ，pre等

### 发送请求

```objc
[[TDFHTTPClient sharedInstance]sendRequestWithRequestModel:login progress:nil callback:^(TDFResponseModel * _Nullable res) {
    //dosomething
}];
```

or

```objc
#import <TDFRequestsBuilder/NSString+TDFRequestModel.h>
```

```objc
[@"com.dfire.boss.center.soa.login.service.IUnifiedLoginClientService.listCountry".tdf_gateWayApi send:^(TDFResponseModel *response) {
    //do something
}];
```

### 日志输出

编辑podfile

```objc
pod 'TDFNetworkActivityLogger'
```

设置控制台输入

```objc
- (void)startLogging {
    TDFNetworkHttpieLogger *networkLogger = [TDFNetworkHttpieLogger sharedLogger];
    networkLogger.level = TDFLoggerLevelDebug;
    networkLogger.filterPredicate = [NSPredicate predicateWithBlock:^BOOL(NSURLRequest *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return YES;
    }];
    [networkLogger startLogging];
}
```

### 切换环境

编辑podfile

```objc
pod 'TDFNetworkEnvironmentSwitcher'
```

初始化

```objc
#if DEBUG
TDFNetworkEnvironmentController *environmentController = [TDFNetworkEnvironmentController sharedInstance];
[environmentController setup];
#endif
```

打开切换环境页面

```objc
TDFNetworkEnvironmentController *environmentController = [TDFNetworkEnvironmentController sharedInstance];
[environmentController switchEnvironmentWithHostViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
```

或直接切换

```objc
[[TDFNetworkEnvironmentController sharedInstance] switchEnvironmentWithType:TDFNetworkEnvironmentTypeDaily];
```

此处切换环境仅针对以上serverRoot设置为kTDFGWAPI等TDFNetworking内置的、FOUNDATION_EXPORT的常量的requestModel。
切换环境在非debug-scheme下不生效

## Swift调用

- 创建bridge YOUR_PROJECT-Bridging-Header.h
- 在bridge中引入头文件
- 初始化requestModel
- 发送请求并handle

```swift
#import <TDFBaseInfoKit/TDFBaseInfoKit.h>
#import <TDFNetworking/TDFNetworking.h>
#import <TDFNetworking/TDFHTTPClient.h>
#import <TDFCategories/UIViewController+AlertMessage.h>
#import <TDFRequestsBuilder/NSString+TDFRequestModel.h>
#import <TDFNetworkActivityLogger/TDFNetworkHttpieLogger.h>
```

```swift
func sendRequest() -> Void {
    let req = TDFRequestModel()
    req.serverRoot = kTDFGWAPI
    req.serviceName = "com.dfire.boss.center.soa.login.service.IUnifiedLoginClientService.listCountry"
    req.signType = TDFHTTPRequestSignType.appGateWay
    req.requestType = TDFHTTPRequestType.POST
    req.env = kTDFGwEnv
    TDFHTTPClient.sharedInstance().sendRequest(with: req, progress: nil) { (res) in
        if let r = res?.responseObject as? Dictionary<String,Any> {
            //do something
            self.showAlert(r.keys.first, confirm: {
            })
        }
    }
}
```

or

```swift
func sendRequest() -> Void {
    let serviceName:NSString = "com.dfire.boss.center.soa.login.service.IUnifiedLoginClientService.listCountry";
    serviceName.tdf_gateWayApi().send { (res) in
        if let r = res?.responseObject as? Dictionary<String,Any> {
            //do something
            self.showAlert(r.keys.first, confirm: {
            })
        }
    }
}
```

## Feature

- 去除业务代码
- 单元测试
- 自定义代理
- 自定义解析
- 内置4种解析方式，可插件化配置对于不同请求的不同解析模式
- 拦截响应
- 现有Api操作类可以直接绑定Hud，自动销毁
- 可方便转为signal
- 可方便查看网络请求，并转为httpie命令行tools实现重放
- 兼容swift


> 如有建议疑问email me ，doubanjiang@2dfire.com