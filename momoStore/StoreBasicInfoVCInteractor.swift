//
//  StoreBasicInfoVCInteractor.swift
//  Project: momoStore
//
//  Module: StoreBasicInfoVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreBasicInfoVCInteractor` and referenced by `StoreBasicInfoVCPresenter`
protocol StoreBasicInfoVCPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the StoreBasicInfoVC module
final class StoreBasicInfoVCInteractor {

	// MARK: - Variables

	weak var presenter: StoreBasicInfoVCInteractorPresenterProtocol?
}

// MARK: - StoreBasicInfoVC Presenter to Interactor Protocol

extension StoreBasicInfoVCInteractor: StoreBasicInfoVCPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "StoreBasicInfoVC")
	}
}
