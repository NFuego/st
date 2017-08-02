//
//  StoreShopPresenter.swift
//  Project: momoCustomer
//
//  Module: StoreShop
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreShopPresenter` and referenced by `StoreShopViewController`
protocol StoreShopViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `StoreShopPresenter` and referenced by `StoreShopInteractor`
protocol StoreShopInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the StoreShop module
final class StoreShopPresenter {

	// MARK: - Constants

	let router: StoreShopPresenterRouterProtocol
	let interactor: StoreShopPresenterInteractorProtocol

	// MARK: Variables

	weak var view: StoreShopPresenterViewProtocol?

	// MARK: Inits

	init(router: StoreShopPresenterRouterProtocol, interactor: StoreShopPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - StoreShop View to Presenter Protocol

extension StoreShopPresenter: StoreShopViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: StoreShop Interactor to Presenter Protocol

extension StoreShopPresenter: StoreShopInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
