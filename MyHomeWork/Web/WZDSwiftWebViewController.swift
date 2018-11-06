//
//  WZDSwiftWebViewController.swift
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/6.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

import Foundation
import WebKit

class WZDSwiftWebViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.actionButton)
        
    }
    
    func action(button:UIButton) {
        print("button is tapped")
    }
    
    lazy var actionButton:UIButton! = {
        let button:UIButton = UIButton.init(type: .custom)
        button.setTitle("Hybrid测试", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action:#selector(action(button:)), for: .touchDown)
        
        return button
    }()
    
}
