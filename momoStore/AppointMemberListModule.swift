//
//  AppointMemberListModule.swift
//  Project: momoStore
//
//  Module: AppointMemberList
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the AppointMemberList VIPER module
final class AppointMemberListModule {

	// MARK: - Variables

	private(set) lazy var interactor: AppointMemberListInteractor = {
		return AppointMemberListInteractor()
	}()

	private(set) lazy var router: AppointMemberListRouter = {
		return AppointMemberListRouter()
	}()

	private(set) lazy var presenter: AppointMemberListPresenter = {
		return AppointMemberListPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AppointMemberListViewController = {
		return AppointMemberListViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AppointMemberListModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
