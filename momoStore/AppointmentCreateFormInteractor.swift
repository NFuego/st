//
//  AppointmentCreateFormInteractor.swift
//  Project: momoStore
//
//  Module: AppointmentCreateForm
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointmentCreateFormInteractor` and referenced by `AppointmentCreateFormPresenter`
protocol AppointmentCreateFormPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the AppointmentCreateForm module
struct AppointmentCreateFormInteractor {

	// MARK: - Variables

	weak var presenter: AppointmentCreateFormInteractorPresenterProtocol?
}

// MARK: - AppointmentCreateForm Presenter to Interactor Protocol

extension AppointmentCreateFormInteractor: AppointmentCreateFormPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppointmentCreateForm")
	}
}
