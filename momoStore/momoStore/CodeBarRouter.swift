//
//  CodeBarRouter.swift
//  Project: momoCustomer
//
//  Module: CodeBar
//
//  By zcon 2017/5/17
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `CodeBarRouter` and referenced by `CodeBarPresenter`
protocol CodeBarPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the CodeBar module
final class CodeBarRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension CodeBarRouter: RouterProtocol {

}

// MARK: CodeBar Presenter to Router Protocol

extension CodeBarRouter: CodeBarPresenterRouterProtocol {

}
