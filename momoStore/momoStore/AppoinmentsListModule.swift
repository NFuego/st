//
//  AppoinmentsListModule.swift
//  Project: momoStore
//
//  Module: AppoinmentsList
//
//  By zcon 2017/3/9
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the AppoinmentsList VIPER module
final public class AppoinmentsListModule {

	// MARK: - Variables
	private(set) lazy var interactor: AppoinmentsListInteractor = {
		return AppoinmentsListInteractor()
	}()

	private(set) lazy var router: AppoinmentsListRouter = {
		return AppoinmentsListRouter()
	}()

	private(set) lazy var presenter: AppoinmentsListPresenter = {
		return AppoinmentsListPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppoinmentsListViewController = {
		return AppoinmentsListViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppoinmentsListModule: ModuleProtocol {
	public var viewController: UIViewController { return view }
}
