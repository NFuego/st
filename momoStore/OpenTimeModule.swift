//
//  OpenTimeModule.swift
//  Project: momoStore
//
//  Module: OpenTime
//
//  By SSStand 29/12/2016
//  MomoDidi 2016
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the OpenTime VIPER module
final class OpenTimeModule {

	// MARK: - Variables

	private(set) lazy var interactor: OpenTimeInteractor = {
		return OpenTimeInteractor()
	}()

	private(set) lazy var router: OpenTimeRouter = {
		return OpenTimeRouter()
	}()

	private(set) lazy var presenter: OpenTimePresenter = {
		return OpenTimePresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: OpenTimeViewController = {
		return OpenTimeViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension OpenTimeModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
