//
//  StoreMainModule.swift
//  Project: momoCustomer
//
//  Module: StoreMain
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the StoreMain VIPER module
final class StoreMainModule {

	// MARK: - Variables

	private(set) lazy var interactor: StoreMainInteractor = {
		return StoreMainInteractor()
	}()

	private(set) lazy var router: StoreMainRouter = {
		return StoreMainRouter()
	}()

	private(set) lazy var presenter: StoreMainPresenter = {
		return StoreMainPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: StoreMainViewController = {
		return StoreMainViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension StoreMainModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
