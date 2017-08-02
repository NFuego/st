//

import Foundation
import UIKit
import SnapKit

class ScheduleVC : UIViewController {

    let scheduleTitle = ScheduleTitleVC()
//    let scheduleTitle = UINavigationController(rootViewController: ScheduleTitleVC() )
    let scheduleView = ScheduleView()

    override func viewDidLoad() {
        let fullScreenSize = UIScreen.main.bounds.size
        self.edgesForExtendedLayout = .top
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.toolbar.barStyle = .default // this make it appears
        
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "FF4081")
        self.navigationController?.navigationBar.tintColor = .white

//		view.backgroundColor = hexStringToUIColor(hex: "#FFCEB5")
//        view.backgroundColor = UIColor(colorLiteralRed: 241/255.0, green: 207/255.0, blue: 203/255.0, alpha: 1.0)

        self.addChildViewController(scheduleTitle)
        self.view.addSubview(scheduleTitle.view)
        scheduleTitle.didMove(toParentViewController: self)
        scheduleTitle.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.width.equalTo(fullScreenSize.width)
            make.height.equalTo(150)
        }

//        self.view.addSubview(scheduleView)
//        scheduleView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.scheduleTitle.view.snp.bottom)
//            make.leading.equalTo(0)
//            make.trailing.equalTo(0)
//            make.bottom.equalTo(self.view)
//        }
    } // fin viewDidLoad

    func back(){
        self.dismiss(animated: true) {
            
        }
    } // fin bacj
}

enum Weekday {
    case monday
    case tuesday
    case wednsday
    case thursday
    case friday
    case saturday
    case sunday
}
extension ScheduleVC {
}
