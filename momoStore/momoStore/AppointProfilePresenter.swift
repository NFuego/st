//
//  AppointProfilePresenter.swift
//  Project: momoStore
//
//  Module: AppointProfile
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointProfilePresenter` and referenced by `AppointProfileViewController`
protocol AppointProfileViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppointProfilePresenter` and referenced by `AppointProfileInteractor`
protocol AppointProfileInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the AppointProfile module
final class AppointProfilePresenter {

	// MARK: - Constants

	let router: AppointProfilePresenterRouterProtocol
	let interactor: AppointProfilePresenterInteractorProtocol


	// MARK: Variables

	weak var view: AppointProfilePresenterViewProtocol?


	// MARK: Inits

	init(router: AppointProfilePresenterRouterProtocol, interactor: AppointProfilePresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppointProfile View to Presenter Protocol

extension AppointProfilePresenter: AppointProfileViewPresenterProtocol {

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

// MARK: AppointProfile Interactor to Presenter Protocol

extension AppointProfilePresenter: AppointProfileInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
