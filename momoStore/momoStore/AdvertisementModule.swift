//
//  AdvertisementModule.swift
//  Project: T2
//
//  Module: Advertisement
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the Advertisement VIPER module
final class AdvertisementModule {

	// MARK: - Variables

	private(set) lazy var interactor: AdvertisementInteractor = {
		return AdvertisementInteractor()
	}()

	private(set) lazy var router: AdvertisementRouter = {
		return AdvertisementRouter()
	}()

	private(set) lazy var presenter: AdvertisementPresenter = {
		return AdvertisementPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AdvertisementViewController = {
        return AdvertisementViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AdvertisementModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
