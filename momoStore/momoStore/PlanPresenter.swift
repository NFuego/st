//
//  PlanPresenter.swift
//  Project: momoCustomer
//
//  Module: Plan
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `PlanPresenter` and referenced by `PlanViewController`
protocol PlanViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `PlanPresenter` and referenced by `PlanInteractor`
protocol PlanInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Plan module
final class PlanPresenter {

	// MARK: - Constants

	let router: PlanPresenterRouterProtocol
	let interactor: PlanPresenterInteractorProtocol


	// MARK: Variables

	weak var view: PlanPresenterViewProtocol?


	// MARK: Inits

	init(router: PlanPresenterRouterProtocol, interactor: PlanPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Plan View to Presenter Protocol

extension PlanPresenter: PlanViewPresenterProtocol {

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

// MARK: Plan Interactor to Presenter Protocol

extension PlanPresenter: PlanInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
