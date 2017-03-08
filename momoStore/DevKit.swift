//
//  DevKit.swift
//  ShenZou
//
//  Created by zcon on 2017/1/12.
//  Copyright © 2017年 zcon. All rights reserved.
//

import Foundation
import UIKit

struct DevKit {
    static func displayBorder(comps:[UIView]){
        comps.map { (comp) in
            comp.layer.borderWidth = 1
            comp.layer.borderColor = UIColor.red.cgColor
        }
    }
}
