//
//  PlanModule.swift
//  Project: momoCustomer
//
//  Module: Plan
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the Plan VIPER module
final class PlanModule {

	// MARK: - Variables
	private(set) lazy var interactor: PlanInteractor = {
		return PlanInteractor()
	}()

	private(set) lazy var router: PlanRouter = {
		return PlanRouter()
	}()

	private(set) lazy var presenter: PlanPresenter = {
		return PlanPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: PlanViewController = {
//		return PlanViewController(presenter: self.presenter)
        let monthVC = PlanViewController(presenter: self.presenter)
        monthVC.tabBarItem.icon(from: .MaterialIcon, code: "perm.contact.calendar" ,imageSize:CGSize(width: 20, height: 20),ofSize:20)
        monthVC.tabBarItem.title = "我的商店"
		return monthVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension PlanModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
