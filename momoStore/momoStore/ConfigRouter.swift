//
//  ConfigRouter.swift
//  Project: momoStore
//
//  Module: Config
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ConfigRouter` and referenced by `ConfigPresenter`
protocol ConfigPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Config module
final class ConfigRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension ConfigRouter: RouterProtocol {

}

// MARK: Config Presenter to Router Protocol

extension ConfigRouter: ConfigPresenterRouterProtocol {

}
