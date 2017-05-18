// MARK: Imports

import UIKit

import Eureka
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactToMomodiInteractor` and referenced by `ContactToMomodiPresenter`
protocol ContactToMomodiPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the ContactToMomodi module
class ContactToMomodiViewController: FormViewController {

	// MARK: - Constants

	let presenter: ContactToMomodiViewPresenterProtocol

	// MARK: Variables
    func preSet(){
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "聯絡Momodi"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }

	// MARK: Inits

	init(presenter: ContactToMomodiViewPresenterProtocol) {
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
            form +++ Section(header: header!, footer: "")          
                // ========================================================================== loaded zone
                <<< EmailRow() { (s:EmailRow) -> Void in
                    s.tag = "mail"
                    s.title = "郵件"
                    s.title = NSLocalizedString("momodi@contact.com", comment: "")
                }
                
//                <<< ButtonRow() { (b:ButtonRow) -> Void in
//                    b.title = "確認"
//                } .onCellSelection({ (cell, row) in
//
//                }) // cell selection
    } // fin setupForm

}

// MARK: - ContactToMomodi Presenter to View Protocol

extension ContactToMomodiViewController: ContactToMomodiPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
