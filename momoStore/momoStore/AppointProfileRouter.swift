//
//  AppointProfileRouter.swift
//  Project: momoStore
//
//  Module: AppointProfile
//
//  By ssstand 2017/3/11
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AppointProfileRouter` and referenced by `AppointProfilePresenter`
protocol AppointProfilePresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the AppointProfile module
final class AppointProfileRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AppointProfileRouter: RouterProtocol {

}

// MARK: AppointProfile Presenter to Router Protocol

extension AppointProfileRouter: AppointProfilePresenterRouterProtocol {

}
