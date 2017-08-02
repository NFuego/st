//
//  AdvertisementPresenter.swift
//  Project: T2
//
//  Module: Advertisement
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AdvertisementPresenter` and referenced by `AdvertisementViewController`
protocol AdvertisementViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AdvertisementPresenter` and referenced by `AdvertisementInteractor`
protocol AdvertisementInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the Advertisement module
final class AdvertisementPresenter {

	// MARK: - Constants

	let router: AdvertisementPresenterRouterProtocol
	let interactor: AdvertisementPresenterInteractorProtocol

	// MARK: Variables

	weak var view: AdvertisementPresenterViewProtocol?

	// MARK: Inits

	init(router: AdvertisementPresenterRouterProtocol, interactor: AdvertisementPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Advertisement View to Presenter Protocol

extension AdvertisementPresenter: AdvertisementViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: Advertisement Interactor to Presenter Protocol

extension AdvertisementPresenter: AdvertisementInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
