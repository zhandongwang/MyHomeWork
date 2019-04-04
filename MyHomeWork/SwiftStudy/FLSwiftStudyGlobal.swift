//
//  FLSwiftStudyGlobal.swift
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/4.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

let SafeArea:UIEdgeInsets = {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.init()
    } else {
        return UIEdgeInsets.init();
    }
}()

