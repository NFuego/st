//
//  CustomerInfoRouter.swift
//  Project: momoCustomer
//
//  Module: CustomerInfo
//
//  By ssstand 20/07/2017
//  MomoDidi 2017
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CustomerInfoRouter` and referenced by `CustomerInfoPresenter`
protocol CustomerInfoPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the CustomerInfo module
final class CustomerInfoRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension CustomerInfoRouter: RouterProtocol {

}

// MARK: CustomerInfo Presenter to Router Protocol

extension CustomerInfoRouter: CustomerInfoPresenterRouterProtocol {

}
