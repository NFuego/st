//
//  RootViewController.swift
//  Project: momoStore
//
//  Module: Root
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `RootInteractor` and referenced by `RootPresenter`
protocol RootPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the Root module
class RootViewController: UITabBarController {

	// MARK: - Constants

	let presenter: RootViewPresenterProtocol


	// MARK: Variables


	// MARK: Inits

	init(presenter: RootViewPresenterProtocol) {
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
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = false
		view.backgroundColor = .white
        print(self.tabBar.frame)
         
    }
}


// MARK: - Root Presenter to View Protocol

extension RootViewController: RootPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
