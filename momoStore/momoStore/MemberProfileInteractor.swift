//
//  MemberProfileInteractor.swift
//  Project: momoStore
//
//  Module: MemberProfile
//
//  MomoDidi 2016年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `MemberProfileInteractor` and referenced by `MemberProfilePresenter`
protocol MemberProfilePresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the MemberProfile module
struct MemberProfileInteractor {

	// MARK: - Variables

	weak var presenter: MemberProfileInteractorPresenterProtocol?
}

// MARK: - MemberProfile Presenter to Interactor Protocol

extension MemberProfileInteractor: MemberProfilePresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "MemberProfile")
	}
}
