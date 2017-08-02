//
//  AppointMemberListInteractor.swift
//  Project: momoStore
//
//  Module: AppointMemberList
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointMemberListInteractor` and referenced by `AppointMemberListPresenter`
protocol AppointMemberListPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}


// MARK: -

/// The Interactor for the AppointMemberList module
struct AppointMemberListInteractor {

	// MARK: - Variables

	weak var presenter: AppointMemberListInteractorPresenterProtocol?
}

// MARK: - AppointMemberList Presenter to Interactor Protocol

extension AppointMemberListInteractor: AppointMemberListPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AppointMemberList")
	}
}
