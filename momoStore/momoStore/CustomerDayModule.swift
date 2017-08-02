//
//  CustomerDayModule.swift
//  Project: momoCustomer
//
//  Module: CustomerDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the CustomerDay VIPER module
final class CustomerDayModule {

	// MARK: - Variables

	private(set) lazy var interactor: CustomerDayInteractor = {
		return CustomerDayInteractor()
	}()

	private(set) lazy var router: CustomerDayRouter = {
		return CustomerDayRouter()
	}()

	private(set) lazy var presenter: CustomerDayPresenter = {
		return CustomerDayPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: CustomerDayViewController = {
//		return CustomerDayViewController(presenter: self.presenter)
        let monthVC = CustomerDayViewController(presenter: self.presenter)
        monthVC.tabBarItem.icon(from: .MaterialIcon, code: "perm.contact.calendar" ,imageSize:CGSize(width: 20, height: 20),ofSize:20)
        monthVC.tabBarItem.title = "今日行程"
        return monthVC
        
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension CustomerDayModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
