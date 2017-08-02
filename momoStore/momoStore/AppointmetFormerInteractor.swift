//
//  AppointmetFormerInteractor.swift
//  Project: testt
//
//  Module: AppointmetFormer
//
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointmetFormerInteractor` and referenced by `AppointmetFormerPresenter`
protocol AppointmetFormerPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the AppointmetFormer module
final class AppointmetFormerInteractor {

	// MARK: - Variables

	weak var presenter: AppointmetFormerInteractorPresenterProtocol?
}

// MARK: - AppointmetFormer Presenter to Interactor Protocol

extension AppointmetFormerInteractor: AppointmetFormerPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppointmetFormer")
	}
}
