//
//  PermissionVCInteractor.swift
//  Project: momoStore
//
//  Module: PermissionVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PermissionVCInteractor` and referenced by `PermissionVCPresenter`
protocol PermissionVCPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the PermissionVC module
final class PermissionVCInteractor {

	// MARK: - Variables

	weak var presenter: PermissionVCInteractorPresenterProtocol?
}

// MARK: - PermissionVC Presenter to Interactor Protocol

extension PermissionVCInteractor: PermissionVCPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "PermissionVC")
	}
}
