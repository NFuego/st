//
//  AppointStoreMonthModule.swift
//  Project: momoCustomer
//
//  Module: AppointStoreMonth
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the AppointStoreMonth VIPER module
final class AppointStoreMonthModule {

	// MARK: - Variables

	private(set) lazy var interactor: AppointStoreMonthInteractor = {
		return AppointStoreMonthInteractor()
	}()

	private(set) lazy var router: AppointStoreMonthRouter = {
		return AppointStoreMonthRouter()
	}()

	private(set) lazy var presenter: AppointStoreMonthPresenter = {
		return AppointStoreMonthPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppointStoreMonthViewController = {
		return AppointStoreMonthViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppointStoreMonthModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
