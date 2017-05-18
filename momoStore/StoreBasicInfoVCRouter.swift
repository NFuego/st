//
//  StoreBasicInfoVCRouter.swift
//  Project: momoStore
//
//  Module: StoreBasicInfoVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `StoreBasicInfoVCRouter` and referenced by `StoreBasicInfoVCPresenter`
protocol StoreBasicInfoVCPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the StoreBasicInfoVC module
final class StoreBasicInfoVCRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension StoreBasicInfoVCRouter: RouterProtocol {

}

// MARK: StoreBasicInfoVC Presenter to Router Protocol

extension StoreBasicInfoVCRouter: StoreBasicInfoVCPresenterRouterProtocol {

}
