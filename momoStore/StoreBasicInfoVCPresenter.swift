//
//  StoreBasicInfoVCPresenter.swift
//  Project: momoStore
//
//  Module: StoreBasicInfoVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreBasicInfoVCPresenter` and referenced by `StoreBasicInfoVCViewController`
protocol StoreBasicInfoVCViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `StoreBasicInfoVCPresenter` and referenced by `StoreBasicInfoVCInteractor`
protocol StoreBasicInfoVCInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the StoreBasicInfoVC module
final class StoreBasicInfoVCPresenter {

	// MARK: - Constants

	let router: StoreBasicInfoVCPresenterRouterProtocol
	let interactor: StoreBasicInfoVCPresenterInteractorProtocol

	// MARK: Variables

	weak var view: StoreBasicInfoVCPresenterViewProtocol?

	// MARK: Inits

	init(router: StoreBasicInfoVCPresenterRouterProtocol, interactor: StoreBasicInfoVCPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - StoreBasicInfoVC View to Presenter Protocol

extension StoreBasicInfoVCPresenter: StoreBasicInfoVCViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: StoreBasicInfoVC Interactor to Presenter Protocol

extension StoreBasicInfoVCPresenter: StoreBasicInfoVCInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
