//
//  AdvertisementRouter.swift
//  Project: T2
//
//  Module: Advertisement
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AdvertisementRouter` and referenced by `AdvertisementPresenter`
protocol AdvertisementPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the Advertisement module
final class AdvertisementRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AdvertisementRouter: RouterProtocol {

}

// MARK: Advertisement Presenter to Router Protocol

extension AdvertisementRouter: AdvertisementPresenterRouterProtocol {

}
