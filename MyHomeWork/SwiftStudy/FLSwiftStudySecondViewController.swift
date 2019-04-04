//
//  FLSwiftStudySecondViewController.swift
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/4.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

import UIKit

class FLSwiftStudySecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data:[String] = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」",
                         "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体",
                         "呵呵，再见🤗 See you next Project", "微博 @Allen朝辉",
                         "测试测试测试测试测试测试", "123", "Alex", "@@@@@@"]
    var fontNames = ["MFTongXin_Noncommercial-Regular",
                     "MFJinHei_Noncommercial-Regular",
                     "MFZhiHei_Noncommercial-Regular",
                     "Zapfino",
                     "Gaspar Regular"]
    
    var currFontIndex = 0
    
    let tabelView:UITableView! = UITableView.init(frame: CGRect.init(x: 0, y: SafeArea.top + 88, width: ScreenWidth, height: 500), style:UITableView.Style.plain)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(changeButton)
        changeButton.snp.makeConstraints {
            $0.size.equalTo(CGSize.init(width: 100, height: 100))
            $0.bottom.equalTo(view).offset(-SafeArea.bottom-50)
            $0.centerX.equalTo(view.snp.centerX)
        }
        view.addSubview(tabelView)
        tabelView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(view).offset(SafeArea.top)
            $0.bottom.equalTo(changeButton.snp.top).offset(-100)
        }
        tabelView.dataSource = self
        tabelView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellID");
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = data[indexPath.row]
        cell?.textLabel?.font = UIFont(name:fontNames[currFontIndex] , size: 15)
        return cell!
    }
    
    @objc func changeFontDidTouch(_ sender: AnyObject) {
        currFontIndex = (currFontIndex + 1) % 5
        print(fontNames[currFontIndex])
        tabelView.reloadData()
        
    }
    
    //MARK:-lazy
    lazy var changeButton:UIButton = {
        let button:UIButton = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("Change Font", for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 50
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(changeFontDidTouch(_:)), for: .touchUpInside)
        return button
    }()
    
}
