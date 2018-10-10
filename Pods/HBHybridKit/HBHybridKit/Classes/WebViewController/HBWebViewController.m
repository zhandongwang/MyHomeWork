//
//  HBWebViewController.m
//  weather
//
//  Created by CaydenK on 2016/11/28.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import "HBWebViewController.h"
#import "HBMacroDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "HBJSCenter.h"
#import "HBWebEngine.h"
#import "HBUtility.h"
#import "HBWebInputModel.h"
#import "NSBundle+HBHybridKit.h"
#import "HBWebDebugView.h"

//太鸡巴坑爹了，WKWebView 只是一个半成品，NSURLProtocol都不支持
//乖乖用回UIWebView
//#define __IPHONE_OS_VERSION_CURRENT __IPHONE_OS_VERSION_MAX_ALLOWED
#define __IPHONE_OS_VERSION_CURRENT __IPHONE_6_1


#if __IPHONE_OS_VERSION_CURRENT >= __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif


@interface HBWebViewController ()

#if __IPHONE_OS_VERSION_CURRENT >= __IPHONE_8_0
<WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
#else
<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
#endif

@property (weak, nonatomic) HBWebDebugView *webDebugView;

@property (strong, nonatomic) HBWebInputModel *inputParams;

@property (strong, nonatomic) JSContext *jsContext;
@property (strong, nonatomic) HBJSCenter *jsDelegate;

/**
 是否已经点过返回
 */
@property (assign, nonatomic) BOOL hasBack;

@end

@implementation HBWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSubviews];
    [self configureNavigationBar];
    [self configureLayout];
    [self configUserAnget];
    [self loadData];
}

#if __IPHONE_OS_VERSION_CURRENT >= __IPHONE_8_0
- (void)viewWillAppear:(BOOL)animated {
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
#endif

- (void)loadData {
    NSURL *url = [NSURL URLWithString:self.inputParams.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
}

- (void)configUserAnget {
    [HBWebEngine updateUserAngentLang];
}

- (void)goBackWithSender:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        self.hasBack = YES;
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)closeWithSender:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)disposeDetailWithSender:(id)sender {
    [self.webView reload];
}

#if __IPHONE_OS_VERSION_CURRENT >= __IPHONE_8_0
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    if ([url.path rangeOfString:@"paymode"].location != NSNotFound) {
        //去支付页，调起选择支付客户端页
#if __IPHONE_OS_VERSION_CURRENT >= __IPHONE_10_0
        //只允许应用跳转的方式打开URL
        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:^(BOOL success) {
            NSLog(@"%i",success);
        }];
#else
        [[UIApplication sharedApplication] openURL:url];
#endif
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self updateLeftNavigationBar];
    self.title =  webView.title;
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}

#pragma mark - estimatedProgress Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"%f",self.webView.estimatedProgress);
        
        //因部分网页，goBack后，不执行 webView:didFinishNavigation: 方法，只能在这里调用
        if (self.webView.estimatedProgress == 1) {
            [self updateLeftNavigationBar];
            self.title =  self.webView.title;
        }
    }
}

#else

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    
    //TODO:界面跳转相关逻辑，老逻辑
//    if ([HBWebEngine typeOfURL:url] == HBWebEngineURLTypeLichKing && [url.path rangeOfString:@"checkout.html"].location != NSNotFound) {
//        //去支付页，调起选择支付客户端页
//        NSDictionary *queryDict = [HBUtility queryParamsFromURL:url];
//        [[NSNotificationCenter defaultCenter] postNotificationName:HBWebEngineChoosePayNotification object:nil userInfo:queryDict];
//        return NO;
//    }
    
    if ([url.scheme isEqualToString:@"cardapp"]) {
        //跳转本地
        return YES;
    }
    
//    
//    //只允许应用跳转的方式打开URL
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//    [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:^(BOOL success) {
//        NSLog(@"%i",success);
//    }];
//#else
//    [[UIApplication sharedApplication] openURL:url];
//#endif
//
//    if ([url.scheme isEqualToString:@"cardapp"]) {
//        //TODO: 界面跳转
//        if ([url.host isEqualToString:@"h5.2dfire.com"]) {
//            if ([url.path isEqualToString:@"paymode"]) {
//                //支付跳转
//                //chosePay
//                
//                
//                return NO;
//            }
//        }
//    }
    
    

    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [self.toolBar setLoadingStatus:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateLeftNavigationBar];
    self.title =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}


#pragma mark - TSWebViewDelegate
/**
 JavaScriptContext创建的时候回调

 @param webView self.webview
 @param ctx jsContext
 */
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx
{
        self.jsContext = ctx;//[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.jsContext[kHBJSBridgeName] = self.jsDelegate;
        self.jsDelegate.context = self.jsContext;
        self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
            NSLog(@"异常信息：%@", exceptionValue);
        };
}

#endif


#pragma mark - load subviews
- (void)configureSubviews {
    //title 颜色/字体跟随系统设置
    [self.view addSubview:self.webView];
    
    if (HBWebEngine.debug) {
        __weak typeof(self) weakSelf = self;
        HBWebDebugView *webDebugView = [HBWebDebugView webDebugViewWithCurrentURL:^NSString *{
            return weakSelf.webView.request.URL.absoluteString;
        } completion:^(NSString *urlString) {
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
            [weakSelf.webView loadRequest:request];
        }];
        self.webDebugView = webDebugView;        
        [self.view addSubview:webDebugView];
    }
}
- (void)configureNavigationBar {
    [self updateLeftNavigationBar];

    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:(UIButton *)({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(disposeDetailWithSender:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:@"Resource.bundle/refresh.png"];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = (CGRect){(CGPoint){0,0}, image.size};
        button;
    })];
                                       //:[UIImage imageNamed:@"Resource.bundle/refresh.png"] style:UIBarButtonItemStyleDone target:self action:@selector(disposeDetailWithSender:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
- (void)updateLeftNavigationBar {
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:(UIButton *)({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(goBackWithSender:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *image = [UIImage imageNamed:@"Resource.bundle/goBack.png"];
        [button setImage:image forState:UIControlStateNormal];
        
        CGFloat scale = ([[UIScreen mainScreen] bounds].size.height == 736) ? 1.15 : 1.0;
        [button.titleLabel setFont:[UIFont systemFontOfSize:12 * scale]];
        [button setTitle:[NSBundle hb_localizedStringForKey:@"Back"] forState:UIControlStateNormal];
        
        CGSize titleSize = [[NSBundle hb_localizedStringForKey:@"Back"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 * scale]} context:nil].size;
        
        button.frame = (CGRect){(CGPoint){0,0}, (CGSize){(image.size.width + 5 + titleSize.width), image.size.height}};
        button;
    })];
    UIBarButtonItem *closeBarButton = [[UIBarButtonItem alloc]initWithCustomView:(UIButton *)({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(closeWithSender:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage imageNamed:@"Resource.bundle/close.png"];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = (CGRect){(CGPoint){0,0}, image.size};
        button;
    })];
    if (self.hasBack) {
        self.navigationItem.leftBarButtonItems = @[leftBarButton, closeBarButton];
    }
    else {
        self.navigationItem.leftBarButtonItems = @[leftBarButton];
    }
}

#pragma mark - configure layout
- (void)configureLayout {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    if (HBWebEngine.debug) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webDebugView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.webDebugView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100]];
    }
}

#pragma mark - Get & Set

#if __IPHONE_OS_VERSION_CURRENT >= __IPHONE_8_0
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webView.navigationDelegate = self;
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _webView;
}
#else
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _webView;
}
#endif

- (HBJSCenter *)jsDelegate {
    if (!_jsDelegate) {
        _jsDelegate = [[HBJSCenter alloc] init];
    }
    return _jsDelegate;
}

- (void)dealloc
{
    self.jsContext[kHBJSBridgeName] = nil;
    _jsDelegate = nil;
    _jsContext = nil;
}

@end
