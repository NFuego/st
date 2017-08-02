//
//  AppointStoreMonthInteractor.swift
//  Project: momoCustomer
//
//  Module: AppointStoreMonth
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointStoreMonthInteractor` and referenced by `AppointStoreMonthPresenter`
protocol AppointStoreMonthPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the AppointStoreMonth module
struct AppointStoreMonthInteractor {

	// MARK: - Variables

	weak var presenter: AppointStoreMonthInteractorPresenterProtocol?
}

// MARK: - AppointStoreMonth Presenter to Interactor Protocol

extension AppointStoreMonthInteractor: AppointStoreMonthPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppointStoreMonth")
	}
}
