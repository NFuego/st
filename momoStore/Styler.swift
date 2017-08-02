//
//  Styler.swift
//  momoCustomer
//
//  Created by zcon on 2017/5/17.
//  Copyright © 2017年 MomoDidi. All rights reserved.
//

import Foundation
import UIKit

class Styler {
    class func styleNavBar(_ vc:UIViewController){
        vc.edgesForExtendedLayout = []
        vc.extendedLayoutIncludesOpaqueBars = true
        vc.navigationController?.toolbar.barStyle = .default // this make it appears
        
        vc.navigationController?.navigationBar.barStyle = .blackOpaque
        vc.navigationController?.navigationBar.isTranslucent = false
        vc.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        vc.navigationController?.navigationBar.tintColor = .white
    }
    
    class func clearBorder(_ vc:UIView) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.orange.cgColor
        border.frame = CGRect(x: 0, y: vc.frame.size.height - width, width: vc.frame.size.width, height: vc.frame.size.height)
        border.borderWidth = width
        vc.layer.addSublayer(border)
        vc.layer.masksToBounds = true
    }
    
}

