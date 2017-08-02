//
//  ContactsInteractor.swift
//  Project: momoCustomer
//
//  Module: Contacts
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `ContactsInteractor` and referenced by `ContactsPresenter`
protocol ContactsPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Contacts module
struct ContactsInteractor {

	// MARK: - Variables

	weak var presenter: ContactsInteractorPresenterProtocol?
}

// MARK: - Contacts Presenter to Interactor Protocol

extension ContactsInteractor: ContactsPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Contacts")
	}
}
