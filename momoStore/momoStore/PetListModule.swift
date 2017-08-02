//
//  PetListModule.swift
//  Project: momoCustomer
//
//  Module: PetList
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the PetList VIPER module
final class PetListModule {

	// MARK: - Variables

	private(set) lazy var interactor: PetListInteractor = {
		return PetListInteractor()
	}()

	private(set) lazy var router: PetListRouter = {
		return PetListRouter()
	}()

	private(set) lazy var presenter: PetListPresenter = {
		return PetListPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: PetListViewController = {
//		return PetListViewController(presenter: self.presenter)
        
        let monthVC = PetListViewController(presenter: self.presenter)
        monthVC.tabBarItem.icon(from: .MaterialIcon, code: "today",imageSize:CGSize(width: 20, height: 20),ofSize:20)
        monthVC.tabBarItem.title = "寵物"
		return monthVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension PetListModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
