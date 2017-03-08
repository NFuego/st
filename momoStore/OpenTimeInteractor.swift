//
//  OpenTimeInteractor.swift
//  Project: momoStore
//
//  Module: OpenTime
//
//  By SSStand 29/12/2016
//  MomoDidi 2016
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `OpenTimeInteractor` and referenced by `OpenTimePresenter`
protocol OpenTimePresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the OpenTime module
final class OpenTimeInteractor {

	// MARK: - Variables

	weak var presenter: OpenTimeInteractorPresenterProtocol?
}

// MARK: - OpenTime Presenter to Interactor Protocol

extension OpenTimeInteractor: OpenTimePresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "OpenTime")
	}
}
