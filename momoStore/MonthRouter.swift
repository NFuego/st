//
//  MonthRouter.swift
//  Project: momoStore
//
//  Module: Month
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MonthRouter` and referenced by `MonthPresenter`
protocol MonthPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Month module
final class MonthRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension MonthRouter: RouterProtocol {

}

// MARK: Month Presenter to Router Protocol

extension MonthRouter: MonthPresenterRouterProtocol {

}
