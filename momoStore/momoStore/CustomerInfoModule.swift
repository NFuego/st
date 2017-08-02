//
//  CustomerInfoModule.swift
//  Project: momoCustomer
//
//  Module: CustomerInfo
//
//  By ssstand 20/07/2017
//  MomoDidi 2017
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the CustomerInfo VIPER module
final class CustomerInfoModule {

	// MARK: - Variables

	private(set) lazy var interactor: CustomerInfoInteractor = {
		return CustomerInfoInteractor()
	}()

	private(set) lazy var router: CustomerInfoRouter = {
		return CustomerInfoRouter()
	}()

	private(set) lazy var presenter: CustomerInfoPresenter = {
		return CustomerInfoPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: CustomerInfoViewController = {
		return CustomerInfoViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension CustomerInfoModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
