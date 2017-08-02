//
//  CustomerDayInteractor.swift
//  Project: momoCustomer
//
//  Module: CustomerDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `CustomerDayInteractor` and referenced by `CustomerDayPresenter`
protocol CustomerDayPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the CustomerDay module
struct CustomerDayInteractor {

	// MARK: - Variables

	weak var presenter: CustomerDayInteractorPresenterProtocol?
}

// MARK: - CustomerDay Presenter to Interactor Protocol

extension CustomerDayInteractor: CustomerDayPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "CustomerDay")
	}
}
