//
//  FLSwiftStudy27.swift
//  MyHomeWork
//
//  Created by 王战东 on 2019/4/6.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//Ø

import UIKit

class FLTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemFirst:UITabBarItem = UITabBarItem(title: "首页", image: nil, selectedImage: nil);
        let itemSecond:UITabBarItem = UITabBarItem(title: "消息", image: nil, selectedImage: nil);
        let itemThird:UITabBarItem = UITabBarItem(title: "设置", image: nil, selectedImage: nil);
        let firstVC = UINavigationController(rootViewController: FLSwiftStudy27FirstViewController())
        firstVC.tabBarItem = itemFirst
        let secondVC = UINavigationController(rootViewController:FLSwiftStudy27SecondViewController())
        secondVC.tabBarItem = itemSecond
        let thirdVC = UINavigationController(rootViewController: FLSwiftStudy27ThirdViewController())
        thirdVC.tabBarItem = itemThird

        viewControllers = [firstVC,secondVC,thirdVC]
        selectedIndex = 0
    }

}

