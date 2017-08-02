//
//  MemberProfilePresenter.swift
//  Project: momoStore
//
//  Module: MemberProfile
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `MemberProfilePresenter` and referenced by `MemberProfileViewController`
protocol MemberProfileViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `MemberProfilePresenter` and referenced by `MemberProfileInteractor`
protocol MemberProfileInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the MemberProfile module
final class MemberProfilePresenter {

	// MARK: - Constants

	let router: MemberProfilePresenterRouterProtocol
	let interactor: MemberProfilePresenterInteractorProtocol


	// MARK: Variables

	weak var view: MemberProfilePresenterViewProtocol?


	// MARK: Inits

	init(router: MemberProfilePresenterRouterProtocol, interactor: MemberProfilePresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - MemberProfile View to Presenter Protocol

extension MemberProfilePresenter: MemberProfileViewPresenterProtocol {

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

// MARK: MemberProfile Interactor to Presenter Protocol

extension MemberProfilePresenter: MemberProfileInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
