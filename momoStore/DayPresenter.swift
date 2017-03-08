//
//  DayPresenter.swift
//  Project: momoStore
//
//  Module: Day
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `DayPresenter` and referenced by `DayViewController`
protocol DayViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `DayPresenter` and referenced by `DayInteractor`
protocol DayInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Day module
final class DayPresenter {

	// MARK: - Constants

	let router: DayPresenterRouterProtocol
	let interactor: DayPresenterInteractorProtocol


	// MARK: Variables

	weak var view: DayPresenterViewProtocol?


	// MARK: Inits

	init(router: DayPresenterRouterProtocol, interactor: DayPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Day View to Presenter Protocol

extension DayPresenter: DayViewPresenterProtocol {

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

// MARK: Day Interactor to Presenter Protocol

extension DayPresenter: DayInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
