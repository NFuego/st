//
//  CodeBarInteractor.swift
//  Project: momoCustomer
//
//  Module: CodeBar
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CodeBarInteractor` and referenced by `CodeBarPresenter`
protocol CodeBarPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the CodeBar module
final class CodeBarInteractor {

	// MARK: - Variables

	weak var presenter: CodeBarInteractorPresenterProtocol?
}

// MARK: - CodeBar Presenter to Interactor Protocol

extension CodeBarInteractor: CodeBarPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "CodeBar")
	}
}
