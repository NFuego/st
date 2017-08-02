//
//  AdPagerModule.swift
//  Project: T2
//
//  Module: AdPager
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the AdPager VIPER module
final class AdPagerModule {

	// MARK: - Variables

	private(set) lazy var interactor: AdPagerInteractor = {
		return AdPagerInteractor()
	}()

	private(set) lazy var router: AdPagerRouter = {
		return AdPagerRouter()
	}()

	private(set) lazy var presenter: AdPagerPresenter = {
		return AdPagerPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: AdPagerViewController = {
		return AdPagerViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension AdPagerModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
