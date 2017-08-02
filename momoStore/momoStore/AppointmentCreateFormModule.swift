//
//  AppointmentCreateFormModule.swift
//  Project: momoStore
//
//  Module: AppointmentCreateForm
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the AppointmentCreateForm VIPER module
final class AppointmentCreateFormModule {

	// MARK: - Variables

	private(set) lazy var interactor: AppointmentCreateFormInteractor = {
		return AppointmentCreateFormInteractor()
	}()

	private(set) lazy var router: AppointmentCreateFormRouter = {
		return AppointmentCreateFormRouter()
	}()

	private(set) lazy var presenter: AppointmentCreateFormPresenter = {
		return AppointmentCreateFormPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppointmentCreateFormViewController = {
		return AppointmentCreateFormViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppointmentCreateFormModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
