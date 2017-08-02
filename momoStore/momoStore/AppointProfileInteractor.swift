//
//  AppointProfileInteractor.swift
//  Project: momoStore
//
//  Module: AppointProfile
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointProfileInteractor` and referenced by `AppointProfilePresenter`
protocol AppointProfilePresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the AppointProfile module
struct AppointProfileInteractor {

	// MARK: - Variables

	weak var presenter: AppointProfileInteractorPresenterProtocol?
}

// MARK: - AppointProfile Presenter to Interactor Protocol

extension AppointProfileInteractor: AppointProfilePresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppointProfile")
	}
}
