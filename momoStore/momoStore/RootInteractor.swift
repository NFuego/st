//
//  RootInteractor.swift
//  Project: momoStore
//
//  Module: Root
//
//  MomoDidi 2016年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `RootInteractor` and referenced by `RootPresenter`
protocol RootPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Root module
struct RootInteractor {

	// MARK: - Variables

	weak var presenter: RootInteractorPresenterProtocol?
}

// MARK: - Root Presenter to Interactor Protocol

extension RootInteractor: RootPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Root")
	}
}
