//
//  StoreMainRouter.swift
//  Project: momoCustomer
//
//  Module: StoreMain
//
//  By ssstand 2017/3/12
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreMainRouter` and referenced by `StoreMainPresenter`
protocol StoreMainPresenterRouterProtocol: PresenterRouterProtocol {

}


// MARK: -

/// The Router for the StoreMain module
final class StoreMainRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension StoreMainRouter: RouterProtocol {

}

// MARK: StoreMain Presenter to Router Protocol

extension StoreMainRouter: StoreMainPresenterRouterProtocol {

}
