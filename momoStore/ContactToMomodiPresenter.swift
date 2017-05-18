//
//  ContactToMomodiPresenter.swift
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

// MARK: Protocols

/// Should be conformed to by the `ContactToMomodiPresenter` and referenced by `ContactToMomodiViewController`
protocol ContactToMomodiViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `ContactToMomodiPresenter` and referenced by `ContactToMomodiInteractor`
protocol ContactToMomodiInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the ContactToMomodi module
final class ContactToMomodiPresenter {

	// MARK: - Constants

	let router: ContactToMomodiPresenterRouterProtocol
	let interactor: ContactToMomodiPresenterInteractorProtocol

	// MARK: Variables

	weak var view: ContactToMomodiPresenterViewProtocol?

	// MARK: Inits

	init(router: ContactToMomodiPresenterRouterProtocol, interactor: ContactToMomodiPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - ContactToMomodi View to Presenter Protocol

extension ContactToMomodiPresenter: ContactToMomodiViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: ContactToMomodi Interactor to Presenter Protocol

extension ContactToMomodiPresenter: ContactToMomodiInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
