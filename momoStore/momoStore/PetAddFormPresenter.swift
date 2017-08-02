//
//  PetAddFormPresenter.swift
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

// MARK: Protocols

/// Should be conformed to by the `PetAddFormPresenter` and referenced by `PetAddFormViewController`
protocol PetAddFormViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `PetAddFormPresenter` and referenced by `PetAddFormInteractor`
protocol PetAddFormInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the PetAddForm module
final class PetAddFormPresenter {

	// MARK: - Constants

	let router: PetAddFormPresenterRouterProtocol
	let interactor: PetAddFormPresenterInteractorProtocol

	// MARK: Variables

	weak var view: PetAddFormPresenterViewProtocol?

	// MARK: Inits

	init(router: PetAddFormPresenterRouterProtocol, interactor: PetAddFormPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - PetAddForm View to Presenter Protocol

extension PetAddFormPresenter: PetAddFormViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: PetAddForm Interactor to Presenter Protocol

extension PetAddFormPresenter: PetAddFormInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
