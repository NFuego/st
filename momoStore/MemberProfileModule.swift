//
//  MemberProfileModule.swift
//  Project: momoStore
//
//  Module: MemberProfile
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: -

/// Used to initialize the MemberProfile VIPER module
final class MemberProfileModule {

	// MARK: - Variables

	private(set) lazy var interactor: MemberProfileInteractor = {
		return MemberProfileInteractor()
	}()

	private(set) lazy var router: MemberProfileRouter = {
		return MemberProfileRouter()
	}()

	private(set) lazy var presenter: MemberProfilePresenter = {
		return MemberProfilePresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MemberProfileViewController = {
		return MemberProfileViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension MemberProfileModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
