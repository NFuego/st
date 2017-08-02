//
//  CustomerDayPresenter.swift
//  Project: momoCustomer
//
//  Module: CustomerDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `CustomerDayPresenter` and referenced by `CustomerDayViewController`
protocol CustomerDayViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `CustomerDayPresenter` and referenced by `CustomerDayInteractor`
protocol CustomerDayInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the CustomerDay module
final class CustomerDayPresenter {

	// MARK: - Constants

	let router: CustomerDayPresenterRouterProtocol
	let interactor: CustomerDayPresenterInteractorProtocol


	// MARK: Variables

	weak var view: CustomerDayPresenterViewProtocol?


	// MARK: Inits

	init(router: CustomerDayPresenterRouterProtocol, interactor: CustomerDayPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - CustomerDay View to Presenter Protocol

extension CustomerDayPresenter: CustomerDayViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}

	func viewAppearing() {

	}

	func viewAppeared() {

	}

	func viewDisappeared() {

	}
}

// MARK: CustomerDay Interactor to Presenter Protocol

extension CustomerDayPresenter: CustomerDayInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
