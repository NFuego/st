
// MARK: Imports

import UIKit

import Eureka
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PermissionVCInteractor` and referenced by `PermissionVCPresenter`
protocol PermissionVCPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the PermissionVC module
class PermissionVCViewController: FormViewController {

	// MARK: - Constants

	let presenter: PermissionVCViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits
    func preSet(){
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "助理權限設定"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }

	init(presenter: PermissionVCViewPresenterProtocol) {
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
        self.preSet()
		view.backgroundColor = .white
        self.setupForm()
    }
    
    func setupForm(){
        let header = self.title
        /*
                    助理不能查看報表
                    Admin 有一開關能設置讓助理使用編輯桌面，佈告欄與廣告
         */
            form +++ Section(header: header!, footer: "")          
                // ========================================================================== loaded zone
                <<< SwitchRow() { (s:SwitchRow) -> Void in
                    s.tag = "chart"
                    s.title = NSLocalizedString("允許助理查看報表", comment: "")
                }
                <<< SwitchRow() { (s:SwitchRow) -> Void in
                    s.tag = "edit"
                    s.title = NSLocalizedString("允許助理編輯頁面", comment: "")
                }
                
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = "確認"
                } .onCellSelection({ (cell, row) in

                }) // cell selection
    } // fin setupForm
}

// MARK: - PermissionVC Presenter to View Protocol

extension PermissionVCViewController: PermissionVCPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
