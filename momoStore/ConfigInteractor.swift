//
//  ConfigInteractor.swift
//  Project: momoStore
//
//  Module: Config
//
//  MomoDidi 2016年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `ConfigInteractor` and referenced by `ConfigPresenter`
protocol ConfigPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Config module
struct ConfigInteractor {

	// MARK: - Variables

	weak var presenter: ConfigInteractorPresenterProtocol?
}

// MARK: - Config Presenter to Interactor Protocol

extension ConfigInteractor: ConfigPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Config")
	}
}
