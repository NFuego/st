//
//  LoginRouter.swift
//  Project: momoCustomer
//
//  Module: Login
//
//  By zcon 2017/6/1
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `LoginRouter` and referenced by `LoginPresenter`
protocol LoginPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the Login module
final class LoginRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension LoginRouter: RouterProtocol {

}

// MARK: Login Presenter to Router Protocol

extension LoginRouter: LoginPresenterRouterProtocol {

}
