//
//  ConfigViewController.swift
//  Project: momoStore
//
//  Module: Config
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER
import Eureka


// MARK: Protocols

/// Should be conformed to by the `ConfigInteractor` and referenced by `ConfigPresenter`
protocol ConfigPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the Config module
class ConfigViewController: FormViewController {

	// MARK: - Constants

	let presenter: ConfigViewPresenterProtocol


	// MARK: Variables
    let scheduleVC = ScheduleVC()


	// MARK: Inits

	init(presenter: ConfigViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
        setup()
        
    } // fin viewDidLoad

    func setup(){
        self.title = "設定"
        let navColor = UIColor(colorLiteralRed: 1, green: 64/255.0, blue: 129/255.0, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = navColor
        self.navigationController?.navigationBar.tintColor = .white
//        self.edgesForExtendedLayout = .top
//        self.extendedLayoutIncludesOpaqueBars = true
//        self.navigationController?.edgesForExtendedLayout = .top
//        self.navigationController?.extendedLayoutIncludesOpaqueBars = true
        
        self.navigationController?.toolbar.barStyle = .default // this make it appears
		view.backgroundColor = .white  // Loading
        
        
//        設定可預約時間(商家使用第一次設定, faq,權限, 推播）
        
        form +++ Section(header:"頁面設定",footer:"")//"店面資料設定")
            <<< ButtonRow(){ row in
                row.title = "首頁頁面設定"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
            })
            <<< ButtonRow(){ row in
                row.title = "公告頁面設定"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
            })
            <<< ButtonRow(){ row in
                row.title = "公告/協尋 頁面設定"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
            })
            
            +++ Section(header: "資料設定", footer: "")
            <<< ButtonRow(){ row in
                row.title = "基本資料"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
                
                let target = StoreBasicInfoVCModule().view
                let nscv = UINavigationController(rootViewController: target)
                self.navigationController?.present(nscv, animated: true     // with tab
                    , completion: {
                })
            })
            <<< ButtonRow(){ row in
                row.title = "營業項目"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
//                let nscv = UINavigationController(rootViewController: self.scheduleVC )
//                self.navigationController?.present(nscv, animated: true     // with tab
//                    , completion: {
//                })
            })
            <<< ButtonRow(){ row in
                row.title = "助理權限設定"
            }.onCellSelection({ (_,row) in
                let target = PermissionVCModule().view
                let nscv = UINavigationController(rootViewController: target)
                self.navigationController?.present(nscv, animated: true     // with tab
                    , completion: {
                })
            })
            <<< ButtonRow(){ row in
                row.title = "編寫常問問題"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
//                let nscv = UINavigationController(rootViewController: self.scheduleVC )
//                self.navigationController?.present(nscv, animated: true     // with tab
//                    , completion: {
//                })
            })
            <<< ButtonRow(){ row in
                row.title = "發送推播"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
//                let nscv = UINavigationController(rootViewController: self.scheduleVC )
//                self.navigationController?.present(nscv, animated: true     // with tab
//                    , completion: {
//                })
            })
            +++ Section(header: "資料設定", footer: "")
            <<< ButtonRow(){ row in
                row.title = "聯絡Momodi"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
                
                let target = ContactToMomodiModule().view
                let nscv = UINavigationController(rootViewController: target)
                self.navigationController?.present(nscv, animated: true     // with tab
                    , completion: {
                })
            })
            <<< ButtonRow(){ row in
                row.title = "App 使用教學"
            }.onCellSelection({ (_,row) in
//                print("pressed")
//                print(row.title)
//                let nscv = UINavigationController(rootViewController: self.scheduleVC )
//                self.navigationController?.present(nscv, animated: true     // with tab
//                    , completion: {
//                })
            })
    } // fin setup
    
}


// MARK: - Config Presenter to View Protocol
extension ConfigViewController: ConfigPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}
