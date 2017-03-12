//
//  AppointmentDayInteractor.swift
//  Project: momoStore
//
//  Module: AppointmentDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointmentDayInteractor` and referenced by `AppointmentDayPresenter`
protocol AppointmentDayPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the AppointmentDay module
struct AppointmentDayInteractor {

	// MARK: - Variables

	weak var presenter: AppointmentDayInteractorPresenterProtocol?
}

// MARK: - AppointmentDay Presenter to Interactor Protocol

extension AppointmentDayInteractor: AppointmentDayPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppointmentDay")
	}
}
