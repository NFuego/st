//
//  MonthCellView.swift
//  momoStore
//  Created by SSStand on 11/01/2017.
//  Copyright © 2017 MomoDidi. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CodeCellView: JTAppleDayCellView {
    let bgColor = UIColor.red
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        let r1 = CGRect(x: 0, y: 0, width: 25, height: 25)
        context?.addRect(r1)
        context?.fillPath()
        context?.setStrokeColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1.0)
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 25, height: 25))
        context?.strokePath()
    }
    
}
