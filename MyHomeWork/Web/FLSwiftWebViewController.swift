//
//  FLSwiftWebViewController.swift
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/6.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

//
//  WZDSwiftWebViewController.swift
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/6.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

import Foundation
import WebKit
import SnapKit

@objc(FLSwiftWebViewController)

class FLSwiftWebViewController: UIViewController,WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubviews()
        setupLayout()
        let url:URL? = Bundle.main.url(forResource: "testWeb", withExtension: "html")
        let requet = URLRequest.init(url:url!)
        wkWebView.load(requet)
        testWebBridge()
        
    }
    
    deinit {
        wkWebView.configuration.userContentController.removeScriptMessageHandler(forName: "MyNative")
    }
    //MARK:- Private methods
    func testBlock() {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: {s1, s2 in s1 > s2})
        
        print(reversedNames)
        
        someFuncWithAClousure(name: "Swift") { (s1, s2) in
            print(s1 ?? "")
            print(s2 ?? "")
        }

        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)

//        serve(customer: {customersInLine.remove(at: 0)})
        serveWithAutoClosure(customer: customersInLine.remove(at: 0))
        print(customersInLine.count)
        
    }
    
    func serve(customer customerProvider: () -> String) {
        print("Now serving\(customerProvider())")
    }
    
    
    func serveWithAutoClosure(customer customerProvider:@autoclosure ()->String ) {
        print("Now serving\(customerProvider())")
    }
    
    
    
    
    func someFuncWithAClousure(name:String?, closure: (String?, String?) -> Void)  {
        closure(name! + " s1", name! + " s2")
    }

    func setupSubviews() {
        self.view.addSubview(actionButton)
        self.view.addSubview(wkWebView)
    }
    
    func setupLayout() {
        actionButton.snp.makeConstraints {
            $0.bottom.equalTo(view);
            $0.centerX.equalTo(view);
            $0.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        wkWebView.snp.makeConstraints {
            $0.top.equalTo(view).offset(40)
            $0.bottom.equalTo(view).offset(-100)
            $0.left.right.equalTo(view)
        }
    }
    
    func testWebBridge() {
//        OCTWebViewPluginInjector.init(for: self.wkWebView).injectPlugin(withFunctionName: "test") { (data) in
//            print(data ?? "")
//        }
        
//        OCTWebViewPluginInjector.init(for: self.wkWebView).injectPlugin(withFunctionName: "test2") { (data, callback) in
//            callback!("test2")
//        }
    }
    
    
    //MARK:- Event handlers
    @objc func action(button:UIButton) {
        self.wkWebView.evaluateJavaScript("calljs();", completionHandler: nil)
    }
    
    //MARK:- WKScriptMessageHandler
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'", completionHandler: nil)
    }
    
    //MARK:- Accessors
    
    lazy var actionButton:UIButton! = {
        let button:UIButton = UIButton.init(type: .custom)
        button.setTitle("Hybrid测试", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action:#selector(action(button:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var wkWebView:WKWebView = {
        let userContent:WKUserContentController = WKUserContentController.init()
        userContent.add(self, name: "MyNative")
        
        let config: WKWebViewConfiguration = WKWebViewConfiguration.init()
        config.userContentController = userContent
        
        let webView:WKWebView = WKWebView.init(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        return webView
    }()
}

