//
//  WeekInteractor.swift
//  Project: momoStore
//
//  Module: Week
//
//  MomoDidi 2016年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `WeekInteractor` and referenced by `WeekPresenter`
protocol WeekPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Week module
struct WeekInteractor {

	// MARK: - Variables

	weak var presenter: WeekInteractorPresenterProtocol?
}

// MARK: - Week Presenter to Interactor Protocol

extension WeekInteractor: WeekPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Week")
	}
}
