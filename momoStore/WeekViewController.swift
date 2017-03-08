//
//  WeekViewController.swift
//  Project: momoStore
//
//  Module: Week
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `WeekInteractor` and referenced by `WeekPresenter`
protocol WeekPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the Week module
class WeekViewController: UIViewController {

	// MARK: - Constants

	let presenter: WeekViewPresenterProtocol


	// MARK: Variables


	// MARK: Inits

	init(presenter: WeekViewPresenterProtocol) {
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
    }
}


// MARK: - Week Presenter to View Protocol

extension WeekViewController: WeekPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
