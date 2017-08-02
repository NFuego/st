//
//  AppoinmentsListPresenter.swift
//  Project: momoStore
//
//  Module: AppoinmentsList
//
//  By zcon 2017/3/9
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppoinmentsListPresenter` and referenced by `AppoinmentsListViewController`
protocol AppoinmentsListViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppoinmentsListPresenter` and referenced by `AppoinmentsListInteractor`
protocol AppoinmentsListInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the AppoinmentsList module
final class AppoinmentsListPresenter {

	// MARK: - Constants

	let router: AppoinmentsListPresenterRouterProtocol
	let interactor: AppoinmentsListPresenterInteractorProtocol

	// MARK: Variables

	weak var view: AppoinmentsListPresenterViewProtocol?

	// MARK: Inits

	init(router: AppoinmentsListPresenterRouterProtocol, interactor: AppoinmentsListPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppoinmentsList View to Presenter Protocol

extension AppoinmentsListPresenter: AppoinmentsListViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: AppoinmentsList Interactor to Presenter Protocol

extension AppoinmentsListPresenter: AppoinmentsListInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
