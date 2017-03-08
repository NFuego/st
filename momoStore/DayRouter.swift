//
//  DayRouter.swift
//  Project: momoStore
//
//  Module: Day
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `DayRouter` and referenced by `DayPresenter`
protocol DayPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Day module
final class DayRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension DayRouter: RouterProtocol {

}

// MARK: Day Presenter to Router Protocol

extension DayRouter: DayPresenterRouterProtocol {

}
