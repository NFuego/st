//
//  AdPagerInteractor.swift
//  Project: T2
//
//  Module: AdPager
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AdPagerInteractor` and referenced by `AdPagerPresenter`
protocol AdPagerPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the AdPager module
final class AdPagerInteractor {

	// MARK: - Variables

	weak var presenter: AdPagerInteractorPresenterProtocol?
}

// MARK: - AdPager Presenter to Interactor Protocol

extension AdPagerInteractor: AdPagerPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "AdPager")
	}
}
