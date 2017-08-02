//
//  AdPagerPresenter.swift
//  Project: T2
//
//  Module: AdPager
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AdPagerPresenter` and referenced by `AdPagerViewController`
protocol AdPagerViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `AdPagerPresenter` and referenced by `AdPagerInteractor`
protocol AdPagerInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the AdPager module
final class AdPagerPresenter {

	// MARK: - Constants

	let router: AdPagerPresenterRouterProtocol
	let interactor: AdPagerPresenterInteractorProtocol

	// MARK: Variables

	weak var view: AdPagerPresenterViewProtocol?

	// MARK: Inits

	init(router: AdPagerPresenterRouterProtocol, interactor: AdPagerPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - AdPager View to Presenter Protocol

extension AdPagerPresenter: AdPagerViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: AdPager Interactor to Presenter Protocol

extension AdPagerPresenter: AdPagerInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
