//
//  AppointmentDayModule.swift
//  Project: momoStore
//
//  Module: AppointmentDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the AppointmentDay VIPER module
final class AppointmentDayModule {

	// MARK: - Variables

	private(set) lazy var interactor: AppointmentDayInteractor = {
		return AppointmentDayInteractor()
	}()

	private(set) lazy var router: AppointmentDayRouter = {
		return AppointmentDayRouter()
	}()

	private(set) lazy var presenter: AppointmentDayPresenter = {
		return AppointmentDayPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppointmentDayViewController = {
		return AppointmentDayViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppointmentDayModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
