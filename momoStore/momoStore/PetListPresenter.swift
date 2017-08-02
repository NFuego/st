//
//  PetListPresenter.swift
//  Project: momoCustomer
//
//  Module: PetList
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PetListPresenter` and referenced by `PetListViewController`
protocol PetListViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `PetListPresenter` and referenced by `PetListInteractor`
protocol PetListInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the PetList module
final class PetListPresenter {

	// MARK: - Constants

	let router: PetListPresenterRouterProtocol
	let interactor: PetListPresenterInteractorProtocol

	// MARK: Variables

	weak var view: PetListPresenterViewProtocol?

	// MARK: Inits

	init(router: PetListPresenterRouterProtocol, interactor: PetListPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - PetList View to Presenter Protocol

extension PetListPresenter: PetListViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: PetList Interactor to Presenter Protocol

extension PetListPresenter: PetListInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
