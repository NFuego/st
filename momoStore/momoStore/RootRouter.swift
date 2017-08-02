//
//  RootRouter.swift
//  Project: momoStore
//
//  Module: Root
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `RootRouter` and referenced by `RootPresenter`
protocol RootPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the Root module
final class RootRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension RootRouter: RouterProtocol {

}

// MARK: Root Presenter to Router Protocol

extension RootRouter: RootPresenterRouterProtocol {

}
