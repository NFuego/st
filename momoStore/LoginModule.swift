//
//  LoginModule.swift
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

// MARK: -

/// Used to initialize the Login VIPER module
final class LoginModule {

	// MARK: - Variables

	private(set) lazy var interactor: LoginInteractor = {
		return LoginInteractor()
	}()

	private(set) lazy var router: LoginRouter = {
		return LoginRouter()
	}()

	private(set) lazy var presenter: LoginPresenter = {
		return LoginPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: LoginViewController = {
		return LoginViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension LoginModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
