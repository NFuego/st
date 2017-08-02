//
//  CodeBarModule.swift
//  Project: momoCustomer
//
//  Module: CodeBar
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the CodeBar VIPER module
final class CodeBarModule {

	// MARK: - Variables

	private(set) lazy var interactor: CodeBarInteractor = {
		return CodeBarInteractor()
	}()

	private(set) lazy var router: CodeBarRouter = {
		return CodeBarRouter()
	}()

	private(set) lazy var presenter: CodeBarPresenter = {
		return CodeBarPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: CodeBarViewController = {
		return CodeBarViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension CodeBarModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
