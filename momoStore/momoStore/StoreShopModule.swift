//
//  StoreShopModule.swift
//  Project: momoCustomer
//
//  Module: StoreShop
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the StoreShop VIPER module
final class StoreShopModule {

	// MARK: - Variables

	private(set) lazy var interactor: StoreShopInteractor = {
		return StoreShopInteractor()
	}()

	private(set) lazy var router: StoreShopRouter = {
		return StoreShopRouter()
	}()

	private(set) lazy var presenter: StoreShopPresenter = {
		return StoreShopPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: StoreShopViewController = {
		return StoreShopViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension StoreShopModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
