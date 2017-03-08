//
//  DayInteractor.swift
//  Project: momoStore
//
//  Module: Day
//
//  MomoDidi 2016年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `DayInteractor` and referenced by `DayPresenter`
protocol DayPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Day module
struct DayInteractor {

	// MARK: - Variables

	weak var presenter: DayInteractorPresenterProtocol?
}

// MARK: - Day Presenter to Interactor Protocol

extension DayInteractor: DayPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Day")
	}
}
