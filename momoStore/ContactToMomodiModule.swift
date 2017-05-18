//
//  ContactToMomodiModule.swift
//  Project: momoStore
//
//  Module: ContactToMomodi
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the ContactToMomodi VIPER module
final class ContactToMomodiModule {

	// MARK: - Variables

	private(set) lazy var interactor: ContactToMomodiInteractor = {
		return ContactToMomodiInteractor()
	}()

	private(set) lazy var router: ContactToMomodiRouter = {
		return ContactToMomodiRouter()
	}()

	private(set) lazy var presenter: ContactToMomodiPresenter = {
		return ContactToMomodiPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: ContactToMomodiViewController = {
		return ContactToMomodiViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension ContactToMomodiModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
