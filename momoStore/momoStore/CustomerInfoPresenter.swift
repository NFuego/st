//
//  CustomerInfoPresenter.swift
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

/// Should be conformed to by the `CustomerInfoPresenter` and referenced by `CustomerInfoViewController`
protocol CustomerInfoViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `CustomerInfoPresenter` and referenced by `CustomerInfoInteractor`
protocol CustomerInfoInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the CustomerInfo module
final class CustomerInfoPresenter {

	// MARK: - Constants

	let router: CustomerInfoPresenterRouterProtocol
	let interactor: CustomerInfoPresenterInteractorProtocol

	// MARK: Variables

	weak var view: CustomerInfoPresenterViewProtocol?

	// MARK: Inits

	init(router: CustomerInfoPresenterRouterProtocol, interactor: CustomerInfoPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - CustomerInfo View to Presenter Protocol

extension CustomerInfoPresenter: CustomerInfoViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: CustomerInfo Interactor to Presenter Protocol

extension CustomerInfoPresenter: CustomerInfoInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
