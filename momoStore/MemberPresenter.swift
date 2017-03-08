//
//  MemberPresenter.swift
//  Project: momoStore
//
//  Module: Member
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `MemberPresenter` and referenced by `MemberViewController`
protocol MemberViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `MemberPresenter` and referenced by `MemberInteractor`
protocol MemberInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the Member module
final class MemberPresenter {

	// MARK: - Constants

	let router: MemberPresenterRouterProtocol
	let interactor: MemberPresenterInteractorProtocol


	// MARK: Variables

	weak var view: MemberPresenterViewProtocol?


	// MARK: Inits

	init(router: MemberPresenterRouterProtocol, interactor: MemberPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Member View to Presenter Protocol

extension MemberPresenter: MemberViewPresenterProtocol {

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

// MARK: Member Interactor to Presenter Protocol

extension MemberPresenter: MemberInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
