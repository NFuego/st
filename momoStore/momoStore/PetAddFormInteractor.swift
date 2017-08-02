//
//  PetAddFormInteractor.swift
//  Project: momoCustomer
//
//  Module: PetAddForm
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PetAddFormInteractor` and referenced by `PetAddFormPresenter`
protocol PetAddFormPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the PetAddForm module
final class PetAddFormInteractor {

	// MARK: - Variables

	weak var presenter: PetAddFormInteractorPresenterProtocol?
}

// MARK: - PetAddForm Presenter to Interactor Protocol

extension PetAddFormInteractor: PetAddFormPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "PetAddForm")
	}
}
