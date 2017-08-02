//
//  AppointProfileModule.swift
//  Project: momoStore
//
//  Module: AppointProfile
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the AppointProfile VIPER module
final class AppointProfileModule {

	// MARK: - Variables

	private(set) lazy var interactor: AppointProfileInteractor = {
		return AppointProfileInteractor()
	}()

	private(set) lazy var router: AppointProfileRouter = {
		return AppointProfileRouter()
	}()

	private(set) lazy var presenter: AppointProfilePresenter = {
		return AppointProfilePresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppointProfileViewController = {
		return AppointProfileViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppointProfileModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
