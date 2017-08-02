//
//  StoreMainInteractor.swift
//  Project: momoCustomer
//
//  Module: StoreMain
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `StoreMainInteractor` and referenced by `StoreMainPresenter`
protocol StoreMainPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the StoreMain module
struct StoreMainInteractor {

	// MARK: - Variables

	weak var presenter: StoreMainInteractorPresenterProtocol?
}

// MARK: - StoreMain Presenter to Interactor Protocol

extension StoreMainInteractor: StoreMainPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "StoreMain")
	}
}
