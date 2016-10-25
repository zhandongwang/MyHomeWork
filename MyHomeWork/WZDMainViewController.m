//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDMainViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSCoreObject.h"

@interface WZDMainViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;

@end

@implementation WZDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsContextCreated:) name:@"didCreateJsContextNotification" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event handle

- (void)jsContextCreated:(NSNotification *)notification
{
    JSContext *context = notification.object;
    
    NSString *indentifier = [NSString stringWithFormat:@"indentifier%lud", (unsigned long)self.webView.hash];
    NSString *indentifierJS = [NSString stringWithFormat:@"var %@ = '%@'", indentifier, indentifier];
    
    [self.webView stringByEvaluatingJavaScriptFromString:indentifierJS];
    
    if (![context[indentifier].toString isEqualToString:indentifier]) {
      return;
    }

    self.context = context;
    JSCoreObject *jsObject = [[JSCoreObject alloc] initWithWebView:self.webView];
    self.context[@"JSTest"] = jsObject;
}

#pragma mark - accessors

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 250, 400)];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIView *)customView
{
    if (!_customView) {
        _customView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _customView.backgroundColor = [UIColor redColor];
    }
    return _customView;
}

@end
