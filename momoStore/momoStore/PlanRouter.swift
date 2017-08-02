//
//  PlanRouter.swift
//  Project: momoCustomer
//
//  Module: Plan
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PlanRouter` and referenced by `PlanPresenter`
protocol PlanPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Plan module
final class PlanRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension PlanRouter: RouterProtocol {

}

// MARK: Plan Presenter to Router Protocol

extension PlanRouter: PlanPresenterRouterProtocol {

}
