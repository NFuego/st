//
//  ConfigPresenter.swift
//  Project: momoStore
//
//  Module: Config
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `ConfigPresenter` and referenced by `ConfigViewController`
protocol ConfigViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `ConfigPresenter` and referenced by `ConfigInteractor`
protocol ConfigInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Config module
final class ConfigPresenter {

	// MARK: - Constants

	let router: ConfigPresenterRouterProtocol
	let interactor: ConfigPresenterInteractorProtocol


	// MARK: Variables

	weak var view: ConfigPresenterViewProtocol?


	// MARK: Inits

	init(router: ConfigPresenterRouterProtocol, interactor: ConfigPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Config View to Presenter Protocol

extension ConfigPresenter: ConfigViewPresenterProtocol {

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

// MARK: Config Interactor to Presenter Protocol

extension ConfigPresenter: ConfigInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
