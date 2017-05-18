//
//  StoreBasicInfoVCModule.swift
//  Project: momoStore
//
//  Module: StoreBasicInfoVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the StoreBasicInfoVC VIPER module
final class StoreBasicInfoVCModule {

	// MARK: - Variables

	private(set) lazy var interactor: StoreBasicInfoVCInteractor = {
		return StoreBasicInfoVCInteractor()
	}()

	private(set) lazy var router: StoreBasicInfoVCRouter = {
		return StoreBasicInfoVCRouter()
	}()

	private(set) lazy var presenter: StoreBasicInfoVCPresenter = {
		return StoreBasicInfoVCPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: StoreBasicInfoVCViewController = {
		return StoreBasicInfoVCViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension StoreBasicInfoVCModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
