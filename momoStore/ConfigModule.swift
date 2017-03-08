//
//  ConfigModule.swift
//  Project: momoStore
//
//  Module: Config
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the Config VIPER module
final class ConfigModule {

	// MARK: - Variables

	private(set) lazy var interactor: ConfigInteractor = {
		return ConfigInteractor()
	}()

	private(set) lazy var router: ConfigRouter = {
		return ConfigRouter()
	}()

	private(set) lazy var presenter: ConfigPresenter = {
		return ConfigPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: ConfigViewController = {
        let configVC = ConfigViewController(presenter: self.presenter)
        configVC.tabBarItem.icon(from: .MaterialIcon, code: "settings",imageSize:CGSize(width: 20, height: 20),ofSize:20)
        configVC.tabBarItem.title = "設定"
		return configVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension ConfigModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
