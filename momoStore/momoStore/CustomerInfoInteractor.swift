//
//  CustomerInfoInteractor.swift
//  Project: momoCustomer
//
//  Module: CustomerInfo
//
//  By ssstand 20/07/2017
//  MomoDidi 2017
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CustomerInfoInteractor` and referenced by `CustomerInfoPresenter`
protocol CustomerInfoPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the CustomerInfo module
final class CustomerInfoInteractor {

	// MARK: - Variables

	weak var presenter: CustomerInfoInteractorPresenterProtocol?
}

// MARK: - CustomerInfo Presenter to Interactor Protocol

extension CustomerInfoInteractor: CustomerInfoPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "CustomerInfo")
	}
}
