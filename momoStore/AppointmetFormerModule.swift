//
//  AppointmetFormerModule.swift
//  Project: testt
//
//  Module: AppointmetFormer
//
//  By zcon 2017/3/9
//  test 2017年
//

// MARK: Imports
import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the AppointmetFormer VIPER module
final class AppointmetFormerModule {

	// MARK: - Variables
	private(set) lazy var interactor: AppointmetFormerInteractor = {
		return AppointmetFormerInteractor()
	}()

	private(set) lazy var router: AppointmetFormerRouter = {
		return AppointmetFormerRouter()
	}()

	private(set) lazy var presenter: AppointmetFormerPresenter = {
		return AppointmetFormerPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppointmetFormerViewController = {
		return AppointmetFormerViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppointmetFormerModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
