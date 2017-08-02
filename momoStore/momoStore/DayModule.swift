//
//  DayModule.swift
//  Project: momoStore
//
//  Module: Day
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the Day VIPER module
final class DayModule {

	// MARK: - Variables

	private(set) lazy var interactor: DayInteractor = {
		return DayInteractor()
	}()

	private(set) lazy var router: DayRouter = {
		return DayRouter()
	}()

	private(set) lazy var presenter: DayPresenter = {
		return DayPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: DayViewController = {
        
        let dayVC = DayViewController(presenter: self.presenter)
        dayVC.tabBarItem.icon(from: .MaterialIcon, code: "view.day",imageSize:CGSize(width: 20, height: 20),ofSize:20)
        dayVC.tabBarItem.title = "日"
		return dayVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension DayModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
