//
//  StoreShopInteractor.swift
//  Project: momoCustomer
//
//  Module: StoreShop
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreShopInteractor` and referenced by `StoreShopPresenter`
protocol StoreShopPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the StoreShop module
final class StoreShopInteractor {

	// MARK: - Variables

	weak var presenter: StoreShopInteractorPresenterProtocol?
}

// MARK: - StoreShop Presenter to Interactor Protocol

extension StoreShopInteractor: StoreShopPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "StoreShop")
	}
}
