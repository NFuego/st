//
//  LoginPresenter.swift
//  Project: momoCustomer
//
//  Module: Login
//
//  By zcon 2017/6/1
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `LoginPresenter` and referenced by `LoginViewController`
protocol LoginViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `LoginPresenter` and referenced by `LoginInteractor`
protocol LoginInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the Login module
final class LoginPresenter {

	// MARK: - Constants

	let router: LoginPresenterRouterProtocol
	let interactor: LoginPresenterInteractorProtocol

	// MARK: Variables

	weak var view: LoginPresenterViewProtocol?

	// MARK: Inits

	init(router: LoginPresenterRouterProtocol, interactor: LoginPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Login View to Presenter Protocol

extension LoginPresenter: LoginViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: Login Interactor to Presenter Protocol

extension LoginPresenter: LoginInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
