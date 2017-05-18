//
//  PermissionVCRouter.swift
//  Project: momoStore
//
//  Module: PermissionVC
//
//  By zcon 2017/5/18
//  MomoDidi 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `PermissionVCRouter` and referenced by `PermissionVCPresenter`
protocol PermissionVCPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the PermissionVC module
final class PermissionVCRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension PermissionVCRouter: RouterProtocol {

}

// MARK: PermissionVC Presenter to Router Protocol

extension PermissionVCRouter: PermissionVCPresenterRouterProtocol {

}
