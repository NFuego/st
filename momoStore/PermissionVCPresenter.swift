//
//  PermissionVCPresenter.swift
//  Project: momoStore
//
//  Module: PermissionVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PermissionVCPresenter` and referenced by `PermissionVCViewController`
protocol PermissionVCViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `PermissionVCPresenter` and referenced by `PermissionVCInteractor`
protocol PermissionVCInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the PermissionVC module
final class PermissionVCPresenter {

	// MARK: - Constants

	let router: PermissionVCPresenterRouterProtocol
	let interactor: PermissionVCPresenterInteractorProtocol

	// MARK: Variables

	weak var view: PermissionVCPresenterViewProtocol?

	// MARK: Inits

	init(router: PermissionVCPresenterRouterProtocol, interactor: PermissionVCPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - PermissionVC View to Presenter Protocol

extension PermissionVCPresenter: PermissionVCViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: PermissionVC Interactor to Presenter Protocol

extension PermissionVCPresenter: PermissionVCInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
