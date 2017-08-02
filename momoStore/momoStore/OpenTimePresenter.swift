//
//  OpenTimePresenter.swift
//  Project: momoStore
//
//  Module: OpenTime
//
//  By SSStand 29/12/2016
//  MomoDidi 2016
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `OpenTimePresenter` and referenced by `OpenTimeViewController`
protocol OpenTimeViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `OpenTimePresenter` and referenced by `OpenTimeInteractor`
protocol OpenTimeInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the OpenTime module
final class OpenTimePresenter {

	// MARK: - Constants

	let router: OpenTimePresenterRouterProtocol
	let interactor: OpenTimePresenterInteractorProtocol


	// MARK: Variables

	weak var view: OpenTimePresenterViewProtocol?


	// MARK: Inits

	init(router: OpenTimePresenterRouterProtocol, interactor: OpenTimePresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - OpenTime View to Presenter Protocol

extension OpenTimePresenter: OpenTimeViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: OpenTime Interactor to Presenter Protocol

extension OpenTimePresenter: OpenTimeInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
