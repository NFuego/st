//
//  OpenTimeRouter.swift
//  Project: momoStore
//
//  Module: OpenTime
//
//  By SSStand 29/12/2016
//  MomoDidi 2016
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `OpenTimeRouter` and referenced by `OpenTimePresenter`
protocol OpenTimePresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the OpenTime module
final class OpenTimeRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension OpenTimeRouter: RouterProtocol {

}

// MARK: OpenTime Presenter to Router Protocol

extension OpenTimeRouter: OpenTimePresenterRouterProtocol {

}
