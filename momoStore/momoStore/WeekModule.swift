//
//  WeekModule.swift
//  Project: momoStore
//
//  Module: Week
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the Week VIPER module
final class WeekModule {

	// MARK: - Variables

	private(set) lazy var interactor: WeekInteractor = {
		return WeekInteractor()
	}()

	private(set) lazy var router: WeekRouter = {
		return WeekRouter()
	}()

	private(set) lazy var presenter: WeekPresenter = {
		return WeekPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: WeekViewController = {
        let weekVC = WeekViewController(presenter: self.presenter)
        weekVC.tabBarItem.icon(from: .MaterialIcon, code: "date.range",imageSize:CGSize(width: 20, height: 20),ofSize:20)
        weekVC.tabBarItem.title = "週"
		return weekVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension WeekModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
