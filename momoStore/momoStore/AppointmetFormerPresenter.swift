//
//  AppointmetFormerPresenter.swift
//  Project: testt
//
//  Module: AppointmetFormer
//
//  By zcon 2017/3/9
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointmetFormerPresenter` and referenced by `AppointmetFormerViewController`
protocol AppointmetFormerViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppointmetFormerPresenter` and referenced by `AppointmetFormerInteractor`
protocol AppointmetFormerInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the AppointmetFormer module
final class AppointmetFormerPresenter {

	// MARK: - Constants

	let router: AppointmetFormerPresenterRouterProtocol
	let interactor: AppointmetFormerPresenterInteractorProtocol

	// MARK: Variables

	weak var view: AppointmetFormerPresenterViewProtocol?

	// MARK: Inits

	init(router: AppointmetFormerPresenterRouterProtocol, interactor: AppointmetFormerPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppointmetFormer View to Presenter Protocol

extension AppointmetFormerPresenter: AppointmetFormerViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: AppointmetFormer Interactor to Presenter Protocol

extension AppointmetFormerPresenter: AppointmetFormerInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
