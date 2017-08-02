//
//  RootPresenter.swift
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

/// Should be conformed to by the `RootPresenter` and referenced by `RootViewController`
protocol RootViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `RootPresenter` and referenced by `RootInteractor`
protocol RootInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Root module
final class RootPresenter {

	// MARK: - Constants

	let router: RootPresenterRouterProtocol
	let interactor: RootPresenterInteractorProtocol


	// MARK: Variables

	weak var view: RootPresenterViewProtocol?


	// MARK: Inits

	init(router: RootPresenterRouterProtocol, interactor: RootPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Root View to Presenter Protocol

extension RootPresenter: RootViewPresenterProtocol {

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

// MARK: Root Interactor to Presenter Protocol

extension RootPresenter: RootInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
