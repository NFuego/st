//
//  MemberInteractor.swift
//  Project: momoStore
//
//  Module: Member
//
//  MomoDidi 2016年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `MemberInteractor` and referenced by `MemberPresenter`
protocol MemberPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the Member module
struct MemberInteractor {

	// MARK: - Variables

	weak var presenter: MemberInteractorPresenterProtocol?
}

// MARK: - Member Presenter to Interactor Protocol

extension MemberInteractor: MemberPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Member")
	}
}
