//
//  ContactsPresenter.swift
//  Project: momoCustomer
//
//  Module: Contacts
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `ContactsPresenter` and referenced by `ContactsViewController`
protocol ContactsViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `ContactsPresenter` and referenced by `ContactsInteractor`
protocol ContactsInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Contacts module
final class ContactsPresenter {

	// MARK: - Constants

	let router: ContactsPresenterRouterProtocol
	let interactor: ContactsPresenterInteractorProtocol


	// MARK: Variables

	weak var view: ContactsPresenterViewProtocol?


	// MARK: Inits

	init(router: ContactsPresenterRouterProtocol, interactor: ContactsPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Contacts View to Presenter Protocol

extension ContactsPresenter: ContactsViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}

	func viewAppearing() {

	}

	func viewAppeared() {

	}

	func viewDisappeared() {

	}
}

// MARK: Contacts Interactor to Presenter Protocol

extension ContactsPresenter: ContactsInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
