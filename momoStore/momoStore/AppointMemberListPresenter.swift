//
//  AppointMemberListPresenter.swift
//  Project: momoStore
//
//  Module: AppointMemberList
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER


// MARK: Protocols

/// Should be conformed to by the `AppointMemberListPresenter` and referenced by `AppointMemberListViewController`
protocol AppointMemberListViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AppointMemberListPresenter` and referenced by `AppointMemberListInteractor`
protocol AppointMemberListInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The Presenter for the AppointMemberList module
final class AppointMemberListPresenter {

	// MARK: - Constants

	let router: AppointMemberListPresenterRouterProtocol
	let interactor: AppointMemberListPresenterInteractorProtocol


	// MARK: Variables

	weak var view: AppointMemberListPresenterViewProtocol?


	// MARK: Inits

	init(router: AppointMemberListPresenterRouterProtocol, interactor: AppointMemberListPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AppointMemberList View to Presenter Protocol

extension AppointMemberListPresenter: AppointMemberListViewPresenterProtocol {

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

// MARK: AppointMemberList Interactor to Presenter Protocol

extension AppointMemberListPresenter: AppointMemberListInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
