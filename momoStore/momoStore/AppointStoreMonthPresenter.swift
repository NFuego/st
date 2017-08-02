//
//  AppointStoreMonthPresenter.swift
//  Project: momoCustomer
//
//  Module: AppointStoreMonth
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointStoreMonthPresenter` and referenced by `AppointStoreMonthViewController`
protocol AppointStoreMonthViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppointStoreMonthPresenter` and referenced by `AppointStoreMonthInteractor`
protocol AppointStoreMonthInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the AppointStoreMonth module
final class AppointStoreMonthPresenter {

	// MARK: - Constants

	let router: AppointStoreMonthPresenterRouterProtocol
	let interactor: AppointStoreMonthPresenterInteractorProtocol


	// MARK: Variables

	weak var view: AppointStoreMonthPresenterViewProtocol?


	// MARK: Inits

	init(router: AppointStoreMonthPresenterRouterProtocol, interactor: AppointStoreMonthPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppointStoreMonth View to Presenter Protocol

extension AppointStoreMonthPresenter: AppointStoreMonthViewPresenterProtocol {

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

// MARK: AppointStoreMonth Interactor to Presenter Protocol

extension AppointStoreMonthPresenter: AppointStoreMonthInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
