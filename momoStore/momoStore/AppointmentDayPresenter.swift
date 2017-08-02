//
//  AppointmentDayPresenter.swift
//  Project: momoStore
//
//  Module: AppointmentDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointmentDayPresenter` and referenced by `AppointmentDayViewController`
protocol AppointmentDayViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppointmentDayPresenter` and referenced by `AppointmentDayInteractor`
protocol AppointmentDayInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the AppointmentDay module
final class AppointmentDayPresenter {

	// MARK: - Constants

	let router: AppointmentDayPresenterRouterProtocol
	let interactor: AppointmentDayPresenterInteractorProtocol


	// MARK: Variables

	weak var view: AppointmentDayPresenterViewProtocol?


	// MARK: Inits

	init(router: AppointmentDayPresenterRouterProtocol, interactor: AppointmentDayPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppointmentDay View to Presenter Protocol

extension AppointmentDayPresenter: AppointmentDayViewPresenterProtocol {

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

// MARK: AppointmentDay Interactor to Presenter Protocol

extension AppointmentDayPresenter: AppointmentDayInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
