//
//  PetAddFormModule.swift
//  Project: momoCustomer
//
//  Module: PetAddForm
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the PetAddForm VIPER module
final class PetAddFormModule {

	// MARK: - Variables

	private(set) lazy var interactor: PetAddFormInteractor = {
		return PetAddFormInteractor()
	}()

	private(set) lazy var router: PetAddFormRouter = {
		return PetAddFormRouter()
	}()

	private(set) lazy var presenter: PetAddFormPresenter = {
		return PetAddFormPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: PetAddFormViewController = {
		return PetAddFormViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension PetAddFormModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
