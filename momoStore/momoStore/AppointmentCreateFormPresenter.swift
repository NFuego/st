//
//  AppointmentCreateFormPresenter.swift
//  Project: momoStore
//
//  Module: AppointmentCreateForm
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointmentCreateFormPresenter` and referenced by `AppointmentCreateFormViewController`
protocol AppointmentCreateFormViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppointmentCreateFormPresenter` and referenced by `AppointmentCreateFormInteractor`
protocol AppointmentCreateFormInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the AppointmentCreateForm module
final class AppointmentCreateFormPresenter {

	// MARK: - Constants

	let router: AppointmentCreateFormPresenterRouterProtocol
	let interactor: AppointmentCreateFormPresenterInteractorProtocol


	// MARK: Variables

	weak var view: AppointmentCreateFormPresenterViewProtocol?


	// MARK: Inits

	init(router: AppointmentCreateFormPresenterRouterProtocol, interactor: AppointmentCreateFormPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppointmentCreateForm View to Presenter Protocol

extension AppointmentCreateFormPresenter: AppointmentCreateFormViewPresenterProtocol {

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

// MARK: AppointmentCreateForm Interactor to Presenter Protocol

extension AppointmentCreateFormPresenter: AppointmentCreateFormInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
