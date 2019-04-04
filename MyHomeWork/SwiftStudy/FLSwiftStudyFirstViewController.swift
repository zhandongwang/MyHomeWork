//
//  FLSwiftTestViewController.swift
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/3.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

import UIKit
import SnapKit


class FLSwiftStudyFirstViewController: UIViewController {

    var timer:Timer? = Timer()
    var isPlaying = false
    var counter:Float = 0.0 {
        didSet {
            resultLabel.text = String(format: "%.1f", counter)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        setupUI()
        counter = 0
        
    }

    //MARK: -UI
    func setupUI() {
        self.view.addSubview(addButton)
        self.view.addSubview(pauseButton)
        self.view.addSubview(resultView)
        self.view.addSubview(resultLabel)
        addButton.snp.makeConstraints {
            $0.left.equalTo(self.view)
            $0.bottom.equalTo(view).offset(-SafeArea.bottom)
            $0.size.equalTo(CGSize.init(width: ScreenWidth * 0.5, height: 300))
        }
        pauseButton.snp.makeConstraints {
            $0.right.equalTo(self.view)
            $0.bottom.equalTo(view).offset(-SafeArea.bottom)
            $0.size.equalTo(CGSize.init(width: ScreenWidth * 0.5, height: 300))
        }
        resultView.snp.makeConstraints {
            $0.right.left.equalTo(view)
            $0.bottom.equalTo(addButton.snp.top)
            $0.top.equalTo(view).offset(SafeArea.top)
        }
        
        resultLabel.snp.makeConstraints { (make) in
            make.right.left.equalTo(self.view)
            make.bottom.equalTo(addButton.snp.top)
            make.top.equalTo(self.view).offset(SafeArea.top)
        }
    }
    
    //MARK: -event handle
    @objc func updateTimer() {
        counter += 0.1
    }
    
    
    @objc func addBtnTapped() {
        addButton.isEnabled = false
        pauseButton.isEnabled = true
        if let tmpTimer = timer {
            tmpTimer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        isPlaying = true
    }
    
    @objc func pauseBtnTapped() {
        addButton.isEnabled = true
        pauseButton.isEnabled = false
        if let tmpTimer = timer {
            tmpTimer.invalidate()
        }
        isPlaying = false
    }
    
    lazy var resultView:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    lazy var resultLabel:UILabel = {
        let label:UILabel = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = UIColor.black
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    lazy var addButton:UIButton = {
        let button = UIButton.init()
        button.setTitle("Add", for:UIControlState.normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(addBtnTapped), for:.touchUpInside)
        return button
    }()
    
    lazy var pauseButton:UIButton = {
        let button = UIButton.init()
        button.setTitle("Pause", for:UIControlState.normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(pauseBtnTapped), for:.touchUpInside)
        return button
    }()
    
}
