//
//  WeekRouter.swift
//  Project: momoStore
//
//  Module: Week
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `WeekRouter` and referenced by `WeekPresenter`
protocol WeekPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Week module
final class WeekRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension WeekRouter: RouterProtocol {

}

// MARK: Week Presenter to Router Protocol

extension WeekRouter: WeekPresenterRouterProtocol {

}
