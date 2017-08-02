//
//  StoreMainPresenter.swift
//  Project: momoCustomer
//
//  Module: StoreMain
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `StoreMainPresenter` and referenced by `StoreMainViewController`
protocol StoreMainViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `StoreMainPresenter` and referenced by `StoreMainInteractor`
protocol StoreMainInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the StoreMain module
final class StoreMainPresenter {

	// MARK: - Constants

	let router: StoreMainPresenterRouterProtocol
	let interactor: StoreMainPresenterInteractorProtocol


	// MARK: Variables

	weak var view: StoreMainPresenterViewProtocol?


	// MARK: Inits

	init(router: StoreMainPresenterRouterProtocol, interactor: StoreMainPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - StoreMain View to Presenter Protocol

extension StoreMainPresenter: StoreMainViewPresenterProtocol {

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

// MARK: StoreMain Interactor to Presenter Protocol

extension StoreMainPresenter: StoreMainInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
