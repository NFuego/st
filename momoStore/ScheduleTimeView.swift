//
//  ScheduleTimeView.swift
//  ShenZou
//
//  Created by zcon on 2016/12/27.
//  Copyright © 2016年 zcon. All rights reserved.
//

import UIKit
import SnapKit


class ScheduleTimeView : UIView {

    private var lbStartTime:UILabel!
    private var lbEndTime:UILabel!
    private var lbSeperator:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init (colW:CGFloat,colH:CGFloat,startTime:String,endTime:String) {
        self.init(frame:CGRect.zero)
        
//        self.backgroundColor = .yellow
        
        lbEndTime = UILabel()
        lbStartTime = UILabel()
        lbSeperator = UILabel()
        lbStartTime.textAlignment = .center
        lbEndTime.textAlignment = .center
        lbSeperator.textAlignment = .center
        lbSeperator.text = "～"
        lbStartTime.text = startTime
        lbEndTime.text = endTime
        self.addSubview(lbStartTime)
        self.addSubview(lbSeperator)
        self.addSubview(lbEndTime)
        lbStartTime.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(colH)
        }
        lbSeperator.snp.makeConstraints { (make) in
            make.top.equalTo(lbStartTime.snp.bottom)
            // invert the w h cause it's rotated
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(colH)
        }
        lbSeperator.transform = CGAffineTransform( rotationAngle: CGFloat( ( Double(90) * M_PI ) / 180))
        lbEndTime.snp.makeConstraints { (make) in
            make.top.equalTo(lbSeperator.snp.bottom)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(colH)
        }
//        lbSeperator.layer.borderColor = UIColor.blue.cgColor
//        lbSeperator.layer.borderWidth = 1
//        lbStartTime.layer.borderWidth = 1
//        lbStartTime.layer.borderColor = UIColor.blue.cgColor
        
        let font = UIFont.systemFont(ofSize: 15)
        lbStartTime.font = font
        lbEndTime.font = font
        lbSeperator.font = font
    }
} // fin ScheduleTimeView
