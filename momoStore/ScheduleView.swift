// //  ScheduleVC.swift
//  ShenZou
//
//  Created by zcon on 2016/12/27.
//  Copyright © 2016年 zcon. All rights reserved.
//

import UIKit
import SnapKit

class ScheduleView : UIView {


    var scrollView:UIScrollView!
    var containerView:UIView!

    var lbMonday:UILabel!
    var lbTuesday:UILabel!
    var lbWednesday:UILabel! = UILabel()
    var lbThursday:UILabel! = UILabel()
    var lbFriday:UILabel! = UILabel()
    var lbSaturday:UILabel! = UILabel()
    var lbSunday:UILabel! = UILabel()


    // -- const
    let timeTopPadding = 10


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override init (frame : CGRect) {
        super.init(frame : frame)
    }

    
    convenience init () {
        self.init(frame:CGRect.zero)
        
        self.backgroundColor = .white

        let fullScreenSize = UIScreen.main.bounds.size
        let colPadding:CGFloat = 1
        let cols:CGFloat = 7
        let colW = (fullScreenSize.width - (colPadding * (cols + 1))) / cols
        let colH = 30
        
        containerView = UIView()
        scrollView = UIScrollView()
//        scrollView.backgroundColor = .cyan
        self.addSubview(scrollView)

//        self.scrollView.backgroundColor = .cyan
        self.scrollView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
            make.edges.equalTo(self)
        }
        
        self.scrollView.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self)
        }
        
        
        // ========================================================================== week header setup
        lbMonday = initHeader(str: "一")
        lbMonday.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.leading.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }
        
        lbTuesday = initHeader(str: "二")
        lbTuesday.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.left.equalTo(lbMonday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbWednesday = initHeader(str: "三")
        lbWednesday.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.left.equalTo(lbTuesday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbThursday = initHeader(str: "四")
        lbThursday.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.left.equalTo(lbWednesday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbFriday = initHeader(str: "五")
        lbFriday.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.left.equalTo(lbThursday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbSaturday = initHeader(str: "六")
        lbSaturday.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.left.equalTo(lbFriday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbSunday = initHeader(str: "日")
        lbSunday.snp.makeConstraints { (make) in
            make.top.equalTo(containerView)
            make.left.equalTo(lbSaturday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }
        
        // ========================================================================== week

//        let t = initHeader(str: ":99")
//        t.font = UIFont.systemFont(ofSize: 15)
//        t.snp.makeConstraints { (make) in
//            make.top.equalTo(lbMonday.snp.bottom)
//            make.width.equalTo(colW)
//            make.height.equalTo(colH)
//            make.leading.equalTo(colPadding)
//        }
        
//        let t2 = initHeader(str: "99:99")
//        t2.font = UIFont.systemFont(ofSize: 15)
//        t2.snp.makeConstraints { (make) in
//            make.top.equalTo(lbTuesday.snp.bottom)
//            make.width.equalTo(colW)
//            make.height.equalTo(colH)
//            make.left.equalTo(t.snp.right).offset(colPadding)
//        }

        let t2 = ScheduleTimeView(colW: colW, colH: CGFloat(colH), startTime: "08:00", endTime: "10:00")
        containerView.addSubview(t2)
        t2.snp.makeConstraints { (make) in
            make.top.equalTo(lbMonday.snp.bottom).offset(timeTopPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH*3)
            make.left.equalTo(lbMonday.snp.left)
        }
        
        let t22 = ScheduleTimeView(colW: colW, colH: CGFloat(colH), startTime: "12:00", endTime: "06:00")
        containerView.addSubview(t22)
        t22.snp.makeConstraints { (make) in
            make.top.equalTo(t2.snp.bottom).offset(timeTopPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH*3)
            make.left.equalTo(lbMonday.snp.left)
        }


        let t3 = ScheduleTimeView(colW: colW, colH: CGFloat(colH), startTime: "09:00", endTime: "14:00")
        containerView.addSubview(t3)
        t3.snp.makeConstraints { (make) in
            make.top.equalTo(lbTuesday.snp.bottom).offset(timeTopPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH*3)
            make.left.equalTo(lbWednesday.snp.right).offset(colPadding)
        }

        let t4 = ScheduleTimeView(colW: colW, colH: CGFloat(colH), startTime: "15:00", endTime: "18:00")
        containerView.addSubview(t4)
        t4.snp.makeConstraints { (make) in
            make.top.equalTo(t3.snp.bottom).offset(timeTopPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH*3)
            make.left.equalTo(lbWednesday.snp.right).offset(colPadding)
        }

        // the last time view need to set the bottom
        let t5 = ScheduleTimeView(colW: colW, colH: CGFloat(colH), startTime: "19:00", endTime: "22:00")
        containerView.addSubview(t5)
        t5.snp.makeConstraints { (make) in
            make.top.equalTo(t4.snp.bottom).offset(timeTopPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH*3)
            make.left.equalTo(lbWednesday.snp.right).offset(colPadding)
        }

        let t33 = setScheduleTime(topRef: lbTuesday, leftRef: lbMonday, w: colW, h: CGFloat(colH), start: "10:00", end: "12:00", isLast: false)
        let t34 = setScheduleTime(topRef: t33, leftRef: lbMonday, w: colW, h: CGFloat(colH), start: "15:00", end: "20:00", isLast: false)

        let t35 = setScheduleTime(topRef: lbWednesday, leftRef: lbTuesday, w: colW, h: CGFloat(colH), start: "10:00", end: "12:00", isLast: false)
        let t36 = setScheduleTime(topRef: t35 , leftRef: lbTuesday, w: colW, h: CGFloat(colH), start: "15:00", end: "20:00", isLast: false)
        
        let t37 = setScheduleTime(topRef: lbFriday, leftRef: lbThursday, w: colW, h: CGFloat(colH), start: "10:00", end: "12:00", isLast: false)
        let t38 = setScheduleTime(topRef: t37 , leftRef: lbTuesday, w: colW, h: CGFloat(colH), start: "15:00", end: "20:00", isLast: false)
        
        let t39 = setScheduleTime(topRef: lbSunday, leftRef: lbSaturday, w: colW, h: CGFloat(colH), start: "10:00", end: "12:00", isLast: false)
        let t40 = setScheduleTime(topRef: t39 , leftRef: lbSaturday, w: colW, h: CGFloat(colH), start: "14:00", end: "16:00", isLast: false)
        let t41 = setScheduleTime(topRef: t40 , leftRef: lbSaturday, w: colW, h: CGFloat(colH), start: "18:00", end: "20:00", isLast: false)
        let t42 = setScheduleTime(topRef: t41 , leftRef: lbSaturday, w: colW, h: CGFloat(colH), start: "21:00", end: "23:00", isLast: false)
        let t43 = setScheduleTime(topRef: t42 , leftRef: lbSaturday, w: colW, h: CGFloat(colH), start: "23:00", end: "24:00", isLast: true)
       

    } // fin viewDidload



} // fin ScheduleVC

// MARK- UI Helper
extension ScheduleView {
    func initHeader(str:String)-> UILabel {
        let lb = UILabel()
        self.containerView.addSubview(lb)
//        lb.layer.borderColor = UIColor.red.cgColor
//        lb.layer.borderWidth = 1
        lb.textAlignment = .center
        lb.text = str
        return lb
    }

    // TO refactor
    func setScheduleTime(topRef:UIView,leftRef:UIView, w:CGFloat,h:CGFloat,start:String,end:String,isLast:Bool) -> ScheduleTimeView {
        let t3 = ScheduleTimeView(colW: w, colH: h, startTime: start, endTime: end)
        containerView.addSubview(t3)
        t3.snp.makeConstraints { (make) in
            make.top.equalTo(topRef.snp.bottom).offset(timeTopPadding)
            make.width.equalTo(w)
            make.height.equalTo(h*3)
            make.left.equalTo(leftRef.snp.right).offset(1)
            if isLast == true {
                make.bottom.equalTo(containerView.snp.bottom)
            }
        }
       return t3
    }
}
