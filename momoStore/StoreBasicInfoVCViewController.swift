//

// MARK: Imports

import UIKit
import Eureka

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreBasicInfoVCInteractor` and referenced by `StoreBasicInfoVCPresenter`
protocol StoreBasicInfoVCPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the StoreBasicInfoVC module
class StoreBasicInfoVCViewController: FormViewController  {

	// MARK: - Constants

	let presenter: StoreBasicInfoVCViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits
    func preSet(){
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "商家基本資料"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }

	init(presenter: StoreBasicInfoVCViewPresenterProtocol) {
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
         */
            form +++ Section(header: header!, footer: "此項所留資訊將在商家首頁出現")
                // ========================================================================== loaded zone
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "open_time"
                    s.title = NSLocalizedString("營業時間", comment: "")
                }
                
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "address"
                    s.title = NSLocalizedString("地址", comment: "")
                }
                
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "site"
                    s.title = NSLocalizedString("網站地址", comment: "")
                }
                
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "fanpage"
                    s.title = NSLocalizedString("粉絲團", comment: "")
                }
                
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "phone"
                    s.title = NSLocalizedString("聯絡電話（市話）", comment: "")
                }
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "mobile"
                    s.title = NSLocalizedString("聯絡電話（手機）", comment: "")
                }
                
                <<< TextRow() { (s:TextRow) -> Void in
                    s.tag = "description"
                    s.title = NSLocalizedString("備註", comment: "")
                }
                
                
                
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = "確認"
                } .onCellSelection({ (cell, row) in

                }) // cell selection
    } // fin setupForm
}

// MARK: - StoreBasicInfoVC Presenter to View Protocol

extension StoreBasicInfoVCViewController: StoreBasicInfoVCPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
