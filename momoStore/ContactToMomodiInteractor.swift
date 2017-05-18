//
//  ContactToMomodiInteractor.swift
//  Project: momoStore
//
//  Module: ContactToMomodi
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactToMomodiInteractor` and referenced by `ContactToMomodiPresenter`
protocol ContactToMomodiPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the ContactToMomodi module
final class ContactToMomodiInteractor {

	// MARK: - Variables

	weak var presenter: ContactToMomodiInteractorPresenterProtocol?
}

// MARK: - ContactToMomodi Presenter to Interactor Protocol

extension ContactToMomodiInteractor: ContactToMomodiPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "ContactToMomodi")
	}
}
