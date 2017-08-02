//
//  WeekPresenter.swift
//  Project: momoStore
//
//  Module: Week
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `WeekPresenter` and referenced by `WeekViewController`
protocol WeekViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `WeekPresenter` and referenced by `WeekInteractor`
protocol WeekInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Week module
final class WeekPresenter {

	// MARK: - Constants

	let router: WeekPresenterRouterProtocol
	let interactor: WeekPresenterInteractorProtocol


	// MARK: Variables

	weak var view: WeekPresenterViewProtocol?


	// MARK: Inits

	init(router: WeekPresenterRouterProtocol, interactor: WeekPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Week View to Presenter Protocol

extension WeekPresenter: WeekViewPresenterProtocol {

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

// MARK: Week Interactor to Presenter Protocol

extension WeekPresenter: WeekInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
