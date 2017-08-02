//
//  CustomerInfoViewController.swift
//  Project: momoCustomer
//
//  Module: CustomerInfo
//
//  By ssstand 20/07/2017
//  MomoDidi 2017
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CustomerInfoInteractor` and referenced by `CustomerInfoPresenter`
protocol CustomerInfoPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the CustomerInfo module
class CustomerInfoViewController: UIViewController {

	// MARK: - Constants

	let presenter: CustomerInfoViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: CustomerInfoViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	 func preSet(){
        self.title = "我的資料"
        Styler.styleNavBar(self)
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
        self.dismiss(animated: true) { 
            
        }
    }
    
    // MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
		presenter.viewLoaded()
        self.title = "我的資料"
        
		view.backgroundColor = .white
        let imv = UIImageView()
        imv.image = UIImage(named:"info")
        
        self.view.addSubview(imv)
        imv.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
//            make.centerequalToSuperview()
        }
    }
}

// MARK: - CustomerInfo Presenter to View Protocol

extension CustomerInfoViewController: CustomerInfoPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
