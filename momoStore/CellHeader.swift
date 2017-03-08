import Foundation

import SnapKit

import JTAppleCalendar
class CellHeader : JTAppleHeaderView {
    var dayLabel: UILabel! = UILabel()
    var selectedView: UIView! = UIView()

    func update(){
        self.addSubview(selectedView)
        self.addSubview(dayLabel)
        self.backgroundColor = .black
//        dayLabel.textColor = .yellow
        dayLabel.textAlignment = .center

//        DevKit.displayBorder(comps: [self])
        
        dayLabel.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        selectedView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
//        print("the size of selected view")
//        print( " and its color \(dayLabel.textColor) " )
//        print(selectedView)
        selectedView.backgroundColor = UIColor(hex:"FBFBFB")
//        print(dayLabel)
    }
}

