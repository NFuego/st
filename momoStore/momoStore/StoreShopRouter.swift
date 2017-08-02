//
//  StoreShopRouter.swift
//  Project: momoCustomer
//
//  Module: StoreShop
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreShopRouter` and referenced by `StoreShopPresenter`
protocol StoreShopPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the StoreShop module
final class StoreShopRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension StoreShopRouter: RouterProtocol {

}

// MARK: StoreShop Presenter to Router Protocol

extension StoreShopRouter: StoreShopPresenterRouterProtocol {

}
