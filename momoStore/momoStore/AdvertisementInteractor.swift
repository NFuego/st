//
//  AdvertisementInteractor.swift
//  Project: T2
//
//  Module: Advertisement
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AdvertisementInteractor` and referenced by `AdvertisementPresenter`
protocol AdvertisementPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the Advertisement module
final class AdvertisementInteractor {

	// MARK: - Variables

	weak var presenter: AdvertisementInteractorPresenterProtocol?
}

// MARK: - Advertisement Presenter to Interactor Protocol

extension AdvertisementInteractor: AdvertisementPresenterInteractorProtocol {
	func requestTitle() {
		presenter?.set(title: "Advertisement")
	}
}
