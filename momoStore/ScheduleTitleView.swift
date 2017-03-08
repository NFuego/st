//
//  ScheduleTitle.swift
//  ShenZou
//
//  Created by zcon on 2016/12/27.
//  Copyright © 2016年 zcon. All rights reserved.
//

import UIKit

class ScheduleTitleVC : UIViewController {
    
    var lbMonday:UIImageView!
    var lbTuesday:UIImageView!
    var lbWednesday:UIImageView!
    var lbThursday:UIImageView!
    var lbFriday:UIImageView!
    var lbSaturday:UIImageView!
    var lbSunday:UIImageView!

    let openTimeVC = OpenTimeModule().view

    let colPadding:CGFloat = 1
    let topPadding = 95

    let imgCheck = UIImage(imageLiteralResourceName: "ic_check")
    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override init (frame : CGRect) {
//        super.init(frame : frame)
//    }

//    convenience init () {
    override func viewDidLoad() {
//        self.init(frame:CGRect.zero)
        let fullScreenSize = UIScreen.main.bounds.size
        let colPadding:CGFloat = 1
        let cols:CGFloat = 7
        let colW = (fullScreenSize.width - (colPadding * (cols + 1))) / cols
        let colH = 30
        self.view.backgroundColor = .white

        lbMonday = initImv(isChecked: true)
        lbMonday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
//            make.left.equalTo(lbSaturday.snp.right).offset(colPadding)
            make.leading.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbTuesday = initImv(isChecked: true)
        lbTuesday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
            make.left.equalTo(lbMonday.snp.right).offset(colPadding)
//            make.leading.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbWednesday = initImv(isChecked: true)
        lbWednesday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
            make.left.equalTo(lbTuesday.snp.right).offset(colPadding)
//            make.leading.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbThursday = initImv(isChecked: true)
        lbThursday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
            make.left.equalTo(lbWednesday.snp.right).offset(colPadding)
//            make.leading.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbFriday = initImv(isChecked: true)
        lbFriday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
            make.left.equalTo(lbThursday.snp.right).offset(colPadding)
//            make.leading.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbSaturday = initImv(isChecked: false)
        lbSaturday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
            make.left.equalTo(lbFriday.snp.right).offset(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }

        lbSunday = initImv(isChecked: true)
        lbSunday.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(topPadding)
//            make.left.equalTo(lbMonday.snp.right).offset(colPadding)
            make.trailing.equalTo(colPadding)
            make.width.equalTo(colW)
            make.height.equalTo(colH)
        }
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(self.configTime))
        tapG.numberOfTapsRequired = 1
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(self.configTime2))
        tapG2.numberOfTapsRequired = 1
        let tapG3 = UITapGestureRecognizer(target: self, action: #selector(self.configTime3))
        tapG3.numberOfTapsRequired = 1
        let tapG4 = UITapGestureRecognizer(target: self, action: #selector(self.configTime4))
        tapG4.numberOfTapsRequired = 1
        let tapG5 = UITapGestureRecognizer(target: self, action: #selector(self.configTime5))
        tapG5.numberOfTapsRequired = 1
        let tapG6 = UITapGestureRecognizer(target: self, action: #selector(self.configTime6))
        tapG6.numberOfTapsRequired = 1
        let tapG7 = UITapGestureRecognizer(target: self, action: #selector(self.configTime7))
        tapG7.numberOfTapsRequired = 1
        
        lbMonday.addGestureRecognizer(tapG)
        lbTuesday.addGestureRecognizer(tapG2)
        lbWednesday.addGestureRecognizer(tapG3)
        lbThursday.addGestureRecognizer(tapG4)
        lbFriday.addGestureRecognizer(tapG5)
        lbSaturday.addGestureRecognizer(tapG6)
        lbSunday.addGestureRecognizer(tapG7)
    }
} // fin ScheduleTitleView

// MARK- UI Helper
extension ScheduleTitleVC {
//    func initHeader(str:String)-> UILabel {
//        let lb = UILabel()
//        self.addSubview(lb)
////        lb.layer.borderColor = UIColor.red.cgColor
////        lb.layer.borderWidth = 1
//        lb.textAlignment = .center
//        lb.text = str
//        return lb
//    }

    func initImv(isChecked:Bool)-> UIImageView {
        let b = UIImageView()
        b.isUserInteractionEnabled = true
        self.view.addSubview(b)
        b.image = imgCheck
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 0.5
        return b
    }
    
    func configTime(){
        print("config \(self.parent)")
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        openTimeVC.dayOfWeek = .Monday
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
    func configTime2(){
        print("config \(self.parent)")
        openTimeVC.dayOfWeek = .Tuesday
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
    func configTime3(){
        print("config \(self.parent)")
        openTimeVC.dayOfWeek = .Wednesday
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
    func configTime4(){
        print("config \(self.parent)")
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        openTimeVC.dayOfWeek = .Thursday
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
    func configTime5(){
        print("config \(self.parent)  5")
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        openTimeVC.dayOfWeek = .Friday
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
    func configTime6(){
        print("config \(self.parent)")
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        openTimeVC.dayOfWeek = .Saturday
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
    func configTime7(){
        print("config \(self.parent)")
//        self.navigationController?.pushViewController(openTimeVC, animated: true)
        openTimeVC.dayOfWeek = .Sunday
        self.parent?.present(openTimeVC, animated: true, completion: { 
            
        })
    }
}
