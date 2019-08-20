//
//  WZDWebViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/10/30.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLWebViewController.h"
#import <Masonry.h>
@import WebKit;
#import <OCTWebViewBridge/OCTWebViewBridge.h>
#import "WebPlugin.h"

@interface FLWebViewController ()<JSObjcDelegate, UIWebViewDelegate,
WKScriptMessageHandler, WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation FLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
//    NSURL *url = [NSURL URLWithString:@"http://d.2dfire-pre.com/hercules/page/guide.html?allowBack=true&isInstallShopkeeperApp=false&pageIndex=1&version=4746&deviceType=1&industryType=3&language=en#/index"];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"]; //[[NSBundle mainBundle] URLForResource:@"testWeb" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
//    /*UIWebview*/
//    [self.view addSubview:self.webView];
//    [self.webView loadRequest:request];
    
    
    /*WKWebview*/
    WKUserContentController *userContent = [[WKUserContentController alloc] init];
    [userContent addScriptMessageHandler:self name:@"MyNative"];

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = userContent;
    config.ignoresViewportScaleLimits = NO;

    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [self.view addSubview:self.wkWebView];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;


    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(-100);
        make.left.right.equalTo(self.view);
    }];
    [self.wkWebView loadRequest:request];
    
//    [[OCTWebViewPluginInjector injectorForWebView:self.wkWebView] injectPlugin:[OCTLogPlugin new]];
//
//    [[OCTWebViewPluginInjector injectorForWebView:self.wkWebView] injectPluginWithFunctionName:@"test" handler:^(NSDictionary *data) {
//        NSLog(@"%@", data);
//    }];
//
//    [[OCTWebViewPluginInjector injectorForWebView:self.wkWebView] injectPluginWithFunctionName:@"test2" handlerWithResponseBlock:^(NSDictionary *data, OCTResponseCallback responseCallback) {
//        NSLog(@"test2: %@", data);
//        responseCallback(@{ @"Hello JS" : @"I'm back from Native" });
//    }];

    
//    [[OCTWebViewPluginInjector injectorForWebView:self.wkWebView] injectPluginWithFunctionName:@"test2" handlerWithResponseBlock:^(NSDictionary *data, OCTResponseCallback responseCallback) {
//        NSLog(@"test2: %@", data);
//        responseCallback(@{ @"hello" : @"world" });
//    }];

}

- (void)dealloc {
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"MyNative"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKUIDelegate

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message.body);
    
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSLog(@"decidePolicyForNavigationAction--Decides whether to allow or cancel a navigation.");
    if ([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] &&
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation--Called when a web view receives a server redirect.");
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse--Decides whether to allow or cancel a navigation after its response is known.");
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
     NSLog(@"didStartProvisionalNavigation---Called when web content begins to load in a web view");
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didCommitNavigation---Called when the web view begins to receive web content");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
     NSLog(@"didFinishNavigation---Called when the navigation is complete.");
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'" completionHandler:nil];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0)) {
    NSLog(@"WkWebView进程退出");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"didFailNavigation--Called when an error occurs during navigation. %@", error);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation--Called when an error occurs while the web view is loading content. %@", error);
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    NSString *url = request.URL.absoluteString;
    //    if ([url rangeOfString:@"toyun://"].location != NSNotFound) {
    //        // url的协议头是Toyun
    //        NSLog(@"callCamera");
    //        return NO;
    //    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"Toyun"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常:%@", exceptionValue);
    };
    
}

#pragma mark - Native methods

- (void)callCamera {
    NSLog(@"Objc callCamera");//JS调用Native
    JSValue *picCallBack = self.jsContext[@"picCallback"];//回调
    [picCallBack callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareString {
    NSLog(@"Objc share:%@", shareString);
    JSValue *shareCallBack = self.jsContext[@"shareCallback"];
    [shareCallBack callWithArguments:nil];
}

- (void)buttonTapped:(UIButton *)button {
    [self.wkWebView evaluateJavaScript:@"calljs();" completionHandler:nil];
}

#pragma mark - accessors

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.backgroundColor = [UIColor redColor];
        [_actionButton setTitle:@"Test" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

@end
