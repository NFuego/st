//
//  PermissionVCModule.swift
//  Project: momoStore
//
//  Module: PermissionVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the PermissionVC VIPER module
final class PermissionVCModule {

	// MARK: - Variables

	private(set) lazy var interactor: PermissionVCInteractor = {
		return PermissionVCInteractor()
	}()

	private(set) lazy var router: PermissionVCRouter = {
		return PermissionVCRouter()
	}()

	private(set) lazy var presenter: PermissionVCPresenter = {
		return PermissionVCPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: PermissionVCViewController = {
		return PermissionVCViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension PermissionVCModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
