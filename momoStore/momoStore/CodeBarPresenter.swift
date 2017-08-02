//
//  CodeBarPresenter.swift
//  Project: momoCustomer
//
//  Module: CodeBar
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CodeBarPresenter` and referenced by `CodeBarViewController`
protocol CodeBarViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `CodeBarPresenter` and referenced by `CodeBarInteractor`
protocol CodeBarInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the CodeBar module
final class CodeBarPresenter {

	// MARK: - Constants

	let router: CodeBarPresenterRouterProtocol
	let interactor: CodeBarPresenterInteractorProtocol

	// MARK: Variables

	weak var view: CodeBarPresenterViewProtocol?

	// MARK: Inits

	init(router: CodeBarPresenterRouterProtocol, interactor: CodeBarPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - CodeBar View to Presenter Protocol

extension CodeBarPresenter: CodeBarViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: CodeBar Interactor to Presenter Protocol

extension CodeBarPresenter: CodeBarInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
