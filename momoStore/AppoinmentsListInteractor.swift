//
//  AppoinmentsListInteractor.swift
//  Project: momoStore
//
//  Module: AppoinmentsList
//
//  By zcon 2017/3/9
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppoinmentsListInteractor` and referenced by `AppoinmentsListPresenter`
protocol AppoinmentsListPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the AppoinmentsList module
final class AppoinmentsListInteractor {

	// MARK: - Variables

	weak var presenter: AppoinmentsListInteractorPresenterProtocol?
}

// MARK: - AppoinmentsList Presenter to Interactor Protocol

extension AppoinmentsListInteractor: AppoinmentsListPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppoinmentsList")
	}
}
