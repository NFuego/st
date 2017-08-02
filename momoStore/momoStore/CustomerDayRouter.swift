//
//  CustomerDayRouter.swift
//  Project: momoCustomer
//
//  Module: CustomerDay
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CustomerDayRouter` and referenced by `CustomerDayPresenter`
protocol CustomerDayPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the CustomerDay module
final class CustomerDayRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension CustomerDayRouter: RouterProtocol {

}

// MARK: CustomerDay Presenter to Router Protocol

extension CustomerDayRouter: CustomerDayPresenterRouterProtocol {

}
