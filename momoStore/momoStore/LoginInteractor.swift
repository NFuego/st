//
//  LoginInteractor.swift
//  Project: momoCustomer
//
//  Module: Login
//
//  By zcon 2017/6/1
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `LoginInteractor` and referenced by `LoginPresenter`
protocol LoginPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the Login module
final class LoginInteractor {

	// MARK: - Variables

	weak var presenter: LoginInteractorPresenterProtocol?
}

// MARK: - Login Presenter to Interactor Protocol

extension LoginInteractor: LoginPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Login")
	}
}
